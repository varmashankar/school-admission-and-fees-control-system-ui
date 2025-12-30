<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="accountability-dashboard.aspx.cs" Inherits="Dashboard_admin_accountability_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Page Header */
        .page-header {
            display: flex;
            align-items: center;
            gap: .75rem;
        }
        .page-header i {
            font-size: 1.5rem;
            color: #6366f1;
        }
        .page-header h1 {
            font-weight: 700;
            color: #1e293b;
        }
        .page-subtitle {
            color: #64748b;
            font-size: .85rem;
        }

        /* Filter Card */
        .filter-card {
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            border: 1px solid #e2e8f0;
            border-radius: 1rem;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
        }
        .filter-card .form-label {
            font-size: .75rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .025em;
            margin-bottom: .35rem;
        }
        .filter-card .form-control,
        .filter-card .form-select {
            border-radius: .5rem;
            border: 1px solid #e2e8f0;
            font-size: .9rem;
        }
        .filter-card .form-control:focus,
        .filter-card .form-select:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,.15);
        }

        /* Summary Stats */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .stat-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: .75rem;
            padding: 1.25rem;
            transition: all .2s ease;
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
        }
        .stat-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,.08);
            transform: translateY(-2px);
        }
        .stat-card .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: .75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-bottom: .75rem;
        }
        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            line-height: 1;
        }
        .stat-card .stat-label {
            font-size: .8rem;
            color: #64748b;
            margin-top: .25rem;
        }
        .stat-card .stat-trend {
            font-size: .75rem;
            margin-top: .5rem;
            display: flex;
            align-items: center;
            gap: .25rem;
        }
        
        .stat-card.stat-staff::before { background: #3b82f6; }
        .stat-card.stat-staff .stat-icon { background: #dbeafe; color: #2563eb; }
        
        .stat-card.stat-overdue::before { background: #ef4444; }
        .stat-card.stat-overdue .stat-icon { background: #fee2e2; color: #dc2626; }
        
        .stat-card.stat-missed::before { background: #f59e0b; }
        .stat-card.stat-missed .stat-icon { background: #fef3c7; color: #d97706; }
        
        .stat-card.stat-fees::before { background: #8b5cf6; }
        .stat-card.stat-fees .stat-icon { background: #ede9fe; color: #7c3aed; }

        /* Section Cards */
        .section-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 1rem;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 1.25rem;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            border-bottom: 1px solid #e5e7eb;
        }
        .section-title {
            display: flex;
            align-items: center;
            gap: .5rem;
            font-weight: 600;
            color: #1e293b;
            margin: 0;
        }
        .section-title i {
            font-size: 1.1rem;
            color: #6366f1;
        }
        .section-badge {
            background: #f1f5f9;
            color: #475569;
            padding: .25rem .6rem;
            border-radius: 999px;
            font-size: .75rem;
            font-weight: 600;
        }
        .section-body {
            padding: 0;
        }

        /* Tables */
        .data-table {
            font-size: .85rem;
            margin: 0;
        }
        .data-table thead th {
            background: #f8fafc;
            font-size: .72rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .05em;
            color: #64748b;
            padding: .75rem 1rem;
            border-bottom: 2px solid #e2e8f0;
            white-space: nowrap;
        }
        .data-table tbody td {
            padding: .75rem 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        .data-table tbody tr {
            transition: background .15s ease;
        }
        .data-table tbody tr:hover {
            background: #f8fafc;
        }
        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Status Badges */
        .badge-status {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            padding: .25rem .6rem;
            border-radius: 999px;
            font-size: .72rem;
            font-weight: 600;
        }
        .badge-overdue { background: #fee2e2; color: #dc2626; }
        .badge-warning { background: #fef3c7; color: #d97706; }
        .badge-success { background: #d1fae5; color: #059669; }
        .badge-info { background: #dbeafe; color: #2563eb; }
        .badge-neutral { background: #f1f5f9; color: #475569; }

        /* Row Number */
        .row-num {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            background: #f1f5f9;
            border-radius: 50%;
            font-size: .75rem;
            font-weight: 600;
            color: #475569;
        }

        /* Overdue Days Indicator */
        .days-overdue {
            display: inline-flex;
            align-items: center;
            gap: .35rem;
            font-weight: 600;
        }
        .days-overdue.critical { color: #dc2626; }
        .days-overdue.warning { color: #d97706; }
        .days-overdue.normal { color: #64748b; }

        /* Staff Performance */
        .staff-name { font-weight: 600; color: #1e293b; }
        .staff-metric {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
        }

        /* Amount Display */
        .amount {
            font-weight: 600;
            font-family: 'Consolas', monospace;
        }
        .amount.large { color: #dc2626; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #94a3b8;
        }
        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: .75rem;
            opacity: .5;
        }

        /* Error Alert */
        .alert-modern {
            border-radius: .75rem;
            border: none;
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            gap: .75rem;
        }
        .alert-modern i { font-size: 1.25rem; }

        /* Responsive */
        @media (max-width: 768px) {
            .filter-card .d-flex { flex-direction: column; }
            .filter-card .d-flex > div { width: 100%; }
            .stats-row { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="page-header">
        <i class="bi bi-shield-check"></i>
        <div>
            <h1 class="h4 mb-0">Accountability Dashboard</h1>
            <span class="page-subtitle">Monitor staff performance and follow-up compliance</span>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="upMain" runat="server">
        <ContentTemplate>
            <!-- Filters -->
            <div class="filter-card">
                <div class="d-flex flex-wrap align-items-end gap-3">
                    <div>
                        <label class="form-label"><i class="bi bi-calendar-event me-1"></i>From Date</label>
                        <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div>
                        <label class="form-label"><i class="bi bi-calendar-check me-1"></i>To Date</label>
                        <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div>
                        <label class="form-label"><i class="bi bi-clock-history me-1"></i>Max Days Overdue</label>
                        <asp:TextBox ID="txtMaxDaysOverdue" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g. 30" />
                    </div>
                    <div>
                        <label class="form-label"><i class="bi bi-mortarboard me-1"></i>Academic Year</label>
                        <asp:DropDownList ID="ddlAcademicYear" runat="server" CssClass="form-select" />
                    </div>
                    <div class="ms-auto">
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh Data" CssClass="btn btn-primary" OnClick="btnRefresh_Click" />
                    </div>
                </div>
            </div>

            <!-- Error Panel -->
            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-modern mb-4">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <div>
                    <strong>Error Loading Data</strong><br />
                    <asp:Literal ID="litError" runat="server" />
                </div>
            </asp:Panel>

            <!-- Summary Stats -->
            <div class="stats-row">
                <div class="stat-card stat-staff">
                    <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div class="stat-value"><asp:Literal ID="litTotalStaff" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Active Staff</div>
                </div>
                <div class="stat-card stat-overdue">
                    <div class="stat-icon"><i class="bi bi-exclamation-circle-fill"></i></div>
                    <div class="stat-value"><asp:Literal ID="litTotalOverdue" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Overdue Follow-ups</div>
                </div>
                <div class="stat-card stat-missed">
                    <div class="stat-icon"><i class="bi bi-person-x-fill"></i></div>
                    <div class="stat-value"><asp:Literal ID="litMissedInquiries" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Missed Inquiries</div>
                </div>
                <div class="stat-card stat-fees">
                    <div class="stat-icon"><i class="bi bi-currency-rupee"></i></div>
                    <div class="stat-value"><asp:Literal ID="litFeeDelays" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Fee Delays</div>
                </div>
            </div>

            <div class="row g-4">
                <!-- Staff-wise Follow-ups -->
                <div class="col-12">
                    <div class="section-card">
                        <div class="section-header">
                            <h6 class="section-title">
                                <i class="bi bi-person-badge"></i>
                                Staff-wise Follow-ups
                            </h6>
                            <span class="section-badge">Performance Tracker</span>
                        </div>
                        <div class="section-body">
                            <div class="table-responsive">
                                <asp:GridView ID="gvStaff" runat="server" CssClass="table data-table" AutoGenerateColumns="false"
                                    OnRowDataBound="gvStaff_RowDataBound" ShowHeaderWhenEmpty="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <span class="row-num"><%# Container.DataItemIndex + 1 %></span>
                                            </ItemTemplate>
                                            <ItemStyle Width="50" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Staff Member">
                                            <ItemTemplate>
                                                <span class="staff-name"><%# Eval("staffName") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Due">
                                            <ItemTemplate>
                                                <span class="badge-status badge-info">
                                                    <i class="bi bi-list-task"></i>
                                                    <%# Eval("dueFollowUps") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Overdue">
                                            <ItemTemplate>
                                                <span class='<%# GetOverdueBadgeClass(Eval("overdueFollowUps")) %>'>
                                                    <i class="bi bi-exclamation-triangle"></i>
                                                    <%# Eval("overdueFollowUps") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Activity">
                                            <ItemTemplate>
                                                <%# FormatDateTime(Eval("lastFollowUpAt")) %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="empty-state">
                                            <i class="bi bi-inbox d-block"></i>
                                            <p class="mb-0">No staff follow-up data available</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Missed Inquiries -->
                <div class="col-12">
                    <div class="section-card">
                        <div class="section-header">
                            <h6 class="section-title">
                                <i class="bi bi-person-exclamation"></i>
                                Missed Inquiries
                            </h6>
                            <span class="section-badge section-badge-warning" style="background:#fef3c7;color:#d97706;">Needs Attention</span>
                        </div>
                        <div class="section-body">
                            <div class="table-responsive">
                                <asp:GridView ID="gvMissed" runat="server" CssClass="table data-table" AutoGenerateColumns="false"
                                    OnRowDataBound="gvMissed_RowDataBound" ShowHeaderWhenEmpty="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <span class="row-num"><%# Container.DataItemIndex + 1 %></span>
                                            </ItemTemplate>
                                            <ItemStyle Width="50" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Student">
                                            <ItemTemplate>
                                                <div>
                                                    <strong><%# Eval("studentName") %></strong>
                                                    <br /><small class="text-muted"><%# Eval("phone") %></small>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <span class="badge-status badge-neutral"><%# Eval("status") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Next Follow-up">
                                            <ItemTemplate>
                                                <%# FormatDateTime(Eval("nextFollowUpAt")) %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Days Overdue">
                                            <ItemTemplate>
                                                <span class='<%# GetDaysOverdueClass(Eval("daysOverdue")) %>'>
                                                    <i class="bi bi-clock"></i>
                                                    <%# Eval("daysOverdue") %> days
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Assigned To">
                                            <ItemTemplate>
                                                <span class="staff-name"><%# Eval("assignedToStaffName") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="empty-state">
                                            <i class="bi bi-check-circle d-block text-success"></i>
                                            <p class="mb-0">No missed inquiries - great job!</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Admission Loss Reasons -->
                <div class="col-md-6">
                    <div class="section-card">
                        <div class="section-header">
                            <h6 class="section-title">
                                <i class="bi bi-pie-chart"></i>
                                Admission Loss Reasons
                            </h6>
                            <span class="section-badge">Analysis</span>
                        </div>
                        <div class="section-body">
                            <div class="table-responsive">
                                <asp:GridView ID="gvLossReasons" runat="server" CssClass="table data-table" AutoGenerateColumns="false"
                                    ShowHeaderWhenEmpty="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <span class="row-num"><%# Container.DataItemIndex + 1 %></span>
                                            </ItemTemplate>
                                            <ItemStyle Width="50" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reason">
                                            <ItemTemplate>
                                                <span class="fw-semibold"><%# Eval("reason") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Count">
                                            <ItemTemplate>
                                                <span class="badge-status badge-warning">
                                                    <%# Eval("count") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="empty-state">
                                            <i class="bi bi-emoji-smile d-block text-success"></i>
                                            <p class="mb-0">No admission losses recorded</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Fee Collection Delays -->
                <div class="col-md-6">
                    <div class="section-card">
                        <div class="section-header">
                            <h6 class="section-title">
                                <i class="bi bi-cash-stack"></i>
                                Fee Collection Delays
                            </h6>
                            <span class="section-badge section-badge-danger" style="background:#fee2e2;color:#dc2626;">Action Required</span>
                        </div>
                        <div class="section-body">
                            <div class="table-responsive">
                                <asp:GridView ID="gvFeeDelays" runat="server" CssClass="table data-table" AutoGenerateColumns="false"
                                    OnRowDataBound="gvFeeDelays_RowDataBound" ShowHeaderWhenEmpty="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <span class="row-num"><%# Container.DataItemIndex + 1 %></span>
                                            </ItemTemplate>
                                            <ItemStyle Width="50" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Student">
                                            <ItemTemplate>
                                                <div>
                                                    <strong><%# Eval("studentName") %></strong>
                                                    <br /><small class="text-muted"><%# Eval("className") %></small>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount Due">
                                            <ItemTemplate>
                                                <span class='<%# GetAmountClass(Eval("totalDue")) %>'>
                                                    ?<%# FormatAmount(Eval("totalDue")) %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Overdue">
                                            <ItemTemplate>
                                                <span class='<%# GetDaysOverdueClass(Eval("daysOverdue")) %>'>
                                                    <%# Eval("daysOverdue") %> days
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reminder">
                                            <ItemTemplate>
                                                <span class='<%# GetReminderBadgeClass(Eval("lastReminderStatus")) %>'>
                                                    <%# Eval("lastReminderStatus") ?? "Not Sent" %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="empty-state">
                                            <i class="bi bi-check-circle d-block text-success"></i>
                                            <p class="mb-0">No fee delays - all payments on track</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
