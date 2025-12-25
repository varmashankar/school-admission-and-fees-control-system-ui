<%@ Page Title="Classes" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="classes.aspx.cs" Inherits="Dashboard_admin_classes" %>

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
    width: 56px;
    height: 56px;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
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
    <h3 class="text-xl font-bold text-gray-800">Classes Management</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Stats Overview -->
    <div class="row g-4 mb-4">

    <!-- Total Classes -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-primary bg-opacity-10 me-3">
                    <i class="bi bi-bookmark-fill text-primary fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Total Classes</small>
                    <div class="fs-2 fw-bold text-dark">12</div>
                    <small class="text-muted">Across all grades</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Sections -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-collection-fill text-success fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Total Sections</small>
                    <div class="fs-2 fw-bold text-dark">30</div>
                    <small class="text-muted">Active class sections</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Class Teachers -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-info bg-opacity-10 me-3">
                    <i class="bi bi-person-video text-info fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Class Teachers</small>
                    <div class="fs-2 fw-bold text-dark">28</div>
                    <small class="text-muted">Assigned & active</small>
                </div>
            </div>
        </div>
    </div>

</div>


    <!-- All Classes List -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">All Classes & Sections</h5>
                <div>
                    <asp:HyperLink ID="btnExport" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/ExportPage.aspx">
                    <i class="bi bi-download me-2"></i>Export
                    </asp:HyperLink>


                    <asp:HyperLink ID="btnAddClass" runat="server" CssClass="btn btn-primary btn-sm" NavigateUrl="~/dashboard/admin/addnewclass.aspx">
                    <i class="bi bi-plus-lg me-2"></i>Add New Class
                    </asp:HyperLink>


                </div>
            </div>
        </div>
        <div class="card-body">
            <p class="text-muted">A list of all classes and their assigned sections in the system. Manage class details, teachers, and student allocations.</p>

            <!-- This is a placeholder for your class data table. -->
            <!-- You would replace this with an ASP.NET GridView or a similar control. -->
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Class Name</th>
                            <th scope="col">Class Teacher</th>
                            <th scope="col">No. of Students</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptClasses" runat="server">
                            <ItemTemplate>
    <tr>
        <td class="fw-semibold text-dark">
            <%# Eval("className") %> - <%# Eval("section") %>
        </td>
        <td class="fw-medium">
            <%# Eval("teacherName") %>
        </td>
        <td>
            <span class="fw-semibold"><%# Eval("studentCount") %></span>
        </td>
        <td>
            <a href='addnewclass.aspx?id=<%# Eval("id") %>'
               class="btn btn-sm btn-outline-primary">
                <i class="bi bi-pencil-square"></i>
            </a>
            <a href='javascript:void(0);'
               onclick='deleteClass(<%# Eval("id") %>)'
               class="btn btn-sm btn-outline-danger ms-1">
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
