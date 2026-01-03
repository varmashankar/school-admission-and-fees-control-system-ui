using Newtonsoft.Json;
using System;
using System.IO;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

public partial class Dashboard_admin_addnewschool : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            Response.Redirect("~/login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
    }

    protected async void btnSaveSchool_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txtSchoolName.Text.Trim();
            string code = txtCode.Text.Trim();
            string address = txtAddress.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(name))
            {
                ShowMessage("School Name is required.", "warning");
                return;
            }

            string logoPath = null;
            if (fuLogo.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuLogo.FileName);
                    string fileName = Guid.NewGuid().ToString() + ext;
                    // Save into uploads/schools folder and create it if missing
                    string folder = Server.MapPath("~/uploads/schools/");
                    Directory.CreateDirectory(folder);
                    string fullPath = Path.Combine(folder, fileName);
                    fuLogo.SaveAs(fullPath);
                    logoPath = "/uploads/schools/" + fileName;
                }
                catch (Exception ex)
                {
                    ShowMessage("Logo upload failed: " + ex.Message, "danger");
                    return;
                }
            }

            var model = new
            {
                school_name = name,
                code = code,
                address = address,
                phone = phone,
                email = email,
                logo_path = logoPath,
                deleted = false,
                status = true
            };

            ApiResponse res = await ApiHelper.PostAsync("api/School/saveSchool", model, HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                ShowMessage("School saved successfully.", "success");
                Response.Redirect("schools.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                // Provide detailed info for debugging
                string apiCode = res == null ? "(no response)" : (res.response_code ?? "(no code)");
                string apiObj = "(null)";
                try
                {
                    if (res != null && res.obj != null)
                        apiObj = JsonConvert.SerializeObject(res.obj);
                }
                catch { apiObj = "(serialize failed)"; }

                string msg = "Failed to save school. API returned: " + apiCode + " - " + apiObj;
                ShowMessage(msg, "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    private void ShowMessage(string message, string type)
    {
        if (message == null) message = string.Empty;

        message = message.Replace("\\", "\\\\")
                         .Replace("'", "\\'")
                         .Replace("\"", "\\\"")
                         .Replace("\r", "")
                         .Replace("\n", " ");

        string icon = "info";
        if (type == "danger") icon = "error";
        if (type == "warning") icon = "warning";
        if (type == "success") icon = "success";

        string key = "alert_" + Guid.NewGuid().ToString("N");
        string script = "Swal.fire('" + message + "', '', '" + icon + "');";

        ClientScript.RegisterStartupScript(this.GetType(), key, script, true);
    }
}
