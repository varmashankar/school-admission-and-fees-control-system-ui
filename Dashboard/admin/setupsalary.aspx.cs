using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_setupsalary : System.Web.UI.Page
{
    private SalaryManagementService _salaryService = new SalaryManagementService();

    protected void Page_Load(object sender, EventArgs e)
    {
        this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

        if (!IsPostBack)
        {
            // If a TeacherID is passed via query string (e.g., from "Collect Fee" button)
            if (!string.IsNullOrEmpty(Request.QueryString["teacherId"]))
            {
                int teacherId;
                if (int.TryParse(Request.QueryString["teacherId"], out teacherId))
                {
                    LoadTeachersIntoDropdown();
                    ddlSelectTeacher.SelectedValue = teacherId.ToString();
                    LoadTeacherSalaryDetails(teacherId);
                }
            }
            else
            {
                LoadTeachersIntoDropdown();
            }
        }
    }

    private void LoadTeachersIntoDropdown()
    {
        // Get all teachers from your service
        List<Teacher> teachers = _salaryService.GetAllTeachers(); // Assuming a method to get all teachers

        ddlSelectTeacher.DataSource = teachers;
        ddlSelectTeacher.DataTextField = "TeacherName"; // Display teacher name
        ddlSelectTeacher.DataValueField = "TeacherID"; // Use teacher ID as value
        ddlSelectTeacher.DataBind();
        ddlSelectTeacher.Items.Insert(0, new ListItem("-- Select a Teacher --", ""));
    }

    protected void btnSearchTeacher_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearchTeacher.Text.Trim();
        if (!string.IsNullOrEmpty(searchTerm))
        {
            List<Teacher> searchResults = _salaryService.SearchTeachers(searchTerm); // Implement this method in your service
            ddlSelectTeacher.DataSource = searchResults;
            ddlSelectTeacher.DataTextField = "TeacherName";
            ddlSelectTeacher.DataValueField = "TeacherID";
            ddlSelectTeacher.DataBind();

            // If only one result, select it and load details
            if (searchResults.Count == 1)
            {
                ddlSelectTeacher.SelectedValue = searchResults[0].TeacherID.ToString();
                LoadTeacherSalaryDetails(searchResults[0].TeacherID);
            }
            else if (searchResults.Count > 1)
            {
                ddlSelectTeacher.Items.Insert(
                0,
                new ListItem("-- " + searchResults.Count + " Teachers Found --", "")
            );

                pnlSalaryDetails.Visible = false; // Hide details if multiple results or none
            }
            else
            {
                ddlSelectTeacher.Items.Insert(0, new ListItem("-- No Teachers Found --", ""));
                pnlSalaryDetails.Visible = false;
            }
        }
        else
        {
            LoadTeachersIntoDropdown(); // If search box is empty, load all
            pnlSalaryDetails.Visible = false;
        }
    }

    protected void ddlSelectTeacher_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(ddlSelectTeacher.SelectedValue))
        {
            int teacherId = Convert.ToInt32(ddlSelectTeacher.SelectedValue);
            LoadTeacherSalaryDetails(teacherId);
        }
        else
        {
            pnlSalaryDetails.Visible = false;
        }
    }

    private void LoadTeacherSalaryDetails(int teacherId)
    {
        TeacherSalary salary = _salaryService.GetTeacherSalaryById(teacherId); // Get salary details for the teacher
        if (salary != null)
        {
            litTeacherName.Text = salary.TeacherName;
            txtBaseSalary.Text = salary.BaseSalary.ToString();
            txtAllowances.Text = salary.Allowances.ToString();
            txtDeductions.Text = salary.Deductions.ToString();
            pnlSalaryDetails.Visible = true;
        }
        else
        {
            // If no existing salary record, prepare for new entry
            Teacher teacher = _salaryService.GetAllTeachers().FirstOrDefault(t => t.TeacherID == teacherId);
            if (teacher != null)
            {
                litTeacherName.Text = teacher.TeacherName;
                txtBaseSalary.Text = "0.00";
                txtAllowances.Text = "0.00";
                txtDeductions.Text = "0.00";
                pnlSalaryDetails.Visible = true;
            }
            else
            {
                litMessage.Text = "<div class='alert alert-danger mt-3'>Teacher not found.</div>";
                pnlSalaryDetails.Visible = false;
            }
        }
        litMessage.Text = ""; // Clear previous messages
    }

    protected void btnSaveSalary_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && !string.IsNullOrEmpty(ddlSelectTeacher.SelectedValue))
        {
            int teacherId = Convert.ToInt32(ddlSelectTeacher.SelectedValue);
            string teacherName = litTeacherName.Text; // Get from literal, as it's displayed

            decimal baseSalary, allowances, deductions;
            if (decimal.TryParse(txtBaseSalary.Text, out baseSalary) &&
                decimal.TryParse(txtAllowances.Text, out allowances) &&
                decimal.TryParse(txtDeductions.Text, out deductions))
            {
                TeacherSalary newSalaryData = new TeacherSalary
                {
                    TeacherID = teacherId,
                    TeacherName = teacherName, // This would ideally be looked up for consistency
                    BaseSalary = baseSalary,
                    Allowances = allowances,
                    Deductions = deductions
                };

                _salaryService.SaveTeacherSalary(newSalaryData); // Save or update in your service
                litMessage.Text = "<div class='alert alert-success mt-3'>Salary structure saved successfully!</div>";
                LoadTeacherSalaryDetails(teacherId); // Reload to confirm
            }
            else
            {
                litMessage.Text = "<div class='alert alert-danger mt-3'>Please enter valid numeric values for salary components.</div>";
            }
        }
        else
        {
            litMessage.Text = "<div class='alert alert-warning mt-3'>Please select a teacher and ensure all required fields are filled correctly.</div>";
        }
    }
}
