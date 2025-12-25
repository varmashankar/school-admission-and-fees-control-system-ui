using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_fees : System.Web.UI.Page
{
    // Dummy Data Structures
    public class Student
    {
        public int StudentID { get; set; }
        public string RollNo { get; set; }
        public string StudentName { get; set; }
        public string ClassSectionID { get; set; } // e.g., "G1A"
        public string ClassName { get; set; } // e.g., "Grade 1 - A"
    }

    public class FeeRecord
    {
        public int FeeID { get; set; }
        public int StudentID { get; set; }
        public decimal TotalFees { get; set; }
        public decimal AmountPaid { get; set; }
        public DateTime DueDate { get; set; }
        public string Status { get; set; } // Paid, Pending, Overdue, Partial
        public string StatusClass { get; set; } // CSS class for badge
    }

    // Simulate database data
    private static List<Student> _students = new List<Student>
    {
        new Student { StudentID = 1, RollNo = "S001", StudentName = "Alice Smith", ClassSectionID = "G1A", ClassName = "Grade 1 - A" },
        new Student { StudentID = 2, RollNo = "S002", StudentName = "Bob Johnson", ClassSectionID = "G1A", ClassName = "Grade 1 - A" },
        new Student { StudentID = 3, RollNo = "S003", StudentName = "Charlie Brown", ClassSectionID = "G1B", ClassName = "Grade 1 - B" },
        new Student { StudentID = 4, RollNo = "S004", StudentName = "David Lee", ClassSectionID = "G5A", ClassName = "Grade 5 - A" },
        new Student { StudentID = 5, RollNo = "S005", StudentName = "Eve Davis", ClassSectionID = "G8A", ClassName = "Grade 8 - A" },
        new Student { StudentID = 6, RollNo = "S006", StudentName = "Frank White", ClassSectionID = "G5A", ClassName = "Grade 5 - A" },
    };

    // Fees are annual, assuming one main record per student per year for simplicity
    private static List<FeeRecord> _feeRecords = new List<FeeRecord>
    {
        new FeeRecord { FeeID = 1, StudentID = 1, TotalFees = 1200.00m, AmountPaid = 1200.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 1), Status = "Paid", StatusClass = "badge-paid" },
        new FeeRecord { FeeID = 2, StudentID = 2, TotalFees = 1200.00m, AmountPaid = 800.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 1), Status = "Partial", StatusClass = "badge-partial" },
        new FeeRecord { FeeID = 3, StudentID = 3, TotalFees = 1200.00m, AmountPaid = 0.00m, DueDate = new DateTime(DateTime.Now.Year, 10, 1), Status = "Pending", StatusClass = "badge-pending" },
        new FeeRecord { FeeID = 4, StudentID = 4, TotalFees = 1500.00m, AmountPaid = 0.00m, DueDate = new DateTime(DateTime.Now.Year, 8, 1), Status = "Overdue", StatusClass = "badge-overdue" }, // Overdue
        new FeeRecord { FeeID = 5, StudentID = 5, TotalFees = 1800.00m, AmountPaid = 1000.00m, DueDate = new DateTime(DateTime.Now.Year, 11, 1), Status = "Partial", StatusClass = "badge-partial" },
        new FeeRecord { FeeID = 6, StudentID = 6, TotalFees = 1500.00m, AmountPaid = 1500.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 15), Status = "Paid", StatusClass = "badge-paid" },
    };


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateStats();
            BindFeesGridView();
        }
    }

    private void PopulateStats()
    {
        litTotalExpectedFees.Text = _feeRecords.Sum(f => f.TotalFees).ToString("C");
        litTotalCollectedFees.Text = _feeRecords.Sum(f => f.AmountPaid).ToString("C");
        litOutstandingFees.Text = (_feeRecords.Sum(f => f.TotalFees) - _feeRecords.Sum(f => f.AmountPaid)).ToString("C");
        litOverdueAccounts.Text = _feeRecords.Count(f => f.Status == "Overdue").ToString();
    }

    private void BindFeesGridView()
    {
        string filterClass = ddlFilterClass.SelectedValue;
        string filterStatus = ddlFilterStatus.SelectedValue;
        string searchTerm = txtSearchStudent.Text.ToLower();

        var feesQuery = from fee in _feeRecords
                        join student in _students on fee.StudentID equals student.StudentID
                        select new
                        {
                            student.StudentID,
                            student.RollNo,
                            student.StudentName,
                            student.ClassName,
                            student.ClassSectionID, // ✅ include this
                            fee.TotalFees,
                            fee.AmountPaid,
                            BalanceDue = fee.TotalFees - fee.AmountPaid,
                            fee.Status,
                            fee.StatusClass,
                            fee.DueDate
                        };


        if (!string.IsNullOrEmpty(filterClass))
        {
            feesQuery = feesQuery.Where(f => f.ClassSectionID == filterClass);
        }

        if (!string.IsNullOrEmpty(filterStatus))
        {
            feesQuery = feesQuery.Where(f => f.Status == filterStatus);
        }

        if (!string.IsNullOrEmpty(searchTerm))
        {
            feesQuery = feesQuery.Where(f => f.StudentName.ToLower().Contains(searchTerm) ||
                                             f.RollNo.ToLower().Contains(searchTerm));
        }

        gvFees.DataSource = feesQuery.ToList();
        gvFees.DataBind();
    }

    protected void ddlFilterClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindFeesGridView();
    }

    protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindFeesGridView();
    }

    protected void txtSearchStudent_TextChanged(object sender, EventArgs e)
    {
        BindFeesGridView();
    }

    protected void gvFees_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Set the CSS class for the status badge directly from the bound data
            // The template already uses Eval('StatusClass') so this might not be strictly necessary
            // unless you want to do more complex logic here.
        }
    }


}