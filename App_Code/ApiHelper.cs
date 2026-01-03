using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

public static class ApiHelper
{
    private const string TokenHeaderName = "token";

    private static readonly HttpClient _httpClient = new HttpClient()
    {
        Timeout = TimeSpan.FromSeconds(100)
    };

    private static string GetBaseUrl()
    {
        string v = System.Configuration.ConfigurationManager.AppSettings["API_BASE_URL"];
        v = string.IsNullOrWhiteSpace(v) ? "https://localhost:44342/" : v.Trim();

        // Normalize to ensure a trailing slash (safe Uri combination)
        if (!v.EndsWith("/", StringComparison.Ordinal))
            v += "/";

        return v;
    }

    public static Task<ApiResponse> PostAsync(string relativeUrl, object payload)
    {
        return PostAsync(relativeUrl, payload, HttpContext.Current);
    }

    public static async Task<ApiResponse> PostAsync(string relativeUrl, object payload, HttpContext context)
    {
        if (context == null)
            context = HttpContext.Current;

        Uri requestUri;
        try
        {
            requestUri = BuildUri(relativeUrl);
        }
        catch (Exception)
        {
            return new ApiResponse
            {
                response_code = "400",
                obj = "Invalid API URL. Check API_BASE_URL and request path."
            };
        }

        string json = JsonConvert.SerializeObject(payload ?? new { });

        using (var request = new HttpRequestMessage(HttpMethod.Post, requestUri))
        {
            request.Content = new StringContent(json, Encoding.UTF8, "application/json");
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            // attach token from Session (classic null check - WebForms safe)
            string token = TryGetTokenFromSession(context);
            if (!string.IsNullOrEmpty(token))
            {
                TryAddHeader(request, TokenHeaderName, token);
            }

            HttpResponseMessage response;
            try
            {
                response = await _httpClient.SendAsync(request).ConfigureAwait(false);
            }
            catch
            {
                return new ApiResponse
                {
                    response_code = "503",
                    obj = "Unable to reach server. Please try again."
                };
            }

            // Read token from response headers (refresh pattern)
            TryUpdateTokenFromResponse(context, response);

            string respStr = response.Content == null ? null : await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            ApiResponse apiResp = null;
            try
            {
                // try to deserialize standard ApiResponse payload
                apiResp = JsonConvert.DeserializeObject<ApiResponse>(respStr);
            }
            catch
            {
                // ignore deserialization errors
                apiResp = null;
            }

            // If deserialization failed or returned incomplete fields, populate fallback info
            if (apiResp == null)
            {
                apiResp = new ApiResponse
                {
                    response_code = response.IsSuccessStatusCode ? "200" : ((int)response.StatusCode).ToString(),
                    obj = string.IsNullOrEmpty(respStr) ? (object)null : respStr
                };
            }
            else
            {
                // ensure response_code is always set
                if (string.IsNullOrWhiteSpace(apiResp.response_code))
                    apiResp.response_code = response.IsSuccessStatusCode ? "200" : ((int)response.StatusCode).ToString();

                // if obj is null but we have raw response, set obj to raw string for debugging
                if (apiResp.obj == null && !string.IsNullOrEmpty(respStr))
                    apiResp.obj = respStr;
            }

            // If API indicates auth/access problems, clear token centrally
            if (apiResp != null)
            {
                string code = (apiResp.response_code ?? string.Empty).Trim();
                if (code == "215" || code == "401" || code == "403")
                {
                    TryClearToken(context);
                }
            }

            return apiResp;
        }
    }

    private static Uri BuildUri(string relativeOrAbsoluteUrl)
    {
        if (string.IsNullOrWhiteSpace(relativeOrAbsoluteUrl))
            throw new ArgumentException("URL is required.");

        relativeOrAbsoluteUrl = relativeOrAbsoluteUrl.Trim();

        // Allow absolute URLs (useful for testing or special endpoints)
        Uri absolute;
        if (Uri.TryCreate(relativeOrAbsoluteUrl, UriKind.Absolute, out absolute))
            return absolute;

        // Normalize relative URL
        while (relativeOrAbsoluteUrl.StartsWith("/", StringComparison.Ordinal))
            relativeOrAbsoluteUrl = relativeOrAbsoluteUrl.Substring(1);

        return new Uri(new Uri(GetBaseUrl(), UriKind.Absolute), relativeOrAbsoluteUrl);
    }

    private static string TryGetTokenFromSession(HttpContext context)
    {
        try
        {
            if (context != null && context.Session != null)
            {
                object tok = context.Session["authToken"];
                return tok == null ? null : tok.ToString();
            }
        }
        catch
        {
            // ignore
        }
        return null;
    }

    private static void TryUpdateTokenFromResponse(HttpContext context, HttpResponseMessage response)
    {
        try
        {
            if (context == null || context.Session == null || response == null)
                return;

            if (response.Headers != null && response.Headers.Contains(TokenHeaderName))
            {
                string newToken = response.Headers.GetValues(TokenHeaderName).FirstOrDefault();
                if (!string.IsNullOrEmpty(newToken))
                {
                    context.Session["authToken"] = newToken;
                }
            }
        }
        catch
        {
            // ignore
        }
    }

    private static void TryClearToken(HttpContext context)
    {
        try
        {
            if (context != null && context.Session != null)
                context.Session.Remove("authToken");
        }
        catch
        {
            // ignore
        }
    }

    private static void TryAddHeader(HttpRequestMessage request, string name, string value)
    {
        try
        {
            if (request == null || string.IsNullOrEmpty(name) || string.IsNullOrEmpty(value))
                return;

            if (!request.Headers.Contains(name))
                request.Headers.Add(name, value);
        }
        catch
        {
            // ignore
        }
    }
}