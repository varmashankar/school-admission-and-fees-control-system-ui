<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="addstudentdetails.aspx.cs" Inherits="Dashboard_admin_addstudentdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .student-info-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            border-left: 4px solid #0d6efd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .nav-tabs {
            border-bottom: 2px solid #e9ecef;
        }

        .nav-link {
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 8px 8px 0 0;
            margin-right: 4px;
            transition: all 0.2s ease;
            color: #495057;
        }

            .nav-link:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
            }

            .nav-link.active {
                background-color: #fff;
                border-color: #e9ecef #e9ecef #fff;
                border-top: 3px solid #0d6efd;
                font-weight: 600;
            }

        .tab-pane {
            padding: 25px;
            border-left: 1px solid #dee2e6;
            border-right: 1px solid #dee2e6;
            border-bottom: 1px solid #dee2e6;
            border-radius: 0 0 8px 8px;
            background: #fff;
        }

        .form-floating > .form-control:focus,
        .form-floating > .form-control:not(:placeholder-shown) {
            padding-top: 1.625rem;
            padding-bottom: 0.625rem;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
            border-color: #86b7fe;
        }

        .btn-primary {
            transition: all 0.2s ease;
            border-radius: 8px;
            font-weight: 500;
        }

            .btn-primary:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(13, 110, 253, 0.2);
            }

        .table-hover tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.05);
        }

        .progress {
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-bar {
            background: linear-gradient(90deg, #0d6efd, #0dcaf0);
            transition: width 0.6s ease;
        }

        .info-item {
            padding: 8px 0;
        }

            .info-item label {
                font-size: 0.85rem;
                letter-spacing: 0.3px;
            }

        .empty-state {
            opacity: 0.6;
            transition: opacity 0.3s ease;
        }

            .empty-state:hover {
                opacity: 0.8;
            }

        .badge {
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 6px;
        }

        .card {
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.04);
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 2px solid #f0f0f0;
            background: linear-gradient(to right, #ffffff, #f8f9fa);
        }

        .table {
            border-radius: 8px;
            overflow: hidden;
        }

            .table thead th {
                border-top: none;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: #495057;
                background-color: #f8f9fa;
                padding: 12px 16px;
            }

            .table tbody td {
                padding: 14px 16px;
                vertical-align: middle;
            }

        .btn-sm {
            padding: 4px 10px;
            border-radius: 6px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <div class="d-flex align-items-center">
        <a href="students.aspx" class="btn btn-light btn-sm me-3" style="border-radius: 8px;">
            <i class="bi bi-arrow-left me-1"></i>Back
        </a>
        <div>
            <h3 class="text-dark fw-bold mb-0">Add Student Details</h3>

            <%--<nav aria-label="breadcrumb" style="--bs-breadcrumb-divider: '›';">
                <ol class="breadcrumb mb-0" style="font-size: 0.875rem;">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="students.aspx">Students</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Add Details</li>
                </ol>
            </nav>--%>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:HiddenField ID="hfActiveTab" runat="server" />

    <asp:HiddenField ID="hfStudentId" runat="server" />

    <!-- Success/Error Messages -->
    <div class="row mb-2">
        <div class="col-12">
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <asp:Label ID="lblSuccessMessage" runat="server" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </asp:Panel>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <asp:Label ID="lblErrorMessage" runat="server" />
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </asp:Panel>
        </div>
    </div>

    <%--<!-- Progress Indicator -->
    <div class="d-flex align-items-center mb-4">
        <div class="progress flex-grow-1" style="height: 6px;">
            <div class="progress-bar" role="progressbar" style="width: 25%;"></div>
        </div>
        <span class="ms-3 text-muted small">Step 1 of 4</span>
    </div>--%>

    <div class="card">
        <div class="card-header">
            <h5 class="fw-bold mb-0 d-flex align-items-center">
                <i class="bi bi-person-circle me-2 text-primary"></i>
                Student: 
                <asp:Label ID="lblStudentName" runat="server" CssClass="ms-2" />
            </h5>
        </div>

        <!-- Enhanced Student Info Section -->
        <div class="student-info-card p-4 mb-4 mx-3 mt-3">
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="info-item">
                        <label class="text-muted small mb-1 d-flex align-items-center">
                            <i class="bi bi-id-card me-1"></i>Student ID
                        </label>
                        <div class="fw-bold text-dark">
                            <asp:Label ID="lblSID" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item">
                        <label class="text-muted small mb-1 d-flex align-items-center">
                            <i class="bi bi-calendar-event me-1"></i>Date of Birth
                        </label>
                        <div class="fw-bold text-dark">
                            <asp:Label ID="lblDOB" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item">
                        <label class="text-muted small mb-1 d-flex align-items-center">
                            <i class="bi bi-mortarboard me-1"></i>Class
                        </label>
                        <div class="fw-bold text-dark">
                            <asp:Label ID="lblClass" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item">
                        <label class="text-muted small mb-1 d-flex align-items-center">
                            <i class="bi bi-phone me-1"></i>Mobile
                        </label>
                        <div class="fw-bold text-dark">
                            <asp:Label ID="lblPhone" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-body pt-0">

            <!-- Enhanced Bootstrap Tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active d-flex align-items-center" data-bs-toggle="tab" href="#parentTab">
                        <i class="bi bi-people-fill me-2"></i>
                        Parents
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link d-flex align-items-center" data-bs-toggle="tab" href="#emergencyTab">
                        <i class="bi bi-telephone-fill me-2"></i>
                        Emergency Contacts
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link d-flex align-items-center" data-bs-toggle="tab" href="#schoolTab">
                        <i class="bi bi-building-fill me-2"></i>
                        Previous School
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link d-flex align-items-center" data-bs-toggle="tab" href="#documentTab">
                        <i class="bi bi-file-earmark-fill me-2"></i>
                        Documents
                    </a>
                </li>
            </ul>

            <!-- TAB CONTENT -->
            <div class="tab-content">

                <!-- ========================= -->
                <!-- PARENTS TAB - ENHANCED -->
                <!-- ========================= -->
                <div class="tab-pane fade show active" id="parentTab">
                    <h6 class="fw-semibold text-muted mb-4">Add Parent/Guardian Information</h6>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:DropDownList ID="ddlParentType" runat="server" CssClass="form-select">
                                    <asp:ListItem>Father</asp:ListItem>
                                    <asp:ListItem>Mother</asp:ListItem>
                                    <asp:ListItem>Guardian</asp:ListItem>
                                </asp:DropDownList>
                                <label for="ddlParentType">Parent Type</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtParentName" runat="server" CssClass="form-control" placeholder="Enter full name" />
                                <label for="txtParentName">Full Name</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtParentMobile" runat="server" CssClass="form-control" placeholder="Mobile number" />
                                <label for="txtParentMobile">Mobile Number</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtParentOccupation" runat="server" CssClass="form-control" placeholder="Occupation" />
                                <label for="txtParentOccupation">Occupation</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-check form-switch mt-4">
                                <asp:CheckBox ID="chkGuardian" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label fw-medium" for="chkGuardian">Is Guardian?</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtParentRelation" runat="server" CssClass="form-control" placeholder="Relationship" />
                                <label for="txtParentRelation">Relationship</label>
                            </div>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <asp:Button ID="btnSaveParent" runat="server" Text="Save Parent"
                                CssClass="btn btn-primary px-4"
                                OnClick="btnSaveParent_Click"></asp:Button>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <!-- Enhanced Parents List -->
                    <h6 class="fw-semibold text-muted mb-3">Existing Parents/Guardians</h6>
                    <asp:Repeater ID="rptParents" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive">
                                <table class="table table-hover table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="bi bi-person-badge me-2"></i>Relation</th>
                                            <th><i class="bi bi-person me-2"></i>Name</th>
                                            <th><i class="bi bi-phone me-2"></i>Mobile</th>
                                            <th><i class="bi bi-briefcase me-2"></i>Occupation</th>
                                            <%--<th><i class="bi bi-diagram-3 me-2"></i>Relation</th>--%>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("parentType") %></td>
                                <td class="fw-semibold"><%# Eval("fullName") %></td>
                                <td><%# Eval("mobile") %></td>
                                <td><%# Eval("occupation") %></td>
                                <%--<td><%# Eval("relationship") %></td>--%>
                                <td>
                                    <button type="button" class="btn btn-sm btn-outline-primary" title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-danger ms-1" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                                </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Empty State for Parents -->
                    <asp:Panel ID="pnlNoParents" runat="server" CssClass="text-center py-5 empty-state" Visible="false">
                        <i class="bi bi-people display-1 text-muted"></i>
                        <h5 class="mt-3 text-muted">No parents added yet</h5>
                        <p class="text-muted">Add the first parent using the form above</p>
                    </asp:Panel>
                </div>

                <!-- ========================= -->
                <!-- EMERGENCY TAB - ENHANCED -->
                <!-- ========================= -->
                <div class="tab-pane fade" id="emergencyTab">
                    <h6 class="fw-semibold text-muted mb-4">Add Emergency Contact Information</h6>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtECName" runat="server" CssClass="form-control" placeholder="Contact name" />
                                <label for="txtECName">Contact Name</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtECPhone" runat="server" CssClass="form-control" placeholder="Contact number" />
                                <label for="txtECPhone">Contact Number</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtECRelation" runat="server" CssClass="form-control" placeholder="Relationship" />
                                <label for="txtECRelation">Relation</label>
                            </div>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <asp:Button ID="btnSaveEmergency" runat="server" Text="Save Emergency Contact"
                                CssClass="btn btn-primary px-4"
                                OnClick="btnSaveEmergency_Click"></asp:Button>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <!-- Enhanced Emergency Contacts List -->
                    <h6 class="fw-semibold text-muted mb-3">Existing Emergency Contacts</h6>
                    <asp:Repeater ID="rptEmergency" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="bi bi-person me-2"></i>Name</th>
                                            <th><i class="bi bi-phone me-2"></i>Phone</th>
                                            <th><i class="bi bi-diagram-3 me-2"></i>Relation</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="fw-semibold"><%# Eval("contactName") %></td>
                                <td><%# Eval("contactNumber") %></td>
                                <td><span class=" text-dark"><%# Eval("relation") %></span></td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-outline-primary" title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-danger ms-1" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                                </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Empty State for Emergency Contacts -->
                    <asp:Panel ID="pnlNoEmergency" runat="server" CssClass="text-center py-5 empty-state" Visible="false">
                        <i class="bi bi-telephone display-1 text-muted"></i>
                        <h5 class="mt-3 text-muted">No emergency contacts added</h5>
                        <p class="text-muted">Add emergency contacts using the form above</p>
                    </asp:Panel>
                </div>

                <!-- ========================= -->
                <!-- PREVIOUS SCHOOL TAB - ENHANCED -->
                <!-- ========================= -->
                <div class="tab-pane fade" id="schoolTab">
                    <h6 class="fw-semibold text-muted mb-4">Add Previous School Information</h6>

                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtPrevSchool" runat="server" CssClass="form-control" placeholder="School name" />
                                <label for="txtPrevSchool">School Name</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtPrevClass" runat="server" CssClass="form-control" placeholder="Previous class" />
                                <label for="txtPrevClass">Previous Class</label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-floating">
                                <asp:TextBox ID="txtTCNo" runat="server" CssClass="form-control" placeholder="TC number" />
                                <label for="txtTCNo">TC Number</label>
                            </div>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <asp:Button ID="btnSaveSchool" runat="server" Text="Save School"
                                CssClass="btn btn-primary px-4"
                                OnClick="btnSaveSchool_Click"></asp:Button>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <!-- Enhanced Previous School List -->
                    <h6 class="fw-semibold text-muted mb-3">Previous School Information</h6>
                    <asp:Repeater ID="rptSchool" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="bi bi-building me-2"></i>School</th>
                                            <th><i class="bi bi-mortarboard me-2"></i>Class</th>
                                            <th><i class="bi bi-file-text me-2"></i>TC No</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="fw-semibold"><%# Eval("schoolName") %></td>
                                <td><span class=""><%# Eval("previousClass") %></span></td>
                                <td><code><%# Eval("tcNumber") %></code></td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-outline-primary" title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-danger ms-1" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                                </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Empty State for Previous School -->
                    <asp:Panel ID="pnlNoSchool" runat="server" CssClass="text-center py-5 empty-state" Visible="false">
                        <i class="bi bi-building display-1 text-muted"></i>
                        <h5 class="mt-3 text-muted">No previous school information</h5>
                        <p class="text-muted">Add previous school details using the form above</p>
                    </asp:Panel>
                </div>

                <!-- ========================= -->
                <!-- DOCUMENTS TAB - ENHANCED -->
                <!-- ========================= -->
                <div class="tab-pane fade" id="documentTab">
                    <h6 class="fw-semibold text-muted mb-4">Upload Student Documents</h6>

                    <div class="alert alert-info border-info border-start border-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-info-circle-fill me-3 fs-4"></i>
                            <div>
                                <h6 class="alert-heading mb-1">Document Upload</h6>
                                <p class="mb-0">Upload student documents such as birth certificate, previous TC, photos, etc.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Document Upload Form -->
                    <div class="card border-dashed">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-cloud-arrow-up display-1 text-muted mb-3"></i>
                            <h5 class="mb-2">Drag & Drop files here</h5>
                            <p class="text-muted mb-4">or click to browse</p>
                            <div class="mb-3">
                                <asp:FileUpload ID="fileUploadDocument" runat="server" CssClass="form-control" AllowMultiple="true" />
                            </div>
                            <asp:Button ID="btnUploadDocument" runat="server" Text="Upload Documents"
                                CssClass="btn btn-outline-primary" />
                        </div>
                    </div>

                    <!-- Document List -->
                    <div class="mt-4">
                        <h6 class="fw-semibold text-muted mb-3">Uploaded Documents</h6>
                        <div class="text-center py-5 empty-state">
                            <i class="bi bi-folder display-1 text-muted"></i>
                            <h5 class="mt-3 text-muted">No documents uploaded yet</h5>
                            <p class="text-muted">Upload documents using the form above</p>
                        </div>
                    </div>
                </div>

            </div>
            <!-- End Tab Content -->

        </div>
    </div>

    <!-- JavaScript for Enhancements -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Add hover effect to all form controls
            const formControls = document.querySelectorAll('.form-control, .form-select');
            formControls.forEach(control => {
                control.addEventListener('mouseenter', function () {
                    this.style.borderColor = '#86b7fe';
                });
                control.addEventListener('mouseleave', function () {
                    if (!this.matches(':focus')) {
                        this.style.borderColor = '#ced4da';
                    }
                });
            });


            // Auto-dismiss alerts after 5 seconds
            setTimeout(function () {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);

            //// Update progress bar based on active tab
            //const tabs = document.querySelectorAll('.nav-link[data-bs-toggle="tab"]');
            //tabs.forEach(tab => {
            //    tab.addEventListener('shown.bs.tab', function(event) {
            //        const tabId = event.target.getAttribute('href');
            //        let progress = 25;
            //        switch(tabId) {
            //            case '#emergencyTab': progress = 50; break;
            //            case '#schoolTab': progress = 75; break;
            //            case '#documentTab': progress = 100; break;
            //        }
            //        document.querySelector('.progress-bar').style.width = progress + '%';
            //    });
            //});

        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var tabs = document.querySelectorAll('[data-bs-toggle="tab"]');
            tabs.forEach(function (tab) {
                tab.addEventListener("shown.bs.tab", function (e) {
                    document.getElementById("<%= hfActiveTab.ClientID %>").value =
                        e.target.getAttribute("href");
                });
            });
        });
    </script>


</asp:Content>
