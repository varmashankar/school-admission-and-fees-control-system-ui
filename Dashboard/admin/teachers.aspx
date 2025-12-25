<%@ Page Title="Teachers" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="teachers.aspx.cs" Inherits="Dashboard_admin_teachers" %>

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
            .stat-card {
    border: 1px solid #e9ecef;
    transition: box-shadow 0.2s ease, transform 0.2s ease;
}

.stat-card:hover {
    box-shadow: 0 0.75rem 1.5rem rgba(0,0,0,.08);
    transform: translateY(-3px);
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
    <h3 class="text-xl font-bold text-gray-800">Teachers Management</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Stats Overview -->
   <div class="row g-4 mb-4">

    <!-- Total Teachers -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-primary bg-opacity-10 me-3">
                    <i class="bi bi-people-fill text-primary fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Total Teachers</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTotalTeachers" runat="server" Text="0" />
                    </div>
                    <small class="text-muted">Active staff count</small>
                </div>
            </div>
        </div>
    </div>

    <!-- New Hires -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-person-plus-fill text-success fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">New Hires</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litNewHires" runat="server" Text="0" />
                    </div>
                    <small class="text-muted">Joined this month</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Active Subjects -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-info bg-opacity-10 me-3">
                    <i class="bi bi-journal-check text-info fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Active Subjects</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litActiveCourses" runat="server" Text="0" />
                    </div>
                    <small class="text-muted">Currently assigned</small>
                </div>
            </div>
        </div>
    </div>

</div>



    <!-- All Teachers List -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">All Teachers</h5>
                <%-- Changed from students to teachers --%>
                <div>
                    <asp:HyperLink ID="btnExport" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/ExportPage.aspx">
                    <i class="bi bi-download me-2"></i>Export
                    </asp:HyperLink>


                    <asp:HyperLink ID="btnAddTeacher" runat="server" CssClass="btn btn-primary btn-sm" NavigateUrl="~/dashboard/admin/addnewteacher.aspx"> <%-- Changed ID and NavigateUrl --%>
                    <i class="bi bi-plus-lg me-2"></i>Add New Teacher <%-- Changed button text --%>
                    </asp:HyperLink>


                </div>
            </div>
        </div>
        <div class="card-body">
            <p class="text-muted">A list of all teachers in the system. Use the controls to search, filter, and manage teacher records.</p>
            <%-- Changed description --%>

            <div class="table-responsive">
                <table id="tblTeachers" class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">ID #</th>
                            <%-- Changed header --%>
                            <th scope="col">Teacher Name</th>
                            <%-- Changed header --%>
                            <th scope="col">Primary Subject</th>
                            <%-- Changed header from Grade to Subject --%>
                            <th scope="col">Email</th>
                            <%-- Changed header from Parent Name to Email --%>
                            <th scope="col">Contact</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptTeachers" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("teacherId") %></td>
                                    <td><%# Eval("firstName") + " " + Eval("lastName") %></td>
                                    <td><%# Eval("primarySubject") %></td>
                                    <td><%# Eval("email") %></td>
                                    <td><%# Eval("mobile") %></td>

                                    <td>
                                        <a href='editteacher.aspx?id=<%# Eval("id") %>' class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href='#' class="btn btn-sm btn-outline-danger" onclick="confirmDelete('<%# Eval("id") %>')">
                                            <i class="bi bi-trash"></i>
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

