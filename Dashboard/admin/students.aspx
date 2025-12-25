<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="students.aspx.cs" Inherits="Dashboard_admin_students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .stat-card {
            border: 1px solid #e9ecef;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1) !important;
            }

            .stat-card h3 {
                font-size: 1.9rem;
                letter-spacing: -0.5px;
            }

            .stat-card small {
                font-size: 0.75rem;
            }

        .cursor-pointer {
            cursor: pointer;
        }


        .icon-bg {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.75rem;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Students Management</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Stats Overview -->
    <div class="row g-4 mb-4">

    <!-- TOTAL STUDENTS -->
    <div class="col-md-6 col-xl-4">
        <div id="cardTotalStudents"
             runat="server"
             class="card shadow-sm stat-card border-0 h-100 cursor-pointer"
             onclick="location.href='students.aspx'">
            <div class="card-body d-flex align-items-center p-3">
                <div class="icon-bg bg-primary bg-opacity-10 me-3">
                    <i class="bi bi-people-fill fs-2 text-primary"></i>
                </div>
                <div>
                    <p class="text-muted mb-1">Total Students</p>
                    <h3 class="fw-bold mb-0">
                        <asp:Label ID="lblTotalStudents" runat="server" />
                    </h3>
                    <small class="text-muted">Active students</small>
                </div>
            </div>
        </div>
    </div>

    <!-- NEW ADMISSIONS -->
    <div class="col-md-6 col-xl-4">
        <div id="cardAdmissions"
             runat="server"
             class="card shadow-sm stat-card border-0 h-100 cursor-pointer"
             onclick="location.href='students.aspx?filter=new30'">
            <div class="card-body d-flex align-items-center p-3">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-person-plus-fill fs-2 text-success"></i>
                </div>
                <div>
                    <p class="text-muted mb-1">New Admissions</p>
                    <h3 class="fw-bold mb-0">
                        <asp:Label ID="lblNewAdmissions" runat="server" />
                    </h3>
                    <small class="fw-semibold text-success">
                        <i class="bi bi-graph-up-arrow"></i>
                        <asp:Label ID="lblAdmissionGrowth" runat="server" />%
                        <span class="text-muted">vs last month</span>
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- ATTENDANCE TODAY -->
    <div class="col-md-6 col-xl-4">
        <div id="cardAttendance"
             runat="server"
             class="card shadow-sm stat-card border-0 h-100 cursor-pointer"
             onclick="location.href='attendance-report.aspx'">
            <div class="card-body d-flex align-items-center p-3">
                <div class="icon-bg bg-info bg-opacity-10 me-3">
                    <i class="bi bi-check-circle-fill fs-2 text-info"></i>
                </div>
                <div class="w-100">
                    <p class="text-muted mb-1">Attendance Today</p>
                    <h3 class="fw-bold mb-0">
                        <asp:Label ID="lblAttendancePercent" runat="server" />%
                    </h3>
                    <small class="text-danger fw-semibold">
                        <asp:Label ID="lblAbsentToday" runat="server" />
                        students absent
                    </small>

                    <!-- Progress bar -->
                    <div class="progress mt-2" style="height:5px;">
                        <div id="attendanceProgress"
                             runat="server"
                             class="progress-bar bg-success"
                             style="width:0%;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

    <!-- All Students List -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">All Students</h5>
                <div>
                    <asp:HyperLink ID="btnExport" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/ExportPage.aspx">
                        <i class="bi bi-download me-2"></i>Export
                    </asp:HyperLink>


                    <asp:HyperLink ID="btnAddStudent" runat="server" CssClass="btn btn-primary btn-sm" NavigateUrl="~/dashboard/admin/admissionform.aspx">
                        <i class="bi bi-plus-lg me-2"></i>Add New Student
                    </asp:HyperLink>


                </div>
            </div>
        </div>
        <div class="card-body">

            <!-- This is a placeholder for your student data table. -->
            <!-- You would replace this with an ASP.NET GridView or a similar control. -->
            <div class="table-responsive">
                <table id="tblStudents" class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Student Name</th>
                            <th scope="col">Grade</th>
                            <th scope="col">Gender</th>
                            <th scope="col">Teacher Name</th>
                            <th scope="col">Actions</th>
                        </tr>
                        <tr class="filters">
                            <th>

                            <th>
                                <input type="text" class="form-control form-control-sm" placeholder="Search Name"></th>
                            <th>
                                <input type="text" class="form-control form-control-sm" placeholder="Search Grade"></th>
                            <th>
                                <input type="text" class="form-control form-control-sm" placeholder="Search Parent"></th>
                            <th>
                                <input type="text" class="form-control form-control-sm" placeholder="Search Contact"></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptStudents" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td>
                                        <%# Eval("firstName") %>
                                        <%# Eval("middleName") %>
                                        <%# Eval("lastName") %>
                                    </td>
                                    <td>Class <%# Eval("className") %></td>
                                    <td><%# Eval("gender") %></td>
                                    <td><%# Eval("TeacherName") %></td>

                                    <td>
                                        <a class="btn btn-sm btn-primary" title="Edit"
                                            href='admissionform.aspx?id=<%# Eval("id") %>'><i class="fas fa-edit"></i>
                                        </a>
                                        <a class="btn btn-sm btn-success ms-2" title="Add Student Details"
                                            href='addstudentdetails.aspx?sid=<%# CryptoHelper.Encrypt(Eval("studentCode").ToString()) %>'><i class="fas fa-plus-circle"></i>
                                        </a>


                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>


                </table>
            </div>
        </div>
    </div>
</asp:Content>

