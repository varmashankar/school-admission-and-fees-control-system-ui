<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="processpayroll.aspx.cs" Inherits="Dashboard_admin_processpayroll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .summary-card {
            background-color: #f8f9fa;
            border-left: 5px solid;
            padding: 1rem;
            border-radius: 0.25rem;
            margin-bottom: 1rem;
        }
        .summary-card.primary { border-color: #0d6efd; }
        .summary-card.success { border-color: #198754; }
        .summary-card.warning { border-color: #ffc107; }
        .summary-card.info { border-color: #0dcaf0; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
     <asp:HyperLink ID="lnkBackToSalaries" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/dashboard/admin/salary.aspx">
     <i class="bi bi-arrow-left me-2"></i>Back to Salaries
 </asp:HyperLink>
    <h3 class="text-xl font-bold text-gray-800">Process Teacher Payroll</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">Run Monthly Payroll</h5>
        </div>
    </div>
    <div class="card-body p-4">
        <p class="text-muted mb-4">Select the month and year to process payroll. This action will calculate salaries, generate pay slips, and update payment statuses.</p>

        <div class="row g-3 mb-4 align-items-end">
            <div class="col-md-4">
                <asp:Label ID="lblMonth" runat="server" Text="Select Month" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-select">
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:Label ID="lblYear" runat="server" Text="Select Year" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="col-md-4 d-grid">
                 <asp:Button ID="btnLoadPayrollData" runat="server" Text="Load Payroll Data" CssClass="btn btn-primary" OnClick="btnLoadPayrollData_Click" />
            </div>
        </div>

        <asp:Panel ID="pnlPayrollSummary" runat="server" Visible="false" CssClass="mt-4">
            <h6 class="fw-bold mb-3">Payroll Summary for <asp:Literal ID="litSelectedMonthYear" runat="server"></asp:Literal></h6>
            
            <div class="row">
                <div class="col-md-6 col-lg-3">
                    <div class="summary-card primary">
                        <small class="text-muted">Teachers for Payout</small>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litTeachersForPayout" runat="server"></asp:Literal></h4>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="summary-card success">
                        <small class="text-muted">Estimated Total Payout</small>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litEstimatedPayout" runat="server"></asp:Literal></h4>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="summary-card warning">
                        <small class="text-muted">Unconfigured Salaries</small>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litUnconfiguredSalaries" runat="server"></asp:Literal></h4>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="summary-card info">
                        <small class="text-muted">Already Processed</small>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litAlreadyProcessed" runat="server"></asp:Literal></h4>
                    </div>
                </div>
            </div>

            <div class="alert alert-warning mt-3" role="alert" runat="server" id="divUnconfiguredWarning" visible="false">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>There are <asp:Literal ID="litUnconfiguredCountWarning" runat="server"></asp:Literal> teachers with unconfigured salaries. They will not be included in payroll. Please set up their salaries <asp:HyperLink ID="lnkSetupSalariesWarning" runat="server" NavigateUrl="~/dashboard/admin/setupsalary.aspx">here</asp:HyperLink>.
            </div>

            <div class="d-grid mt-4">
                <asp:Button ID="btnProcessPayroll" runat="server" Text="Process Payroll for Selected Month" CssClass="btn btn-primary btn-lg" OnClick="btnProcessPayroll_Click" OnClientClick="return confirm('Are you sure you want to process payroll for the selected month? This action cannot be undone.');" />
            </div>
            
            <asp:Literal ID="litProcessMessage" runat="server"></asp:Literal>

        </asp:Panel>
    </div>
</div>

</asp:Content>

