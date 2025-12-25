using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.UI;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected async void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            ShowAlert("Username and password are required.", "error");
            return;
        }

        // Match API model casing (API expects: username/password)
        var loginObj = new
        {
            username = username,
            password = password
        };

        try
        {
            ApiResponse apiResponse = await ApiHelper.PostAsync("api/Admin/login", loginObj, HttpContext.Current);

            if (apiResponse == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            string code = apiResponse.response_code == null ? "" : apiResponse.response_code.Trim();

            // SUCCESS
            if (code == "200" && Session["authToken"] != null)
            {
                string js =
                "Swal.fire({" +
                "  title: 'Success'," +
                "  text: 'Login Successful'," +
                "  icon: 'success'," +
                "  timer: 1800," +
                "  timerProgressBar: true," +
                "  showConfirmButton: false" +
                "}).then(() => {" +
                "  window.location='dashboard/dashboard-admin.aspx';" +
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
