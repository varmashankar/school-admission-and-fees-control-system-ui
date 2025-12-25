<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="notice.aspx.cs" Inherits="Dashboard_admin_notice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .stat-card {
            border: 1px solid #e9ecef;
            transition: box-shadow 0.2s ease, transform 0.2s ease;
        }

            .stat-card:hover {
                box-shadow: 0 0.75rem 1.5rem rgba(0,0,0,.08);
                transform: translateY(-3px);
            }
            .notice-actions .btn {
    padding: 0.25rem 0.5rem;
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <h3 class="text-xl font-bold text-gray-800">
        <i class="bi bi-megaphone me-2 text-primary"></i>
        Notice Management
    </h3>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row g-4 mb-4">

        <div class="col-md-3">
            <div class="card stat-card">
                <div class="card-body">
                    <small class="text-uppercase text-muted fw-semibold">
                        <i class="bi bi-bell-fill me-1 text-success"></i>
                        Active Notices
                    </small>

                    <div class="fs-3 fw-bold text-dark">6</div>
                    <small class="text-muted">Currently visible</small>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card">
                <div class="card-body">
                    <small class="text-uppercase text-muted fw-semibold">
                        <i class="bi bi-clock-history me-1 text-warning"></i>
                        Expiring Soon
                    </small>

                    <div class="fs-3 fw-bold text-warning">2</div>
                    <small class="text-muted">Next 7 days</small>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card">
                <div class="card-body">
                    <small class="text-uppercase text-muted fw-semibold">
                        <i class="bi bi-exclamation-triangle-fill me-1 text-danger"></i>
                        Important
                    </small>

                    <div class="fs-3 fw-bold text-danger">1</div>
                    <small class="text-muted">High priority</small>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card">
                <div class="card-body">
                    <small class="text-uppercase text-muted fw-semibold">
                        <i class="bi bi-archive-fill me-1 text-secondary"></i>
                        Expired
                    </small>

                    <div class="fs-3 fw-bold text-muted">3</div>
                    <small class="text-muted">Hidden automatically</small>
                </div>
            </div>
        </div>

    </div>

    <div class="container-fluid">
        <%-- Changed to container-fluid for full width, or keep container if you prefer fixed width --%>
       <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold text-dark mb-0">
            <i class="bi bi-megaphone me-2 text-primary"></i>
            Notices
        </h4>

        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNoticeModal">
            <i class="bi bi-plus-circle me-2"></i>
            Add Notice
        </button>
    </div>


        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead class="table-light">
                        <tr>
                            <th class="ps-4">
                                <i class="bi bi-hash me-1"></i>
                                #
                            </th>
                            <th>
                                <i class="bi bi-card-text me-1"></i>
                                Title
                            </th>
                            <th>
                                <i class="bi bi-calendar-event me-1"></i>
                                Published
                            </th>
                            <th>
                                <i class="bi bi-calendar-x me-1"></i>
                                Expiry
                            </th>
                            <th>
                                <i class="bi bi-flag me-1"></i>
                                Status
                            </th>
                            <th class="text-end pe-4">
                                <i class="bi bi-three-dots me-1"></i>
                                Actions
                            </th>
                        </tr>
                    </thead>
                                            <tbody id="noticeTableBody" runat="server">
                        <tr>
                            <td class="ps-4 fw-semibold text-muted">1</td>

                            <td>
                                <div class="fw-semibold text-dark">
                                    Half-Yearly Exam Schedule
                                </div>
                                <div class="small text-muted">
                                    Audience: All Classes
                                </div>
                            </td>

                            <td>26 Oct 2023</td>
                            <td>15 Nov 2023</td>

                            <td>
                                <span class="badge bg-success">
                                    <i class="bi bi-check-circle-fill me-1"></i>
                                    Active
                                </span>
                                <span class="badge bg-danger ms-1">
                                    <i class="bi bi-exclamation-circle-fill me-1"></i>
                                    Important
                                </span>
                            </td>

                            <td class="text-end pe-4 notice-actions">
                                <button class="btn btn-sm btn-outline-secondary" title="View">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-primary ms-1" title="Edit">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger ms-1" title="Delete">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>

                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add New Notice Modal -->
    <div class="modal fade" id="addNoticeModal" tabindex="-1" aria-labelledby="addNoticeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title" id="addNoticeModalLabel">Add New Notice</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="upAddNotice" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="txtNoticeTitle" class="form-label">Notice Title</label>
                                <asp:TextBox ID="txtNoticeTitle" runat="server" placeholder="Enter Notice Title" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtNoticeContent" class="form-label">Notice Content</label>
                                <asp:TextBox ID="txtNoticeContent" runat="server" placeholder="Enter Notice Content" TextMode="MultiLine" Rows="5" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="txtPublishedDate" class="form-label">Published Date</label>
                                    <asp:TextBox ID="txtPublishedDate" runat="server" TextMode="Date" CssClass="form-control" Required="true"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="txtExpiryDate" class="form-label">Expiry Date (Optional)</label>
                                    <asp:TextBox ID="txtExpiryDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="ddlNoticeAudience" class="form-label">Audience</label>
                                <asp:DropDownList ID="ddlNoticeAudience" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Students" Value="Students"></asp:ListItem>
                                    <asp:ListItem Text="Teachers" Value="Teachers"></asp:ListItem>
                                    <asp:ListItem Text="Parents" Value="Parents"></asp:ListItem>
                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="mb-3 form-check">
                                <asp:CheckBox ID="chkIsImportant" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label" for="chkIsImportant">Mark as Important</label>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveNotice" runat="server"
                        Text="Publish Notice"
                        CssClass="btn btn-primary" />
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        Cancel
                    </button>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js - Ensure these are not already in your Master Page -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        // JavaScript for initial date setting and re-opening modal after postback
        document.addEventListener('DOMContentLoaded', function () {
            // Set current date as default for publishedDate on client-side
            const publishedDateInput = document.getElementById('<%= txtPublishedDate.ClientID %>');
            if (publishedDateInput && !publishedDateInput.value) {
                const today = new Date();
                const year = today.getFullYear();
                const month = String(today.getMonth() + 1).padStart(2, '0');
                const day = String(today.getDate()).padStart(2, '0');
                publishedDateInput.value = `${year}-${month}-${day}`;
            }

            // If using UpdatePanel, sometimes Bootstrap modals need to be re-initialized
            // This script should be outside the UpdatePanel if possible, or handle Partial Page Rendering
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (sender, args) {
                if (sender._postBackSettings.panelsToUpdate.includes('<%= upAddNotice.ClientID %>')) {
                    // This might be needed if the modal disappears after an async postback
                    // var addNoticeModal = new bootstrap.Modal(document.getElementById('addNoticeModal'));
                    // addNoticeModal.show();
                    // However, for modal closing after save, this is not needed.
                    // Instead, we ensure the modal closes correctly in C#
                }
            });
        });
    </script>
</asp:Content>
