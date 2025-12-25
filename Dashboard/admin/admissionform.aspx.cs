using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;

public partial class Dashboard_admin_admissionform : System.Web.UI.Page
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            Response.Redirect("~/login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
        {
            await LoadClassList();
            await LoadAdmissionIdFromApi();
            await LoadStudentIdFromApi();
        }
    }

    private async Task LoadClassList()
    {
        ddlClass.Items.Clear();
        ddlClass.Items.Add(new ListItem("-- Select Class --", ""));

        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Classes/getClassList", new { }, HttpContext.Current);

            if(res != null && res.response_code == "200" && res.obj != null)
            {
                var classList = Newtonsoft.Json.JsonConvert.DeserializeObject < List < Dictionary<string, object>>>(res.obj.ToString());

                foreach (var item in classList)
                {
                    // Safe read of id
                    string id = item.ContainsKey("id") && item["id"] != null
                                ? item["id"].ToString()
                                : "";

                    // Safe read of class name
                    string className = item.ContainsKey("className") && item["className"] != null
                                       ? item["className"].ToString()
                                       : "";

                    // Safe read of section (optional)
                    string section = item.ContainsKey("section") && item["section"] != null
                                     ? item["section"].ToString()
                                     : "";

                    string displayText = section != ""
                                            ? className + " " + section
                                            : className;

                    ddlClass.Items.Add(new ListItem(displayText, id));
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error generating Admission ID: " + ex.Message, "danger");
        }
    }

    // ---------------------------------------------
    // GET NEW ADMISSION ID FROM BACKEND
    // ---------------------------------------------
    private async Task LoadAdmissionIdFromApi()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Students/generateAdmissionId", new { }, HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                hfAdmissionId.Value = res.obj == null ? "" : res.obj.ToString();
            }
            else
            {
                ShowMessage("Unable to generate Admission ID", "warning");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error generating Admission ID: " + ex.Message, "danger");
        }
    }

    // ---------------------------------------------
    // GET NEW STUDENT ID (STU-YYYY-0001)
    // ---------------------------------------------
    private async Task LoadStudentIdFromApi()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Students/generateStudentId", new { }, HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                hfStudentId.Value = res.obj == null ? "" : res.obj.ToString();
            }
            else
            {
                ShowMessage("Unable to generate Student ID", "warning");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error generating Student ID: " + ex.Message, "danger");
        }
    }

    // ---------------------------------------------
    // SAVE STUDENT STEP-1
    // ---------------------------------------------
    protected async void btnSaveStep1_Click(object sender, EventArgs e)
    {
        try
        {
            string token = Session["authToken"] == null ? null : Session["authToken"].ToString();

            if (string.IsNullOrEmpty(token))
            {
                ShowMessage("Authentication token missing. Please login again.", "danger");
                return;
            }

            // Manual validation
            if (txtFirstName.Text.Trim() == "")
            {
                ShowMessage("First Name is required.", "warning");
                return;
            }

            if (txtLastName.Text.Trim() == "")
            {
                ShowMessage("Last Name is required.", "warning");
                return;
            }

            if (ddlClass.SelectedValue.Trim() == "")
            {
                ShowMessage("Please select a class.", "warning");
                return;
            }

            // Build student object EXACTLY as backend expects
            var student = new
            {
                studentCode = hfStudentId.Value.Trim(),         // STU-YYYY-XXXX
                admissionNo = hfAdmissionId.Value.Trim(),     // ADM-YYYY-XXXX

                firstName = txtFirstName.Text.Trim(),
                middleName = txtMiddleName.Text.Trim(),
                lastName = txtLastName.Text.Trim(),
                dob = txtDob.Text,
                gender = ddlGender.SelectedValue,
                bloodGroup = ddlBloodGroup.SelectedValue,
                nationality = txtNationality.Text.Trim(),
                religion = txtReligion.Text.Trim(),
                nationIdNumber = txtAadhar.Text.Trim(),
                email = txtEmail.Text.Trim(),
                phone = txtPhone.Text.Trim(),
                admissionDate = txtAdmissionDate.Text, // Correct spelling

                classId = ddlClass.SelectedValue,

                siblingInfo = txtSiblingInfo.Text.Trim(),
                address = txtAddress.Text.Trim(),
                medicalInfo = txtMedicalInfo.Text.Trim(),

                deleted = false,
                status = true
            };

            ApiResponse apiRes = await ApiHelper.PostAsync("api/Students/saveStudents", student, HttpContext.Current);

            if (apiRes == null)
            {
                ShowMessage("No response from server.", "danger");
                return;
            }

            if (apiRes.response_code == "200")
            {
                string sid = CryptoHelper.Encrypt(hfStudentId.Value.Trim()); // studentId just created

                // SweetAlert with Yes/No
                string script = @"
                Swal.fire({
                    title: 'Success',
                    text: 'The student record has been saved successfully.',
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonText: 'Add Student Details',
                    cancelButtonText: 'Add Another Student'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = 'addstudentdetails.aspx?sid=" + sid + @"';
                    } else {
                        window.location = 'admissionform.aspx';
                    }
                });
            ";

                ScriptManager.RegisterStartupScript(this, GetType(), "studentSuccess", script, true);
            }
            else
            {
                string message = apiRes.obj == null ? "Unknown error" : apiRes.obj.ToString();
                ShowMessage("Failed: " + message, "danger");
            }

        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }


    // ---------------------------------------------
    // ALERT POPUP
    // ---------------------------------------------
    private void ShowMessage(string message, string type)
    {
        if (message == null) message = "";

        // FULL SANITIZATION FOR JS STRING
        message = message.Replace("\\", "\\\\")
                         .Replace("'", "\\'")
                         .Replace("\"", "\\\"")
                         .Replace("\r", "")
                         .Replace("\n", " ");

        string script = "Swal.fire('" + type.ToUpper() + "', '" + message + "', '" + type + "');";

        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }


    // ---------------------------------------------
    // CLEAR FORM
    // ---------------------------------------------
    private void ClearForm()
    {
        txtFirstName.Text = "";
        txtMiddleName.Text = "";
        txtLastName.Text = "";
        txtDob.Text = "";
        ddlGender.SelectedIndex = 0;
        ddlBloodGroup.SelectedIndex = 0;
        txtNationality.Text = "";
        txtReligion.Text = "";
        txtAadhar.Text = "";
        txtEmail.Text = "";
        txtPhone.Text = "";
        txtAdmissionDate.Text = "";
        ddlClass.SelectedIndex = 0;
        ddlTransport.SelectedIndex = 0;
        txtSiblingInfo.Text = "";
        txtAddress.Text = "";
        txtMedicalInfo.Text = "";
    }
}
