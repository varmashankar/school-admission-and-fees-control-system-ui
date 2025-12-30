<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeFile="inquiries.aspx.cs" Inherits="Dashboard_admin_inquiries" MasterPageFile="~/Master/admin.master" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Stats Cards */
        .stats-row {
            margin-bottom: 1.5rem;
        }

        .stat-card-mini {
            background: #fff;
            border-radius: .75rem;
            padding: 1rem 1.25rem;
            border: 1px solid rgba(0,0,0,.06);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

            .stat-card-mini:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,.08);
            }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: .5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

            .stat-icon.bg-primary-soft {
                background: #e0e7ff;
                color: #4f46e5;
            }

            .stat-icon.bg-success-soft {
                background: #d1fae5;
                color: #059669;
            }

            .stat-icon.bg-warning-soft {
                background: #fef3c7;
                color: #d97706;
            }

            .stat-icon.bg-danger-soft {
                background: #fee2e2;
                color: #dc2626;
            }

            .stat-icon.bg-info-soft {
                background: #dbeafe;
                color: #2563eb;
            }

        .stat-content .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1.2;
            color: #1f2937;
        }

        .stat-content .stat-label {
            font-size: .75rem;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: .03em;
        }

        /* Page Header */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .page-header-title h5 {
            margin: 0;
            font-weight: 600;
            color: #1f2937;
        }

        .page-header-title p {
            margin: 0;
            font-size: .85rem;
            color: #6b7280;
        }

        .page-header-actions {
            display: flex;
            gap: .5rem;
            flex-wrap: wrap;
        }

        /* Filter Section */
        .filter-section {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border: 1px solid #e2e8f0;
            border-radius: .75rem;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
        }

            .filter-section .form-label {
                font-size: .75rem;
                font-weight: 600;
                color: #475569;
                text-transform: uppercase;
                letter-spacing: .03em;
                margin-bottom: .35rem;
            }

            .filter-section .form-control,
            .filter-section .form-select {
                font-size: .85rem;
                border-color: #cbd5e1;
            }

                .filter-section .form-control:focus,
                .filter-section .form-select:focus {
                    border-color: #6366f1;
                    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
                }

        .filter-actions {
            display: flex;
            align-items: flex-end;
            gap: .5rem;
        }

        /* Table Styles */
        .table-container {
            background: #fff;
            border-radius: .75rem;
            border: 1px solid rgba(0,0,0,.06);
            overflow: hidden;
        }

        .table-header {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: .75rem;
        }

        .table-header-title {
            font-weight: 600;
            color: #1f2937;
            display: flex;
            align-items: center;
            gap: .5rem;
        }

            .table-header-title i {
                color: #6366f1;
            }

        .record-count {
            background: #f3f4f6;
            padding: .25rem .75rem;
            border-radius: 1rem;
            font-size: .75rem;
            color: #6b7280;
        }

        #gvInquiries {
            font-size: .83rem;
            margin-bottom: 0;
        }

            #gvInquiries thead th {
                background: #f9fafb;
                font-weight: 600;
                font-size: .75rem;
                text-transform: uppercase;
                letter-spacing: .03em;
                color: #6b7280;
                padding: .75rem .5rem;
                border-bottom: 2px solid #e5e7eb;
                white-space: nowrap;
            }

            #gvInquiries tbody td {
                padding: .75rem .5rem;
                vertical-align: middle;
                border-bottom: 1px solid #f3f4f6;
            }

            #gvInquiries tbody tr:hover {
                background: #f8fafc;
            }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: .35rem;
            padding: .25rem .65rem;
            border-radius: 1rem;
            font-size: .7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .03em;
        }

            .status-badge::before {
                content: '';
                width: 6px;
                height: 6px;
                border-radius: 50%;
                background: currentColor;
            }

        .status-new {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-in_progress {
            background: #fef3c7;
            color: #b45309;
        }

        .status-follow_up {
            background: #e0e7ff;
            color: #4338ca;
        }

        .status-visited {
            background: #d1fae5;
            color: #047857;
        }

        .status-converted {
            background: #dcfce7;
            color: #15803d;
        }

        .status-lost {
            background: #fee2e2;
            color: #b91c1c;
        }

        /* Contact Info */
        .contact-name {
            font-weight: 600;
            color: #1f2937;
        }

        .contact-detail {
            font-size: .8rem;
            color: #6b7280;
            display: flex;
            align-items: center;
            gap: .35rem;
        }

            .contact-detail i {
                font-size: .7rem;
                color: #9ca3af;
            }

        /* Inquiry Number */
        .inquiry-no {
            font-family: 'Consolas', monospace;
            font-size: .8rem;
            color: #6366f1;
            font-weight: 600;
        }

        /* Follow-up Date */
        .followup-date {
            font-size: .8rem;
        }

            .followup-date.overdue {
                color: #dc2626;
                font-weight: 600;
            }

            .followup-date.upcoming {
                color: #059669;
            }

            .followup-date.today {
                color: #d97706;
                font-weight: 600;
            }

        /* Actions Column */
        .inq-actions {
            display: flex;
            align-items: center;
            gap: .35rem;
            flex-wrap: nowrap;
        }

            .inq-actions .form-select {
                width: 110px !important;
                font-size: .75rem;
                padding: .25rem .5rem;
                border-color: #d1d5db;
            }

        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: .375rem;
            transition: all 0.2s ease;
        }

            .btn-action i {
                font-size: .9rem;
            }

            .btn-action:hover {
                transform: scale(1.1);
            }

        /* DataTables overrides */
        div.dataTables_wrapper {
            padding: 0 1.25rem;
        }

            div.dataTables_wrapper div.dataTables_length,
            div.dataTables_wrapper div.dataTables_filter {
                font-size: .8rem;
                margin-bottom: .75rem;
                padding-top: .75rem;
            }

                div.dataTables_wrapper div.dataTables_length label {
                    display: flex;
                    align-items: center;
                    gap: .5rem;
                }

                div.dataTables_wrapper div.dataTables_length select {
                    padding: .35rem 2rem .35rem .65rem;
                    border-radius: .375rem;
                    border: 1px solid #d1d5db;
                    background-color: #fff;
                    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
                    background-repeat: no-repeat;
                    background-position: right .5rem center;
                    background-size: 12px 12px;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                    cursor: pointer;
                }

                    /* Remove any checkmark or icon inside the select */
                    div.dataTables_wrapper div.dataTables_length select option {
                        background: #fff;
                    }

                div.dataTables_wrapper div.dataTables_filter label {
                    display: flex;
                    align-items: center;
                    gap: .5rem;
                }

                div.dataTables_wrapper div.dataTables_filter input {
                    font-size: .8rem;
                    padding: .35rem .65rem;
                    border-radius: .375rem;
                    border: 1px solid #d1d5db;
                }

                    div.dataTables_wrapper div.dataTables_filter input:focus,
                    div.dataTables_wrapper div.dataTables_length select:focus {
                        border-color: #6366f1;
                        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
                        outline: none;
                    }

            div.dataTables_wrapper div.dataTables_info {
                font-size: .8rem;
                color: #6b7280;
                padding: .75rem 0;
            }

            div.dataTables_wrapper div.dataTables_paginate {
                font-size: .8rem;
                padding: .75rem 0;
            }

                div.dataTables_wrapper div.dataTables_paginate .paginate_button {
                    padding: .35rem .65rem;
                    border-radius: .375rem;
                    margin: 0 .15rem;
                }

                    div.dataTables_wrapper div.dataTables_paginate .paginate_button.current {
                        background: #6366f1;
                        color: #fff !important;
                        border-color: #6366f1;
                    }

                    div.dataTables_wrapper div.dataTables_paginate .paginate_button:hover:not(.current) {
                        background: #f3f4f6;
                        border-color: #d1d5db;
                        color: #1f2937 !important;
                    }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
        }

            .empty-state i {
                font-size: 3rem;
                color: #d1d5db;
            }

            .empty-state h6 {
                color: #6b7280;
                margin-bottom: .5rem;
            }

            .empty-state p {
                font-size: .85rem;
                color: #9ca3af;
            }

        .btn-icon-top {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 2px;
            padding: .4rem .65rem;
        }

            .btn-icon-top i {
                font-size: 1rem;
                line-height: 1;
            }

            .btn-icon-top span {
                font-size: .65rem;
                line-height: 1;
                text-transform: uppercase;
                letter-spacing: .04em;
            }


        /* Responsive */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .filter-section .row > div {
                margin-bottom: .5rem;
            }

            .inq-actions {
                flex-wrap: wrap;
            }
        }

        /* Column filter row */
        #gvInquiries .filters th {
            padding: .35rem;
            background: #fff;
            border-bottom: 1px solid #e5e7eb;
        }

        #gvInquiries .filters .form-control {
            font-size: .7rem;
            padding: .25rem .4rem;
            border-color: #e5e7eb;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <div class="d-flex align-items-center gap-2">
        <div class="d-flex flex-column">
            <h5 class="m-0">Inquiries</h5>
            <span class="text-muted small d-none d-md-block">Manage leads and track follow-ups</span>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        
        <!-- Stats Row -->
        <div class="row g-3 stats-row">
            <div class="col-6 col-lg-3">
                <div class="stat-card-mini">
                    <div class="stat-icon bg-primary-soft">
                        <i class="bi bi-clipboard-data"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value" id="statTotal">--</div>
                        <div class="stat-label">Total Inquiries</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card-mini">
                    <div class="stat-icon bg-warning-soft">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value" id="statPending">--</div>
                        <div class="stat-label">Pending Follow-up</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card-mini">
                    <div class="stat-icon bg-success-soft">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value" id="statConverted">--</div>
                        <div class="stat-label">Converted</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card-mini">
                    <div class="stat-icon bg-info-soft">
                        <i class="bi bi-calendar-plus"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value" id="statToday">--</div>
                        <div class="stat-label">Today's Follow-ups</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Page Header with Actions -->
        <div class="page-header">
            <div class="page-header-title">
                <h5><i class="bi bi-list-ul me-2 text-primary"></i>Inquiry List</h5>
                <p>View, filter, and manage all admission inquiries</p>
            </div>
            <div class="page-header-actions">
                <a href="inquiry-create.aspx" class="btn btn-primary btn-sm">
                    <i class="bi bi-plus-lg me-1"></i>New Inquiry
                </a>
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnRefresh_Click">
                    <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                </asp:LinkButton>
                <div class="dropdown">
                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class="bi bi-download me-1"></i>Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#" onclick="exportTable('excel')"><i class="bi bi-file-earmark-excel me-2"></i>Excel</a></li>
                        <li><a class="dropdown-item" href="#" onclick="exportTable('pdf')"><i class="bi bi-file-earmark-pdf me-2"></i>PDF</a></li>
                        <li><a class="dropdown-item" href="#" onclick="window.print()"><i class="bi bi-printer me-2"></i>Print</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="row g-3 align-items-end">
                <div class="col-md-3 col-sm-6">
                    <label class="form-label">Inquiry No</label>
                    <div class="input-group input-group-sm">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearchInquiryNo" runat="server" CssClass="form-control" placeholder="INQ-2025-0001" />
                    </div>
                </div>
                <div class="col-md-2 col-sm-6">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm" />
                </div>
                <div class="col-md-2 col-sm-6">
                    <label class="form-label">From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control form-control-sm" TextMode="Date" />
                </div>
                <div class="col-md-2 col-sm-6">
                    <label class="form-label">To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control form-control-sm" TextMode="Date" />
                </div>
                <div class="col-md-3 filter-actions">
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary btn-sm" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-outline-secondary btn-sm" Text="Clear" OnClick="btnClear_Click" />
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-header-title">
                    <i class="bi bi-table"></i>
                    <span>All Inquiries</span>
                    <span class="record-count">
                        <asp:Label ID="lblRecordCount" runat="server" Text="0 records" />
                    </span>
                </div>
                <div class="d-flex gap-2">
                    <a href="inquiry-followups.aspx" class="btn btn-outline-warning btn-sm">
                        <i class="bi bi-clock-history me-1"></i>Due Follow-ups
                    </a>
                </div>
            </div>
            
            <div class="table-responsive">
                <asp:GridView ID="gvInquiries" runat="server"
                    ClientIDMode="Static"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0 js-datatable"
                    OnRowCommand="gvInquiries_RowCommand"
                    OnRowCreated="gvInquiries_RowCreated"
                    OnRowDataBound="gvInquiries_RowDataBound"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="">
                    <Columns>
                        <asp:TemplateField HeaderText="Inquiry No">
                            <ItemTemplate>
                                <span class="inquiry-no"><%# Eval("inquiryNo") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact">
                            <ItemTemplate>
                                <div class="contact-name"><%# Eval("firstName") %> <%# Eval("lastName") %></div>
                                <div class="contact-detail"><i class="bi bi-telephone"></i> <%# Eval("phone") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <div class="contact-detail"><i class="bi bi-envelope"></i> <%# Eval("email") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='status-badge status-<%# Eval("status") != null ? Eval("status").ToString().ToLower() : "new" %>'>
                                    <%# FormatStatus(Eval("status")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Next Follow-up">
                            <ItemTemplate>
                                <span class='followup-date <%# GetFollowUpClass(Eval("nextFollowUpAt")) %>'>
                                    <%# FormatFollowUpDate(Eval("nextFollowUpAt")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:HiddenField ID="hfInquiryId" runat="server" Value='<%# Eval("id") %>' />
                                <div class="inq-actions">
                                    <asp:DropDownList ID="ddlRowStatus" runat="server" CssClass="form-select form-select-sm" />
                                    
                                    <asp:LinkButton ID="btnUpdateStatus" runat="server"
                                        CssClass="btn btn-outline-success btn-action"
                                        CommandName="ChangeStatus"
                                        CommandArgument='<%# Eval("id") %>'
                                        ToolTip="Update status">
                                        <i class="bi bi-check2-circle"></i>
                                    </asp:LinkButton>

                                    <a class="btn btn-outline-primary btn-action"
                                        title="View Follow-ups"
                                        href='<%# "inquiry-followups.aspx?inquiryId=" + Eval("id") %>'>
                                        <i class="bi bi-clock-history"></i>
                                    </a>
                                    
                                    <a class="btn btn-outline-secondary btn-action"
                                        title="View Details"
                                        href='<%# "inquiry-details.aspx?id=" + Eval("id") %>'>
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h6>No inquiries found</h6>
                            <p>Try adjusting your filters or create a new inquiry</p>
                            <div class="mt-2">
                                <a href="inquiry-create.aspx" class="btn btn-primary btn-sm btn-icon-top d-inline-flex">
                                    <i class="bi bi-plus-lg"></i>
                                    <span>New Inquiry</span>
                                </a>
                            </div>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

        <asp:Label ID="lblInfo" runat="server" CssClass="text-muted small mt-2 d-block" Visible="false" />
    </div>

    <script type="text/javascript">
        // Update stats based on table data
        function updateStats() {
            const table = document.getElementById('gvInquiries');
            if (!table) return;

            const rows = table.querySelectorAll('tbody tr');
            let total = 0, pending = 0, converted = 0, todayFollowups = 0;
            const today = new Date().toDateString();

            rows.forEach(row => {
                if (row.classList.contains('filters') || row.querySelector('.empty-state')) return;
                total++;

                const statusBadge = row.querySelector('.status-badge');
                if (statusBadge) {
                    const status = statusBadge.textContent.trim().toUpperCase();
                    if (status === 'NEW' || status === 'IN PROGRESS' || status === 'FOLLOW UP') pending++;
                    if (status === 'CONVERTED') converted++;
                }

                const followupEl = row.querySelector('.followup-date');
                if (followupEl && followupEl.classList.contains('today')) todayFollowups++;
            });

            document.getElementById('statTotal').textContent = total;
            document.getElementById('statPending').textContent = pending;
            document.getElementById('statConverted').textContent = converted;
            document.getElementById('statToday').textContent = todayFollowups;
        }

        // Export table functionality
        function exportTable(format) {
            if (format === 'excel') {
                // Simple CSV export
                const table = document.getElementById('gvInquiries');
                if (!table) return;
                
                let csv = [];
                const rows = table.querySelectorAll('tr');
                rows.forEach(row => {
                    if (row.classList.contains('filters')) return;
                    const cols = row.querySelectorAll('td, th');
                    let rowData = [];
                    cols.forEach((col, idx) => {
                        if (idx < cols.length - 1) { // Skip actions column
                            rowData.push('"' + col.textContent.trim().replace(/"/g, '""') + '"');
                        }
                    });
                    csv.push(rowData.join(','));
                });
                
                const blob = new Blob([csv.join('\n')], { type: 'text/csv' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'inquiries_' + new Date().toISOString().split('T')[0] + '.csv';
                a.click();
            } else if (format === 'pdf') {
                window.print();
            }
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            
            // Re-update stats after DataTable init
            setTimeout(updateStats, 500);
        });

        // Update stats after any postback
        if (typeof Sys !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                setTimeout(updateStats, 300);
            });
        }
    </script>
</asp:Content>
