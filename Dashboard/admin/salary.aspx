<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="salary.aspx.cs" Inherits="Dashboard_admin_salary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .stat-card {
        border: 1px solid #e9ecef;
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        cursor: default;
    }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1) !important;
        }

    .icon-bg {
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 0.75rem;
    }

    /* Salary Status Badges */
    .badge-paid { background-color: #d1e7dd; color: #0f5132; } /* Light Green */
    .badge-pending { background-color: #fff3cd; color: #664d03; } /* Light Yellow */
    .badge-processed { background-color: #cfe2ff; color: #0a58ca; } /* Light Blue */
    .badge-hold { background-color: #f8d7da; color: #842029; } /* Light Red */
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Teacher Salary Management</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Salary Stats Overview -->
<div class="row g-4 mb-4">

    <!-- Monthly Payout -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-primary bg-opacity-10 me-3">
                    <i class="bi bi-wallet2 text-primary fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Monthly Payout</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTotalMonthlyPayout" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Current payroll cycle</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Paid -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-check-circle text-success fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Paid</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litSalariesPaid" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Processed this month</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-warning bg-opacity-10 me-3">
                    <i class="bi bi-hourglass-split text-warning fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Pending</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litSalariesPending" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Awaiting payout</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Teachers -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-info bg-opacity-10 me-3">
                    <i class="bi bi-people text-info fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Teachers</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTotalTeachers" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">On payroll</small>
                </div>
            </div>
        </div>
    </div>

</div>


<!-- Teacher Salary Table -->
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">Teacher Salary Overview</h5>
            <div>
                <asp:HyperLink ID="lnkSetupSalary" runat="server" CssClass="btn btn-outline-secondary btn-sm me-2" NavigateUrl="~/dashboard/admin/setupsalary.aspx">
                    <i class="bi bi-gear me-2"></i>Setup Salary
                </asp:HyperLink>
                <asp:HyperLink ID="lnkProcessPayroll" runat="server" CssClass="btn btn-primary btn-sm" NavigateUrl="~/dashboard/admin/processpayroll.aspx">
                    <i class="bi bi-calculator me-2"></i>Process Payroll
                </asp:HyperLink>
            </div>
        </div>
    </div>
    <div class="card-body">
        <p class="text-muted">Manage teacher salaries, view payment statuses, and process payroll.</p>

        <div class="row g-3 mb-4 align-items-end">
            <div class="col-md-4">
                <asp:Label ID="lblFilterDepartment" runat="server" Text="Filter by Department" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFilterDepartment" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterDepartment_SelectedIndexChanged">
                    <asp:ListItem Text="-- All Departments --" Value="" />
                    <asp:ListItem Text="Mathematics" Value="Math" />
                    <asp:ListItem Text="Science" Value="Science" />
                    <asp:ListItem Text="English" Value="English" />
                    <asp:ListItem Text="History" Value="History" />
                </asp:DropDownList>
            </div>
             <div class="col-md-4">
                <asp:Label ID="lblFilterStatus" runat="server" Text="Filter by Status" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged">
                    <asp:ListItem Text="-- All Statuses --" Value="" />
                    <asp:ListItem Text="Paid" Value="Paid" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Processed" Value="Processed" />
                    <asp:ListItem Text="On Hold" Value="Hold" />
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtSearchTeacher" runat="server" CssClass="form-control" placeholder="Search by Teacher Name or ID" AutoPostBack="True" OnTextChanged="txtSearchTeacher_TextChanged"></asp:TextBox>
            </div>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvTeacherSalaries" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                DataKeyNames="TeacherID" OnRowDataBound="gvTeacherSalaries_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="TeacherID" HeaderText="ID" />
                    <asp:BoundField DataField="TeacherName" HeaderText="Teacher Name" />
                    <asp:BoundField DataField="Department" HeaderText="Department" />
                    <asp:BoundField DataField="BaseSalary" HeaderText="Base Salary" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Allowances" HeaderText="Allowances" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Deductions" HeaderText="Deductions" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="NetSalary" HeaderText="Net Salary" DataFormatString="{0:C}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge rounded-pill bg-{{Eval('StatusClass')}}">{{Eval('Status')}}</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LastPaymentDate" HeaderText="Last Paid" DataFormatString="{0:d}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkPay" runat="server" CssClass="btn btn-sm btn-success me-2"
                                NavigateUrl='<%# Eval("TeacherID", "~/dashboard/admin/paysalary.aspx?teacherId={0}") %>'>
                                <i class="bi bi-wallet"></i> Pay
                            </asp:HyperLink>
                            <asp:LinkButton ID="lnkViewDetails" runat="server" CssClass="btn btn-sm btn-outline-info" CommandName="ViewDetails" CommandArgument='<%# Eval("TeacherID") %>'>
                                <i class="bi bi-info-circle"></i> Details
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-info" role="alert">
                        No teacher salary records found matching the selected criteria.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</div>

</asp:Content>
