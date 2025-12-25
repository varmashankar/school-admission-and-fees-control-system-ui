<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="fees.aspx.cs" Inherits="Dashboard_admin_fees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .stat-card {
    border: 1px solid #e9ecef;
    transition: box-shadow 0.2s ease, transform 0.2s ease;
}

.stat-card:hover {
    box-shadow: 0 0.75rem 1.5rem rgba(0,0,0,.08);
    transform: translateY(-3px);
}

.icon-bg {
    width: 56px;
    height: 56px;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

    /* Fee Status Badges */
    .badge-paid { background-color: #d1e7dd; color: #0f5132; } /* Light Green */
    .badge-pending { background-color: #fff3cd; color: #664d03; } /* Light Yellow */
    .badge-overdue { background-color: #f8d7da; color: #842029; } /* Light Red */
    .badge-partial { background-color: #cfe2ff; color: #0a58ca; } /* Light Blue */
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Fees Management</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Fees Stats Overview -->
<div class="row g-4 mb-4">

    <!-- Expected -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-primary bg-opacity-10 me-3">
                    <i class="bi bi-calculator text-primary fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Expected</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTotalExpectedFees" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Total billed amount</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Collected -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-wallet2 text-success fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Collected</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTotalCollectedFees" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Received so far</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Outstanding -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-warning bg-opacity-10 me-3">
                    <i class="bi bi-hourglass-split text-warning fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Outstanding</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litOutstandingFees" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Yet to be paid</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Overdue -->
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-danger bg-opacity-10 me-3">
                    <i class="bi bi-exclamation-circle text-danger fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Overdue</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litOverdueAccounts" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Accounts past due</small>
                </div>
            </div>
        </div>
    </div>

</div>


<!-- Fee Management Table -->
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">Student Fees Overview</h5>
            <div>
                <asp:HyperLink ID="lnkDefineFees" runat="server" CssClass="btn btn-outline-secondary btn-sm me-2" NavigateUrl="~/dashboard/admin/feedefinition.aspx">
                    <i class="bi bi-cash me-2"></i>Define Fees
                </asp:HyperLink>
                <asp:HyperLink ID="lnkCollectFee" runat="server" CssClass="btn btn-primary btn-sm" NavigateUrl="~/dashboard/admin/collectfee.aspx">
                    <i class="bi bi-plus-lg me-2"></i>Collect Fee
                </asp:HyperLink>
            </div>
        </div>
    </div>
    <div class="card-body">
        <p class="text-muted">Manage student fee collections, view payment statuses, and track outstanding amounts.</p>

        <div class="row g-3 mb-4 align-items-end">
            <div class="col-md-4">
                <asp:Label ID="lblFilterClass" runat="server" Text="Filter by Class" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFilterClass" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterClass_SelectedIndexChanged">
                    <asp:ListItem Text="-- All Classes --" Value="" />
                    <asp:ListItem Text="Grade 1 - A" Value="G1A" />
                    <asp:ListItem Text="Grade 1 - B" Value="G1B" />
                    <asp:ListItem Text="Grade 5 - A" Value="G5A" />
                    <asp:ListItem Text="Grade 8 - A" Value="G8A" />
                </asp:DropDownList>
            </div>
             <div class="col-md-4">
                <asp:Label ID="lblFilterStatus" runat="server" Text="Filter by Status" CssClass="form-label fw-semibold"></asp:Label>
                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged">
                    <asp:ListItem Text="-- All Statuses --" Value="" />
                    <asp:ListItem Text="Paid" Value="Paid" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Overdue" Value="Overdue" />
                    <asp:ListItem Text="Partial" Value="Partial" />
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" placeholder="Search by Student Name or ID" AutoPostBack="True" OnTextChanged="txtSearchStudent_TextChanged"></asp:TextBox>
            </div>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvFees" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                DataKeyNames="StudentID" OnRowDataBound="gvFees_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
                    <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                    <asp:BoundField DataField="ClassName" HeaderText="Class" />
                    <asp:BoundField DataField="TotalFees" HeaderText="Total Fees" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="AmountPaid" HeaderText="Amount Paid" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="BalanceDue" HeaderText="Balance Due" DataFormatString="{0:C}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge rounded-pill bg-{{Eval('StatusClass')}}">{{Eval('Status')}}</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:d}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkCollect" runat="server" CssClass="btn btn-sm btn-success me-2"
                                NavigateUrl='<%# Eval("StudentID", "~/dashboard/admin/collectfee.aspx?studentId={0}") %>'>
                                <i class="bi bi-wallet"></i> Collect
                            </asp:HyperLink>
                            <asp:LinkButton ID="lnkViewDetails" runat="server" CssClass="btn btn-sm btn-outline-info" CommandName="ViewDetails" CommandArgument='<%# Eval("StudentID") %>'>
                                <i class="bi bi-info-circle"></i> Details
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-info" role="alert">
                        No fee records found matching the selected criteria.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</div>

</asp:Content>