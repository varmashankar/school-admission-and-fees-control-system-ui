using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_processpayroll : System.Web.UI.Page
{
    private SalaryManagementService _salaryService = new SalaryManagementService();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateMonthAndYearDropdowns();
            SetDefaultMonthYear();
        }
    }

    private void PopulateMonthAndYearDropdowns()
    {
        int currentYear = DateTime.Now.Year;
        for (int i = currentYear - 2; i <= currentYear + 1; i++)
        {
            ddlYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        ddlYear.SelectedValue = currentYear.ToString();
    }

    private void SetDefaultMonthYear()
    {
        ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
        ddlYear.SelectedValue = DateTime.Now.Year.ToString();
    }

    protected void btnLoadPayrollData_Click(object sender, EventArgs e)
    {
        int month = Convert.ToInt32(ddlMonth.SelectedValue);
        int year = Convert.ToInt32(ddlYear.SelectedValue);

        PayrollSummary summary = _salaryService.GetPayrollSummary(month, year);

        litSelectedMonthYear.Text = new DateTime(year, month, 1).ToString("MMMM yyyy");
        litTeachersForPayout.Text = summary.TeachersForPayout.ToString();
        litEstimatedPayout.Text = summary.EstimatedTotalPayout.ToString("C");
        litUnconfiguredSalaries.Text = summary.UnconfiguredSalaries.ToString();
        litAlreadyProcessed.Text = summary.AlreadyProcessed.ToString();

        divUnconfiguredWarning.Visible = summary.UnconfiguredSalaries > 0;
        if (summary.UnconfiguredSalaries > 0)
            litUnconfiguredCountWarning.Text = summary.UnconfiguredSalaries.ToString();

        pnlPayrollSummary.Visible = true;
        litProcessMessage.Text = "";
    }

    protected void btnProcessPayroll_Click(object sender, EventArgs e)
    {
        int month = Convert.ToInt32(ddlMonth.SelectedValue);
        int year = Convert.ToInt32(ddlYear.SelectedValue);

        PayrollResult result = _salaryService.ProcessMonthlyPayroll(month, year);

        string formattedMonthYear = new DateTime(year, month, 1).ToString("MMMM yyyy");

        if (result.Success)
        {
            litProcessMessage.Text =
                string.Format(
                    "<div class='alert alert-success mt-3'><i class='bi bi-check-circle-fill me-2'></i>Payroll for {0} processed successfully! {1} teachers paid.</div>",
                    formattedMonthYear,
                    result.TeachersProcessed
                );
        }
        else
        {
            litProcessMessage.Text =
                string.Format(
                    "<div class='alert alert-danger mt-3'><i class='bi bi-x-circle-fill me-2'></i>Failed to process payroll for {0}. Reason: {1}</div>",
                    formattedMonthYear,
                    result.ErrorMessage
                );
        }

        // Reload summary after processing
        btnLoadPayrollData_Click(sender, e);
    }

}
