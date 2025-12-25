using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_salary : System.Web.UI.Page
{

    private SalaryManagementService _salaryService = new SalaryManagementService();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartments();
            LoadSalaryStats();
            BindTeacherSalaries();
        }
    }

    private void BindDepartments()
    {
        // Populate departments dynamically from your database or a predefined list
        // For demonstration, using a static list.
        List<string> departments = new List<string> {
            "Mathematics", "Science", "English", "History", "Computer Science", "Arts"
        };

        ddlFilterDepartment.DataSource = departments;
        ddlFilterDepartment.DataBind();
        ddlFilterDepartment.Items.Insert(0, new ListItem("-- All Departments --", ""));
    }

    private void LoadSalaryStats()
    {
        // In a real application, these values would come from database queries
        // summarizing current month's payroll.
        litTotalMonthlyPayout.Text = _salaryService.GetTotalMonthlyPayout().ToString("C");
        litSalariesPaid.Text = _salaryService.GetSalariesPaidCurrentMonth().ToString("C");
        litSalariesPending.Text = _salaryService.GetSalariesPending().ToString("C");
        litTotalTeachers.Text = _salaryService.GetTotalTeachersCount().ToString();
    }

    private void BindTeacherSalaries()
    {
        string departmentFilter = ddlFilterDepartment.SelectedValue;
        string statusFilter = ddlFilterStatus.SelectedValue;
        string searchTerm = txtSearchTeacher.Text.Trim();

        List<TeacherSalaryView> salaries = _salaryService.GetTeacherSalaries(departmentFilter, statusFilter, searchTerm);
        gvTeacherSalaries.DataSource = salaries;
        gvTeacherSalaries.DataBind();
    }

    protected void ddlFilterDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindTeacherSalaries();
    }

    protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindTeacherSalaries();
    }

    protected void txtSearchTeacher_TextChanged(object sender, EventArgs e)
    {
        BindTeacherSalaries();
    }

    protected void gvTeacherSalaries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Assuming TeacherSalaryView has a property like 'StatusClass' or 'Status'
            // and you want to dynamically set the CSS class for the status badge.
            TeacherSalaryView salary = (TeacherSalaryView)e.Row.DataItem;

            // Find the status span and set its class
            Literal statusLiteral = (Literal)e.Row.FindControl("StatusBadgeLiteral"); // You'd need to add a Literal in the template field
            if (statusLiteral != null)
            {
                // Example of how you would conditionally set the class
                string statusClass = "";
                switch (salary.Status)
                {
                    case "Paid":
                        statusClass = "badge-paid";
                        break;
                    case "Pending":
                        statusClass = "badge-pending";
                        break;
                    case "Processed":
                        statusClass = "badge-processed";
                        break;
                    case "On Hold":
                        statusClass = "badge-hold";
                        break;
                    default:
                        statusClass = "badge-secondary"; // Default badge color
                        break;
                }
                // Update the ItemTemplate in your ASPX to use this:
                // <span class="badge rounded-pill <%= statusClass %>">{{Eval('Status')}}</span>
                // Or if you directly inject the span content:
                // statusLiteral.Text = $"<span class='badge rounded-pill {statusClass}'>{salary.Status}</span>";

                // For the current ASPX, we'll assume 'StatusClass' is directly available in the data item:
                // This requires your TeacherSalaryView to have a StatusClass property.
                Literal statusSpan = (Literal)e.Row.FindControl("StatusSpan");
                if (statusSpan != null && !string.IsNullOrEmpty(salary.StatusClass))
                {
                    // This is a common pattern when Eval is used directly in the template
                    // <span class="badge rounded-pill bg-{{Eval('StatusClass')}}">{{Eval('Status')}}</span>
                    // The RowDataBound is often used for more complex logic if Eval isn't sufficient
                    // or for setting up event handlers.
                }
            }

            // Example of handling LinkButton clicks if needed for details
            LinkButton lnkViewDetails = (LinkButton)e.Row.FindControl("lnkViewDetails");
            if (lnkViewDetails != null)
            {
                lnkViewDetails.CommandArgument = salary.TeacherID.ToString();
                lnkViewDetails.CommandName = "ViewDetails";
            }
        }
    }

    protected void gvTeacherSalaries_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewDetails")
        {
            int teacherId = Convert.ToInt32(e.CommandArgument);
            // Redirect to a details page or open a modal
            //Response.Redirect($"~/dashboard/admin/teacherdetails.aspx?teacherId={teacherId}");
        }
    }

    // --- Placeholder Classes for Data Modeling ---
    // In a real application, these would be in separate files and layers (e.g., Models, Services).

    public class TeacherSalaryView
    {
        public int TeacherID { get; set; }
        public string TeacherName { get; set; }
        public string Department { get; set; }
        public decimal BaseSalary { get; set; }
        public decimal Allowances { get; set; }
        public decimal Deductions { get; set; }
        public decimal NetSalary { get; set; }
        public string Status { get; set; } // e.g., "Paid", "Pending", "Processed", "On Hold"
        public string StatusClass // Derived property for CSS class
        {
            get
            {
                switch (Status)
                {
                    case "Paid": return "badge-paid";
                    case "Pending": return "badge-pending";
                    case "Processed": return "badge-processed";
                    case "On Hold": return "badge-hold";
                    default: return "badge-secondary";
                }
            }
        }
        public DateTime? LastPaymentDate { get; set; }
    }

    public class SalaryManagementService
    {
        // This class would encapsulate your data access logic (e.g., ADO.NET, Entity Framework)

        public List<TeacherSalaryView> GetTeacherSalaries(string departmentFilter, string statusFilter, string searchTerm)
        {
            // Simulate fetching data from a database
            List<TeacherSalaryView> allSalaries = new List<TeacherSalaryView>
        {
            new TeacherSalaryView { TeacherID = 1001, TeacherName = "Anjali Sharma", Department = "Mathematics", BaseSalary = 4000M, Allowances = 500M, Deductions = 100M, NetSalary = 4400M, Status = "Paid", LastPaymentDate = DateTime.Now.AddDays(-5) },
            new TeacherSalaryView { TeacherID = 1002, TeacherName = "Rajesh Kumar", Department = "Science", BaseSalary = 4500M, Allowances = 600M, Deductions = 150M, NetSalary = 4950M, Status = "Paid", LastPaymentDate = DateTime.Now.AddMonths(-1) },
            new TeacherSalaryView { TeacherID = 1003, TeacherName = "Deepika Padukone", Department = "English", BaseSalary = 3800M, Allowances = 400M, Deductions = 80M, NetSalary = 4120M, Status = "Pending", LastPaymentDate = null },
            new TeacherSalaryView { TeacherID = 1004, TeacherName = "Amir Khan", Department = "History", BaseSalary = 4200M, Allowances = 550M, Deductions = 120M, NetSalary = 4630M, Status = "Processed", LastPaymentDate = null },
            new TeacherSalaryView { TeacherID = 1005, TeacherName = "Priya Singh", Department = "Computer Science", BaseSalary = 4800M, Allowances = 700M, Deductions = 200M, NetSalary = 5300M, Status = "On Hold", LastPaymentDate = null },
            new TeacherSalaryView { TeacherID = 1006, TeacherName = "Amitabh Bachchan", Department = "Arts", BaseSalary = 5000M, Allowances = 800M, Deductions = 250M, NetSalary = 5550M, Status = "Paid", LastPaymentDate = DateTime.Now.AddDays(-10) }
        };

            var filteredSalaries = allSalaries.AsQueryable();

            if (!string.IsNullOrEmpty(departmentFilter))
            {
                filteredSalaries = filteredSalaries.Where(s => s.Department == departmentFilter);
            }

            if (!string.IsNullOrEmpty(statusFilter))
            {
                filteredSalaries = filteredSalaries.Where(s => s.Status == statusFilter);
            }

            if (!string.IsNullOrEmpty(searchTerm))
            {
                // Fix for older .NET Framework versions:
                // Convert both the source and the search term to lowercase for case-insensitive comparison
                string lowerSearchTerm = searchTerm.ToLower(); // Convert search term once

                filteredSalaries = filteredSalaries.Where(s =>
                    (s.TeacherName != null && s.TeacherName.ToLower().Contains(lowerSearchTerm)) ||
                    s.TeacherID.ToString().Contains(lowerSearchTerm) // TeacherID comparison is already string-based
                );
            }

            return filteredSalaries.ToList();
        }

        public decimal GetTotalMonthlyPayout()
        {
            // Simulate calculation
            return 85000.00M;
        }

        public decimal GetSalariesPaidCurrentMonth()
        {
            // Simulate calculation
            return 62000.00M;
        }

        public decimal GetSalariesPending()
        {
            // Simulate calculation
            return 23000.00M;
        }

        public int GetTotalTeachersCount()
        {
            // Simulate count
            return 25;
        }
    }
}
