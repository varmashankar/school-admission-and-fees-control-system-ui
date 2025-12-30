using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_inquiry_create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            Response.Redirect("~/login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
        {
            txtNextFollowUpAt.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-ddTHH:mm");
            RegisterAsyncTask(new PageAsyncTask(LoadDropdowns));
        }
    }

    private async System.Threading.Tasks.Task LoadDropdowns()
    {
        InquiryCaptureHelper.BindDropdownFromList(ddlClass, "-- Select Class --");
        InquiryCaptureHelper.BindDropdownFromList(ddlStream, "-- Select Stream --");

        try
        {
            var classRes = await ApiHelper.PostAsync("api/Classes/getClassList", new { }, HttpContext.Current);
            if (classRes != null && classRes.response_code == "200" && classRes.obj != null)
            {
                foreach (var x in InquiryCaptureHelper.DeserializeList(classRes.obj))
                {
                    object v, n, s;
                    var id = x.TryGetValue("id", out v) ? Convert.ToString(v) : null;
                    var className = x.TryGetValue("className", out n) ? Convert.ToString(n) : (x.TryGetValue("class_name", out n) ? Convert.ToString(n) : null);
                    var section = x.TryGetValue("section", out s) ? Convert.ToString(s) : null;
                    
                    // Combine className and section for display
                    var displayName = className;
                    if (!string.IsNullOrWhiteSpace(section))
                    {
                        displayName = className + " - " + section;
                    }
                    
                    if (!string.IsNullOrWhiteSpace(id) && !string.IsNullOrWhiteSpace(displayName))
                        ddlClass.Items.Add(new System.Web.UI.WebControls.ListItem(displayName, id));
                }
            }

            var streamRes = await ApiHelper.PostAsync("api/Streams/getStreamList", new { }, HttpContext.Current);
            if (streamRes != null && streamRes.response_code == "200" && streamRes.obj != null)
            {
                foreach (var x in InquiryCaptureHelper.DeserializeList(streamRes.obj))
                {
                    object v, n;
                    var id = x.TryGetValue("id", out v) ? Convert.ToString(v) : null;
                    var name = x.TryGetValue("streamName", out n) ? Convert.ToString(n) : (x.TryGetValue("stream_name", out n) ? Convert.ToString(n) : null);
                    if (!string.IsNullOrWhiteSpace(id) && !string.IsNullOrWhiteSpace(name))
                        ddlStream.Items.Add(new System.Web.UI.WebControls.ListItem(name, id));
                }
            }
        }
        catch (Exception ex)
        {
            lblInfo.Text = "Error loading dropdowns: " + ex.Message;
            lblInfo.CssClass = "text-danger small";
        }
    }

    private bool ValidateRequired(out string message)
    {
        var firstName = InquiryCaptureHelper.Require(txtFirstName.Text);
        var lastName = InquiryCaptureHelper.Require(txtLastName.Text);
        var phone = InquiryCaptureHelper.RequirePhone(txtPhone.Text);
        var email = InquiryCaptureHelper.Require(txtEmail.Text);
        var source = InquiryCaptureHelper.Require(txtSource.Text);

        if (string.IsNullOrWhiteSpace(firstName)) { message = "First name is required."; return false; }
        if (string.IsNullOrWhiteSpace(lastName)) { message = "Last name is required."; return false; }
        if (string.IsNullOrWhiteSpace(phone)) { message = "Phone is required."; return false; }
        if (string.IsNullOrWhiteSpace(email)) { message = "Email is required."; return false; }
        if (string.IsNullOrWhiteSpace(source)) { message = "Source is required."; return false; }
        if (string.IsNullOrWhiteSpace(ddlClass.SelectedValue)) { message = "Class is required."; return false; }
        if (string.IsNullOrWhiteSpace(ddlStream.SelectedValue)) { message = "Stream is required."; return false; }

        message = null;
        return true;
    }

    private async System.Threading.Tasks.Task<bool> SaveInquiryAsync()
    {
        string message;
        if (!ValidateRequired(out message))
        {
            message = message.Replace("'", "\\'");
            ScriptManager.RegisterStartupScript(this, GetType(), "bad", "Swal.fire('ERROR','" + message + "','error');", true);
            return false;
        }

        var payload = new
        {
            id = (long?)null,
            inquiryNo = (string)null,
            firstName = InquiryCaptureHelper.Require(txtFirstName.Text),
            lastName = InquiryCaptureHelper.Require(txtLastName.Text),
            phone = InquiryCaptureHelper.RequirePhone(txtPhone.Text),
            email = InquiryCaptureHelper.Require(txtEmail.Text),
            classId = InquiryCaptureHelper.ParseLong(ddlClass.SelectedValue),
            streamId = InquiryCaptureHelper.ParseLong(ddlStream.SelectedValue),
            source = InquiryCaptureHelper.Require(txtSource.Text),
            notes = InquiryCaptureHelper.Require(txtNotes.Text),
            status = "NEW",
            nextFollowUpAt = InquiryCaptureHelper.ParseDateTimeLocal(txtNextFollowUpAt.Text),
            convertedStudentId = (long?)null,
            createdById = (long?)null,
            roleId = (long?)null
        };

        var res = await ApiHelper.PostAsync("api/Inquiries/saveInquiry", payload, HttpContext.Current);
        if (res != null && res.response_code == "200")
        {
            return true;
        }

        var err = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to save inquiry.";
        err = err.Replace("'", "\\'");
        ScriptManager.RegisterStartupScript(this, GetType(), "err", "Swal.fire('ERROR','" + err + "','error');", true);
        return false;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(async () =>
        {
            var success = await SaveInquiryAsync();
            if (success)
            {
                // Redirect to inquiries list after successful save
                ScriptManager.RegisterStartupScript(this, GetType(), "ok", 
                    "Swal.fire({icon:'success',title:'SUCCESS',text:'Inquiry saved successfully.',confirmButtonColor:'#6366f1'}).then(function(){window.location.href='inquiries.aspx';});", true);
            }
        }));
    }

    protected void btnSaveAndNew_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(async () =>
        {
            var success = await SaveInquiryAsync();
            if (success)
            {
                // Clear form and stay on page for new entry
                ClearForm(keepDefaults: true);
                ScriptManager.RegisterStartupScript(this, GetType(), "ok", 
                    "Swal.fire({icon:'success',title:'SUCCESS',text:'Inquiry saved. You can now create another.',confirmButtonColor:'#6366f1'});", true);
            }
        }));
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearForm(keepDefaults: true);
    }

    private void ClearForm(bool keepDefaults)
    {
        txtFirstName.Text = string.Empty;
        txtLastName.Text = string.Empty;
        txtPhone.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtSource.Text = string.Empty;
        txtNotes.Text = string.Empty;

        if (ddlClass.Items.Count > 0) ddlClass.SelectedIndex = 0;
        if (ddlStream.Items.Count > 0) ddlStream.SelectedIndex = 0;

        if (keepDefaults)
            txtNextFollowUpAt.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-ddTHH:mm");
        else
            txtNextFollowUpAt.Text = string.Empty;

        lblInfo.Text = string.Empty;
    }
}
