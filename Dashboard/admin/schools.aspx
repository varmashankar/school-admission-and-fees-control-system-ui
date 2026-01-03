<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="schools.aspx.cs" Inherits="Dashboard_admin_schools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
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

        #gvSchools {
            font-size: .85rem;
            margin-bottom: 0;
        }

        #gvSchools thead th {
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

        #gvSchools tbody td {
            padding: .75rem .5rem;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }

        #gvSchools tbody tr:hover {
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

        .status-active {
            background: #d1fae5;
            color: #047857;
        }

        .status-inactive {
            background: #f3f4f6;
            color: #6b7280;
        }

        /* School Info */
        .school-name {
            font-weight: 600;
            color: #1f2937;
        }

        .school-code {
            font-family: 'Consolas', monospace;
            font-size: .8rem;
            color: #6366f1;
            font-weight: 600;
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

        /* Actions Column */
        .school-actions {
            display: flex;
            align-items: center;
            gap: .35rem;
            flex-wrap: nowrap;
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

            .school-actions {
                flex-wrap: wrap;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center gap-2">
        <div class="d-flex flex-column">
            <h5 class="m-0">Schools</h5>
            <span class="text-muted small d-none d-md-block">Manage school information</span>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid">

        <!-- Page Header with Actions -->
        <div class="page-header">
            <div class="page-header-title">
                <h5><i class="bi bi-building me-2 text-primary"></i>School List</h5>
                <p>View and manage school details</p>
            </div>
            <div class="page-header-actions">
                <a href="addnewschool.aspx" class="btn btn-primary btn-sm">
                    <i class="bi bi-plus-lg me-1"></i>Add School
                </a>
                <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnRefresh_Click">
                    <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                </asp:LinkButton>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-header-title">
                    <i class="bi bi-table"></i>
                    <span>All Schools</span>
                    <span class="record-count">
                        <asp:Label ID="lblRecordCount" runat="server" Text="0 records" />
                    </span>
                </div>
            </div>
            
            <div class="table-responsive">
                <asp:GridView ID="gvSchools" runat="server"
                    ClientIDMode="Static"
                    AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle mb-0"
                    OnRowCommand="gvSchools_RowCommand"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="">
                    <Columns>
                        <asp:TemplateField HeaderText="School Name">
                            <ItemTemplate>
                                <div class="school-name"><%# Eval("school_name") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code">
                            <ItemTemplate>
                                <span class="school-code"><%# Eval("code") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone">
                            <ItemTemplate>
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
                                <span class='status-badge <%# Convert.ToBoolean(Eval("status")) ? "status-active" : "status-inactive" %>'>
                                    <%# Convert.ToBoolean(Eval("status")) ? "Active" : "Inactive" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="school-actions">
                                    <asp:LinkButton ID="lnkEdit" runat="server" 
                                        CommandName="EditItem" 
                                        CommandArgument='<%# Eval("id") %>' 
                                        CssClass="btn btn-outline-primary btn-action"
                                        ToolTip="Edit School">
                                        <i class="bi bi-pencil"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkToggleStatus" runat="server" 
                                        CommandName="ToggleStatus" 
                                        CommandArgument='<%# Eval("id") + "|" + Eval("status") %>' 
                                        CssClass="btn btn-outline-warning btn-action" 
                                        ToolTip="Toggle Status">
                                        <i class="bi bi-toggle-on"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" 
                                        CommandName="DeleteItem" 
                                        CommandArgument='<%# Eval("id") %>' 
                                        CssClass="btn btn-outline-danger btn-action"
                                        ToolTip="Delete School">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="bi bi-building"></i>
                            <h6>No schools found</h6>
                            <p>Click "Add School" to create a new school</p>
                            <div class="mt-2">
                                <a href="addnewschool.aspx" class="btn btn-primary btn-sm btn-icon-top d-inline-flex">
                                    <i class="bi bi-plus-lg me-1"></i>Add School
                                </a>
                            </div>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

        <asp:Label ID="lblInfo" runat="server" CssClass="text-muted small mt-2 d-block" Visible="false" />
    </div>
</asp:Content>
