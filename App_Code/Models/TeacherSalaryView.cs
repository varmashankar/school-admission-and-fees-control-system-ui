using System;

/// <summary>
/// Summary description for TeacherSalaryView
/// </summary>
public class TeacherSalaryView
{
    public int TeacherID { get; set; }
    public string TeacherName { get; set; }
    public string Department { get; set; }
    public decimal BaseSalary { get; set; }
    public decimal Allowances { get; set; }
    public decimal Deductions { get; set; }
    public decimal NetSalary { get; set; }
    public string Status { get; set; }
    public DateTime? LastPaymentDate { get; set; }

    public string StatusClass
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
}
