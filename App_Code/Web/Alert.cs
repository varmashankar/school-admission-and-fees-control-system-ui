using System;
using System.Web.UI;

public static class Alert
{
    public static void Show(Page page, string message, string type)
    {
        if (page == null)
            return;

        if (message == null)
            message = string.Empty;

        message = message.Replace("\\", "\\\\")
                         .Replace("'", "\\'")
                         .Replace("\"", "\\\"")
                         .Replace("\r", string.Empty)
                         .Replace("\n", " ");

        string safeType = string.IsNullOrEmpty(type) ? "info" : type;
        string title = safeType.ToUpperInvariant();

        string script = "Swal.fire('" + title + "', '" + message + "', '" + safeType + "');";
        ScriptManager.RegisterStartupScript(page, page.GetType(), Guid.NewGuid().ToString(), script, true);
    }
}
