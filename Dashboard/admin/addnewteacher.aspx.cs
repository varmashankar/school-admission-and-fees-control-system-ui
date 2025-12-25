using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_addnewteacher : System.Web.UI.Page
{
    // -----------------------------------------------------------
    // PAGE LOAD
    // -----------------------------------------------------------
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
            LoadDepartmentList();
            await GenerateTeacherId();
        }
    }


    // -----------------------------------------------------------
    // LOAD DEPARTMENT DROPDOWN
    // -----------------------------------------------------------
    private void LoadDepartmentList()
    {
        ddlDepartment.Items.Clear();
        ddlDepartment.Items.Add(new ListItem("-- Select Department --", ""));

        // TEMPORARY (Replace with API if needed)
        ddlDepartment.Items.Add(new ListItem("Mathematics", "1"));
        ddlDepartment.Items.Add(new ListItem("Science", "2"));
        ddlDepartment.Items.Add(new ListItem("English", "3"));
        ddlDepartment.Items.Add(new ListItem("Social Studies", "4"));
        ddlDepartment.Items.Add(new ListItem("Computer Science", "5"));
    }


    // -----------------------------------------------------------
    // GENERATE TEACHER ID → T-2025-016
    // -----------------------------------------------------------
    private async Task GenerateTeacherId()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Teacher/generateTeacherId", new { }, HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                txtTeacherId.Text = res.obj == null ? "" : res.obj.ToString();
            }
            else
            {
                txtTeacherId.Text = "";
                ShowMessage("Unable to generate Admission ID", "warning");
            }
        }
        catch (Exception ex)
        {
            txtTeacherId.Text = "";
            ShowMessage("Error generating Teacher ID: " + ex.Message, "danger");
        }
    }


    // -----------------------------------------------------------
    // SAVE TEACHER
    // -----------------------------------------------------------
    protected async void btnSaveTeacher_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["authToken"] == null)
            {
                ShowMessage("Authentication token missing. Please login again.", "danger");
                return;
            }

            // ------------------ VALIDATION ------------------
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
            if (txtEmail.Text.Trim() == "")
            {
                ShowMessage("Email is required.", "warning");
                return;
            }
            
            if (ddlDepartment.SelectedValue == "")
            {
                ShowMessage("Department is required.", "warning");
                return;
            }

            // ------------------ BUILD TEACHER OBJECT ------------------
            var teacher = new
            {
                teacherId = txtTeacherId.Text.Trim(),

                firstname = txtFirstName.Text.Trim(),
                middlename = txtMiddleName.Text.Trim(),
                lastname = txtLastName.Text.Trim(),
                email = txtEmail.Text.Trim(),
                mobile = txtMobile.Text.Trim(),
                password = txtMobile.Text.Trim(),

                dob = txtDob.Text,
                gender = ddlGender.SelectedValue,
                nationality = txtNationality.Text.Trim(),
                religion = txtReligion.Text.Trim(),
                nationIdNumber = txtNationalId.Text.Trim(),

                dateOfJoining = txtJoiningDate.Text,
                designation = txtDesignation.Text.Trim(),

                departmentId = ddlDepartment.SelectedValue,
                primarySubject = txtPrimarySubject.Text.Trim(),
                experienceYears = txtExperienceYears.Text.Trim(),

                deleted = false,
                status = true
            };

            // ------------------ SEND TO API ------------------
            ApiResponse apiRes = await ApiHelper.PostAsync("api/Teacher/saveTeachers", teacher, HttpContext.Current);

            if (apiRes == null)
            {
                ShowMessage("No response from server.", "danger");
                return;
            }

            if (apiRes.response_code == "200")
            {
                string tid = txtTeacherId.Text.Trim();

                // SweetAlert with Yes/No
                string script = @"
                Swal.fire({
                    title: 'Success',
                    text: 'Teacber created successfully!',
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonText: 'Add More Details',
                    cancelButtonText: 'Add Another Teacher'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = 'addteachedetails.aspx?sid=" + tid + @"';
                    } else {
                        window.location = 'addnewteacher.aspx';
                    }
                });
            ";

                ScriptManager.RegisterStartupScript(this, GetType(), "teacherSuccess", script, true);
            }
            else
            {
                ShowMessage("Failed: " + apiRes.obj, "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }


    // -----------------------------------------------------------
    // SWEETALERT MESSAGE
    // -----------------------------------------------------------
    private void ShowMessage(string message, string type)
    {
        if (message == null) message = "";

        message = message.Replace("\\", "\\\\")
                         .Replace("'", "\\'")
                         .Replace("\"", "\\\"")
                         .Replace("\r", "")
                         .Replace("\n", " ");

        string icon = "info";
        if (type == "danger") icon = "error";
        if (type == "warning") icon = "warning";
        if (type == "success") icon = "success";

        string script = "Swal.fire('" + message + "', '', '" + icon + "');";

        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }
}