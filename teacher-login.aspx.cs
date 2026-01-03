using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.UI;

public partial class teacher_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { }

    protected async void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            ShowAlert("Username and password are required.", "error");
            return;
        }

        var loginObj = new
        {
            username = username,
            password = password
        };

        try
        {
            ApiResponse apiResponse = await ApiHelper.PostAsync("api/Teacher/login", loginObj, HttpContext.Current);

            if (apiResponse == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            string code = apiResponse.response_code == null ? "" : apiResponse.response_code.Trim();

            if (code == "200")
            {
                // Ensure auth token exists (API may return via header; fall back to generated token)
                string token = Session["authToken"] == null ? Guid.NewGuid().ToString() : Session["authToken"].ToString();
                Session["authToken"] = token;

                // Persist token to cookie for safety
                HttpCookie cookie = new HttpCookie("authToken", token);
                cookie.HttpOnly = true;
                cookie.Expires = DateTime.Now.AddHours(8);
                Response.Cookies.Add(cookie);

                // Store teacher info for header display (best-effort)
                Session["TeacherName"] = username;
                Session["TeacherEmail"] = username;

                // Also set keys used by existing dashboard code
                Session["userName"] = username;
                if (Session["userId"] == null)
                    Session["userId"] = "0";

                string js =
                "Swal.fire({" +
                "  title: 'Success'," +
                "  text: 'Login Successful'," +
                "  icon: 'success'," +
                "  timer: 1800," +
                "  timerProgressBar: true," +
                "  showConfirmButton: false" +
                "}).then(() => {" +
                "  window.location='Dashboard/dashboard-teachers.aspx';" +
                "});";

                ScriptManager.RegisterStartupScript(this, GetType(), "loginSuccess", js, true);
                return;
            }

            string msg = "Login failed";
            if (apiResponse.obj != null)
                msg = apiResponse.obj.ToString();

            ShowAlert(msg, "error");
        }
        catch (Exception ex)
        {
            ShowAlert("Error: " + ex.Message, "error");
        }
    }

    private void ShowAlert(string message, string type)
    {
        message = message.Replace("'", "");

        string script = "Swal.fire({" +
                        "title: '" + (type == "success" ? "Success" : "Error") + "'," +
                        "text: '" + message + "'," +
                        "icon: '" + type + "'" +
                        "});";

        ScriptManager.RegisterStartupScript(this, GetType(), "swalAlert", script, true);
    }
}
