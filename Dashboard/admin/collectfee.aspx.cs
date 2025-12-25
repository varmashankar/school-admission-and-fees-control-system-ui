using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_collectfee : System.Web.UI.Page
{
    public class Student
    {
        public int StudentID { get; set; }
        public string RollNo { get; set; }
        public string StudentName { get; set; }
        public string ClassSectionID { get; set; }
        public string ClassName { get; set; }
    }

    public class FeeRecord
    {
        public int FeeID { get; set; }
        public int StudentID { get; set; }
        public decimal TotalFees { get; set; }
        public decimal AmountPaid { get; set; }
        public DateTime DueDate { get; set; }
        public string Status { get; set; }
        public string StatusClass { get; set; }
    }

    public class PaymentTransaction
    {
        public int TransactionID { get; set; }
        public int FeeID { get; set; }
        public int StudentID { get; set; }
        public decimal Amount { get; set; }
        public DateTime PaymentDate { get; set; }
        public string PaymentMethod { get; set; }
        public string Remarks { get; set; }
    }

    private static List<Student> _students = new List<Student>
    {
        new Student { StudentID = 1, RollNo = "S001", StudentName = "Alice Smith", ClassSectionID = "G1A", ClassName = "Grade 1 - A" },
        new Student { StudentID = 2, RollNo = "S002", StudentName = "Bob Johnson", ClassSectionID = "G1A", ClassName = "Grade 1 - A" },
        new Student { StudentID = 3, RollNo = "S003", StudentName = "Charlie Brown", ClassSectionID = "G1B", ClassName = "Grade 1 - B" },
        new Student { StudentID = 4, RollNo = "S004", StudentName = "David Lee", ClassSectionID = "G5A", ClassName = "Grade 5 - A" },
        new Student { StudentID = 5, RollNo = "S005", StudentName = "Eve Davis", ClassSectionID = "G8A", ClassName = "Grade 8 - A" },
        new Student { StudentID = 6, RollNo = "S006", StudentName = "Frank White", ClassSectionID = "G5A", ClassName = "Grade 5 - A" },
    };

    private static List<FeeRecord> _feeRecords = new List<FeeRecord>
    {
        new FeeRecord { FeeID = 1, StudentID = 1, TotalFees = 1200.00m, AmountPaid = 1200.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 1), Status = "Paid", StatusClass = "badge-paid" },
        new FeeRecord { FeeID = 2, StudentID = 2, TotalFees = 1200.00m, AmountPaid = 800.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 1), Status = "Partial", StatusClass = "badge-partial" },
        new FeeRecord { FeeID = 3, StudentID = 3, TotalFees = 1200.00m, AmountPaid = 0.00m, DueDate = new DateTime(DateTime.Now.Year, 10, 1), Status = "Pending", StatusClass = "badge-pending" },
        new FeeRecord { FeeID = 4, StudentID = 4, TotalFees = 1500.00m, AmountPaid = 0.00m, DueDate = new DateTime(DateTime.Now.Year, 8, 1), Status = "Overdue", StatusClass = "badge-overdue" },
        new FeeRecord { FeeID = 5, StudentID = 5, TotalFees = 1800.00m, AmountPaid = 1000.00m, DueDate = new DateTime(DateTime.Now.Year, 11, 1), Status = "Partial", StatusClass = "badge-partial" },
        new FeeRecord { FeeID = 6, StudentID = 6, TotalFees = 1500.00m, AmountPaid = 1500.00m, DueDate = new DateTime(DateTime.Now.Year, 9, 15), Status = "Paid", StatusClass = "badge-paid" },
    };

    private static List<PaymentTransaction> _paymentTransactions = new List<PaymentTransaction>();

    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        if (!IsPostBack)
        {
            PopulateStudentsDropdown();
            txtPaymentDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

            if (Request.QueryString["studentId"] != null)
            {
                int studentId;
                if (int.TryParse(Request.QueryString["studentId"], out studentId))
                {
                    var studentItem = ddlStudent.Items.FindByValue(studentId.ToString());
                    if (studentItem != null)
                    {
                        ddlStudent.SelectedValue = studentId.ToString();
                        LoadStudentFeeDetails(studentId);
                    }
                }
            }
        }
    }

    private void PopulateStudentsDropdown()
    {
        ddlStudent.DataSource = _students
            .Select(s => new
            {
                s.StudentID,
                DisplayName = string.Format("{0} ({1} - {2})", s.StudentName, s.RollNo, s.ClassName)
            })
            .OrderBy(s => s.DisplayName);

        ddlStudent.DataTextField = "DisplayName";
        ddlStudent.DataValueField = "StudentID";
        ddlStudent.DataBind();

        ddlStudent.Items.Insert(0, new ListItem("-- Select Student --", ""));
    }

    protected void ddlStudent_SelectedIndexChanged(object sender, EventArgs e)
    {
        int studentId;
        if (int.TryParse(ddlStudent.SelectedValue, out studentId))
            LoadStudentFeeDetails(studentId);
        else
            ClearFeeDetails();
    }

    private void LoadStudentFeeDetails(int studentId)
    {
        var student = _students.FirstOrDefault(s => s.StudentID == studentId);
        var feeRecord = _feeRecords.FirstOrDefault(f => f.StudentID == studentId);

        if (student != null && feeRecord != null)
        {
            litStudentDetails.Text = string.Format("Roll No: {0}, Class: {1}", student.RollNo, student.ClassName);
            litFeeStudentName.Text = student.StudentName;

            litTotalFees.Text = feeRecord.TotalFees.ToString("C");
            litAmountPaid.Text = feeRecord.AmountPaid.ToString("C");

            decimal balanceDue = feeRecord.TotalFees - feeRecord.AmountPaid;
            litBalanceDue.Text = balanceDue.ToString("C");

            feeStatusBadge.InnerText = feeRecord.Status;
            feeStatusBadge.Attributes["class"] = "badge rounded-pill " + feeRecord.StatusClass;

            litDueDate.Text = feeRecord.DueDate.ToShortDateString();

            pnlFeeDetails.Visible = true;
            btnProcessPayment.Enabled = balanceDue > 0;
            txtPaymentAmount.Text = balanceDue > 0 ? balanceDue.ToString("F2") : "0.00";

            rvPaymentAmount.MaximumValue = balanceDue.ToString();
        }
        else
        {
            ClearFeeDetails();
        }
    }

    private void ClearFeeDetails()
    {
        pnlFeeDetails.Visible = false;
        btnProcessPayment.Enabled = false;
        litStudentDetails.Text = "Select a student to view details.";
        litFeeStudentName.Text = string.Empty;
        litTotalFees.Text = litAmountPaid.Text = litBalanceDue.Text = string.Empty;
        litDueDate.Text = string.Empty;
        feeStatusBadge.InnerText = string.Empty;
    }

    protected void btnProcessPayment_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlStudent.SelectedValue)) return;

        int studentId = int.Parse(ddlStudent.SelectedValue);
        var feeRecord = _feeRecords.FirstOrDefault(f => f.StudentID == studentId);
        if (feeRecord == null) return;

        decimal paymentAmount = decimal.Parse(txtPaymentAmount.Text);
        DateTime paymentDate = DateTime.Parse(txtPaymentDate.Text);
        string paymentMethod = ddlPaymentMethod.SelectedValue;
        string remarks = txtRemarks.Text.Trim();

        var transaction = new PaymentTransaction
        {
            TransactionID = _paymentTransactions.Count + 1,
            FeeID = feeRecord.FeeID,
            StudentID = studentId,
            Amount = paymentAmount,
            PaymentDate = paymentDate,
            PaymentMethod = paymentMethod,
            Remarks = remarks
        };
        _paymentTransactions.Add(transaction);

        feeRecord.AmountPaid += paymentAmount;
        decimal newBalance = feeRecord.TotalFees - feeRecord.AmountPaid;

        if (newBalance <= 0)
        {
            feeRecord.Status = "Paid";
            feeRecord.StatusClass = "badge-paid";
        }
        else if (feeRecord.AmountPaid == 0)
        {
            feeRecord.Status = "Pending";
            feeRecord.StatusClass = "badge-pending";
        }
        else
        {
            feeRecord.Status = "Partial";
            feeRecord.StatusClass = "badge-partial";
        }

        LoadStudentFeeDetails(studentId);

        ScriptManager.RegisterStartupScript(this, GetType(), "PaymentSuccess",
            "alert('Payment processed successfully!');", true);
    }
}
