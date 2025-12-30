<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeFile="inquiry-followups.aspx.cs" Inherits="Dashboard_admin_inquiry_followups" MasterPageFile="~/Master/admin.master" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="Server">
    <style>
        .page-toolbar { gap: .5rem; }

        .panel-title {
            display: flex;
            align-items: center;
            gap: .5rem;
        }

        .filter-card {
            background: linear-gradient(135deg, #fafbfc 0%, #ffffff 100%);
            border: 1px solid rgba(0,0,0,.06);
            border-radius: .75rem;
            padding: 1.25rem;
        }

        .filter-card .form-label {
            margin-bottom: .35rem;
            font-size: .8rem;
            font-weight: 600;
            color: #4b5563;
            text-transform: uppercase;
            letter-spacing: .025em;
        }

        .badge-soft {
            background: linear-gradient(135deg, #eef2ff 0%, #e0e7ff 100%);
            color: #3730a3;
            border: 1px solid rgba(99,102,241,.25);
            padding: .45rem .85rem;
            border-radius: 999px;
            font-size: .8rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: .4rem;
        }

        .preset-row {
            display: flex;
            gap: .4rem;
            flex-wrap: wrap;
            margin-top: .35rem;
        }

        .preset-row .btn {
            border-radius: 999px;
            font-size: .72rem;
            padding: .25rem .6rem;
        }

        /* Stats Cards */
        .stats-row { display: flex; gap: .75rem; flex-wrap: wrap; margin-bottom: 1rem; }
        .stat-card {
            flex: 1;
            min-width: 100px;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: .75rem;
            padding: .75rem 1rem;
            text-align: center;
            transition: all .2s ease;
        }
        .stat-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,.08); transform: translateY(-2px); }
        .stat-card .stat-value { font-size: 1.5rem; font-weight: 700; color: #1e293b; }
        .stat-card .stat-label { font-size: .72rem; color: #64748b; text-transform: uppercase; letter-spacing: .05em; }
        .stat-card.stat-pending { border-left: 3px solid #f59e0b; }
        .stat-card.stat-overdue { border-left: 3px solid #ef4444; }
        .stat-card.stat-today { border-left: 3px solid #3b82f6; }
        .stat-card.stat-completed { border-left: 3px solid #10b981; }

        /* Grid Styles */
        #gvDue { font-size: .85rem; border-collapse: separate; border-spacing: 0; }
        #gvDue thead th { 
            white-space: nowrap; 
            font-size: .72rem; 
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            text-transform: uppercase;
            letter-spacing: .05em;
            color: #64748b;
            font-weight: 600;
            padding: .6rem .7rem;
            border-bottom: 2px solid #e2e8f0;
        }
        #gvDue td { 
            vertical-align: middle; 
            padding: .55rem .7rem; 
            word-break: break-word;
            border-bottom: 1px solid #f1f5f9;
        }
        #gvDue tbody tr { transition: all .15s ease; }
        #gvDue tbody tr:hover { background: #f8fafc; }
        #gvDue tbody tr.row-overdue { background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%); border-left: 3px solid #ef4444; }
        #gvDue tbody tr.row-today { background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%); border-left: 3px solid #3b82f6; }

        /* Channel Badges */
        .channel-badge {
            display: inline-flex;
            align-items: center;
            gap: .3rem;
            padding: .25rem .55rem;
            border-radius: .4rem;
            font-size: .72rem;
            font-weight: 600;
        }
        .channel-call { background: #dbeafe; color: #1d4ed8; }
        .channel-whatsapp { background: #dcfce7; color: #15803d; }
        .channel-email { background: #fef3c7; color: #b45309; }
        .channel-visit { background: #f3e8ff; color: #7c3aed; }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: .25rem;
            padding: .2rem .5rem;
            border-radius: 999px;
            font-size: .7rem;
            font-weight: 600;
        }
        .status-pending { background: #fef9c3; color: #a16207; }
        .status-done { background: #d1fae5; color: #047857; }
        .status-overdue { background: #fee2e2; color: #dc2626; }

        /* Time Display */
        .time-display { display: flex; flex-direction: column; gap: .1rem; }
        .time-display .date { font-weight: 600; color: #334155; font-size: .82rem; }
        .time-display .time { font-size: .72rem; color: #64748b; }
        .time-display.overdue .date, .time-display.overdue .time { color: #dc2626; }

        /* Filter Row */
        .filter-row {
            display: flex;
            gap: .75rem;
            flex-wrap: wrap;
            align-items: flex-end;
            margin-bottom: 1rem;
            padding: .75rem;
            background: #f8fafc;
            border-radius: .5rem;
        }
        .filter-row .filter-item { display: flex; flex-direction: column; gap: .25rem; }
        .filter-row .filter-item label { font-size: .7rem; color: #64748b; text-transform: uppercase; }
        .filter-row .filter-item .form-control,
        .filter-row .filter-item .form-select { font-size: .8rem; padding: .35rem .5rem; }

        /* Row Number */
        .row-num {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            background: #f1f5f9;
            border-radius: 50%;
            font-size: .75rem;
            font-weight: 600;
            color: #475569;
        }

        /* Action Buttons */
        .btn-action { border-radius: .4rem; font-size: .72rem; padding: .3rem .5rem; }
        .action-group { display: flex; gap: .3rem; }

        /* Empty State */
        .empty-state { text-align: center; padding: 2.5rem 1rem; color: #94a3b8; }
        .empty-state i { font-size: 2.5rem; margin-bottom: .75rem; opacity: .5; }

        .form-control, .form-select { font-size: .9rem; border-radius: .5rem; }

        /* Section Header */
        .section-header {
            display: flex;
            align-items: center;
            gap: .5rem;
            padding-bottom: .6rem;
            margin-bottom: .75rem;
            border-bottom: 2px solid #f1f5f9;
        }
        .section-header i { font-size: 1rem; color: #6366f1; }

        /* Inquiry Link */
        .inquiry-link { color: #6366f1; font-weight: 600; text-decoration: none; }
        .inquiry-link:hover { text-decoration: underline; }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <div class="d-flex align-items-center justify-content-between">
        <div class="d-flex flex-column">
            <h5 class="m-0 fw-bold">Inquiry Follow-ups</h5>
            <span class="text-muted small">Schedule and track follow-up reminders</span>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <asp:HiddenField ID="hfInquiryId" runat="server" />
        <asp:HiddenField ID="hfEditFollowUpId" runat="server" />

        <%--<div class="mb-3">
            <asp:Label ID="lblSelectedInquiry" runat="server" CssClass="badge-soft">
                <i class="bi bi-info-circle"></i> Select an inquiry
            </asp:Label>
        </div>--%>

        <!-- Stats Cards -->
        <div class="stats-row">
            <div class="stat-card stat-pending">
                <div class="stat-value"><asp:Literal ID="litPendingCount" runat="server">0</asp:Literal></div>
                <div class="stat-label"><i class="bi bi-hourglass-split me-1"></i>Pending</div>
            </div>
            <div class="stat-card stat-overdue">
                <div class="stat-value"><asp:Literal ID="litOverdueCount" runat="server">0</asp:Literal></div>
                <div class="stat-label"><i class="bi bi-exclamation-triangle me-1"></i>Overdue</div>
            </div>
            <div class="stat-card stat-today">
                <div class="stat-value"><asp:Literal ID="litTodayCount" runat="server">0</asp:Literal></div>
                <div class="stat-label"><i class="bi bi-calendar-day me-1"></i>Today</div>
            </div>
            <div class="stat-card stat-completed">
                <div class="stat-value"><asp:Literal ID="litCompletedCount" runat="server">0</asp:Literal></div>
                <div class="stat-label"><i class="bi bi-check-circle me-1"></i>Completed</div>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-12 col-lg-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="section-header">
                            <i class="bi bi-plus-circle-fill"></i>
                            <h6 class="m-0 fw-semibold">
                                <asp:Literal ID="litFormTitle" runat="server">Add Follow-up</asp:Literal>
                            </h6>
                        </div>

                        <div class="filter-card">
                            <div class="mb-2">
                                <label class="form-label" for="ddlInquiry">
                                    <i class="bi bi-person-lines-fill me-1"></i>Inquiry
                                </label>
                                <asp:DropDownList ID="ddlInquiry" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlInquiry_SelectedIndexChanged" />
                                <small class="text-muted d-block mt-1">Select an inquiry to add a follow-up and filter the list.</small>
                            </div>

                            <div class="mb-2">
                                <label class="form-label" for="txtFollowUpAt">
                                    <i class="bi bi-calendar-event me-1"></i>Follow Up At
                                </label>
                                <asp:TextBox ID="txtFollowUpAt" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />
                                <div class="preset-row">
                                    <asp:LinkButton ID="btnPreset30" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnPreset30_Click" CausesValidation="false">+30m</asp:LinkButton>
                                    <asp:LinkButton ID="btnPreset1h" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnPreset1h_Click" CausesValidation="false">+1h</asp:LinkButton>
                                    <asp:LinkButton ID="btnPreset2h" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnPreset2h_Click" CausesValidation="false">+2h</asp:LinkButton>
                                    <asp:LinkButton ID="btnPresetTomorrow" runat="server" CssClass="btn btn-outline-primary" OnClick="btnPresetTomorrow_Click" CausesValidation="false">Tomorrow 10AM</asp:LinkButton>
                                    <asp:LinkButton ID="btnPresetNextWeek" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnPresetNextWeek_Click" CausesValidation="false">Next Week</asp:LinkButton>
                                </div>
                            </div>

                            <div class="mb-2">
                                <label class="form-label" for="ddlChannel">
                                    <i class="bi bi-broadcast me-1"></i>Channel
                                </label>
                                <asp:DropDownList ID="ddlChannel" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="📞 Call" Value="CALL" />
                                    <asp:ListItem Text="💬 WhatsApp" Value="WHATSAPP" />
                                    <asp:ListItem Text="✉️ Email" Value="EMAIL" />
                                    <asp:ListItem Text="🏠 Visit" Value="VISIT" />
                                </asp:DropDownList>
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="txtRemarks">
                                    <i class="bi bi-chat-left-text me-1"></i>Remarks
                                </label>
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter notes for this follow-up..." />
                            </div>

                            <div class="d-flex gap-2 flex-wrap align-items-center">
                                <asp:LinkButton ID="btnSaveFollowUp" runat="server" CssClass="btn btn-primary btn-sm" OnClick="btnSaveFollowUp_Click">
                                    <i class="bi bi-check-circle me-1"></i>Save Follow-up
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancelEdit" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnCancelEdit_Click" Visible="false">
                                    <i class="bi bi-x-circle me-1"></i>Cancel
                                </asp:LinkButton>
                                <a class="btn btn-light border btn-sm" href="inquiries.aspx">
                                    <i class="bi bi-arrow-left me-1"></i>Back
                                </a>
                            </div>

                            <asp:Label ID="lblInfo" runat="server" CssClass="text-muted small d-block mt-2" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-7">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <div class="section-header mb-0 pb-0 border-0">
                                <i class="bi bi-clock-history"></i>
                                <h6 class="m-0 fw-semibold">Due Follow-ups</h6>
                            </div>
                            <div class="d-flex gap-2">
                                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="btnExport_Click" ToolTip="Export to Excel">
                                    <i class="bi bi-file-earmark-excel"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-outline-primary btn-sm" OnClick="btnRefresh_Click">
                                    <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                                </asp:LinkButton>
                            </div>
                        </div>

                        <!-- Filter Row -->
                        <div class="filter-row">
                            <div class="filter-item">
                                <label>Status</label>
                                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                                    <asp:ListItem Text="All" Value="" />
                                    <asp:ListItem Text="Pending" Value="PENDING" Selected="True" />
                                    <asp:ListItem Text="Completed" Value="COMPLETED" />
                                </asp:DropDownList>
                            </div>
                            <div class="filter-item">
                                <label>From Date</label>
                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="true" OnTextChanged="txtDateFilter_Changed" />
                            </div>
                            <div class="filter-item">
                                <label>To Date</label>
                                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="true" OnTextChanged="txtDateFilter_Changed" />
                            </div>
                            <div class="filter-item">
                                <asp:LinkButton ID="btnClearFilters" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnClearFilters_Click">
                                    <i class="bi bi-x-lg me-1"></i>Clear
                                </asp:LinkButton>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <asp:GridView ID="gvDue" runat="server"
                                ClientIDMode="Static"
                                AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0"
                                OnRowCommand="gvDue_RowCommand"
                                OnRowDataBound="gvDue_RowDataBound"
                                ShowHeaderWhenEmpty="True"
                                DataKeyNames="id">
                                <Columns>
                                    <asp:TemplateField HeaderText="#">
                                        <ItemTemplate>
                                            <span class="row-num"><%# Container.DataItemIndex + 1 %></span>
                                        </ItemTemplate>
                                        <ItemStyle Width="45" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Inquiry">
                                        <ItemTemplate>
                                            <a href='<%# "inquiries.aspx?id=" + Eval("inquiryId") %>' class="inquiry-link" title="View Inquiry">
                                                #<%# Eval("inquiryId") %>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Follow Up At">
                                        <ItemTemplate>
                                            <div class='<%# GetTimeDisplayClass(Eval("followUpAt"), Eval("isReminded")) %>'>
                                                <span class="date"><%# FormatDate(Eval("followUpAt")) %></span>
                                                <span class="time"><%# FormatTime(Eval("followUpAt")) %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Channel">
                                        <ItemTemplate>
                                            <span class='<%# GetChannelBadgeClass(Eval("channel")) %>'>
                                                <i class='<%# GetChannelIcon(Eval("channel")) %>'></i>
                                                <%# Eval("channel") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks">
                                        <ItemTemplate>
                                            <span class="text-muted" title='<%# Eval("remarks") %>'>
                                                <%# TruncateText(Eval("remarks"), 30) %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='<%# GetStatusBadgeClass(Eval("followUpAt"), Eval("isReminded")) %>'>
                                                <i class='<%# GetStatusIcon(Eval("followUpAt"), Eval("isReminded")) %>'></i>
                                                <%# GetStatusText(Eval("followUpAt"), Eval("isReminded")) %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="action-group">
                                                <asp:LinkButton ID="btnMark" runat="server"
                                                    CssClass="btn btn-action btn-outline-success"
                                                    CommandName="MarkReminded"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    ToolTip="Mark as completed"
                                                    Visible='<%# !Convert.ToBoolean(Eval("isReminded")) %>'>
                                                    <i class="bi bi-check2"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="btn btn-action btn-outline-primary"
                                                    CommandName="EditFollowUp"
                                                    CommandArgument='<%# Eval("id") + "," + Eval("inquiryId") + "," + Eval("followUpAt") + "," + Eval("channel") + "," + Eval("remarks") %>'
                                                    ToolTip="Edit follow-up"
                                                    Visible='<%# !Convert.ToBoolean(Eval("isReminded")) %>'>
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    CssClass="btn btn-action btn-outline-danger"
                                                    CommandName="DeleteFollowUp"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    ToolTip="Delete follow-up"
                                                    OnClientClick="return confirm('Are you sure you want to delete this follow-up?');">
                                                    <i class="bi bi-trash"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state">
                                        <i class="bi bi-calendar-x d-block"></i>
                                        <p class="fw-semibold mb-1">No follow-ups found</p>
                                        <p class="small mb-0">Add a new follow-up using the form on the left.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
