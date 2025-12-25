    <%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="addnewclass.aspx.cs" Inherits="Dashboard_admin_addnewclass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <div class="d-flex align-items-center">
        <a href="classes.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left"></i></a>
        <h1 class="h4 mb-0 text-dark">Add New Class</h1>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Class Definition Form</h5>
        </div>

        <div class="card-body p-4">

            <div class="row g-3">

                <!-- Class Name -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Class Name" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control" placeholder="e.g., 1, 10"></asp:TextBox>
                </div>

                <!-- Section -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Section" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtSection" runat="server" CssClass="form-control" placeholder="e.g., A, B"></asp:TextBox>
                </div>

                <!-- Class Code (Unique) -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Class Code" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtClassCode" runat="server" CssClass="form-control" placeholder="e.g., C10A"></asp:TextBox>
                </div>

                <!-- Academic Year -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Academic Year" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlAcademicYear" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Class Teacher -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Class Teacher" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlClassTeacher" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Room -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Room" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Stream -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Stream" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlStream" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <!-- Board -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Board" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtBoard" runat="server" CssClass="form-control" placeholder="CBSE / ICSE / State"></asp:TextBox>
                </div>

                <!-- Medium -->
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Medium" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtMedium" runat="server" CssClass="form-control" placeholder="English / Hindi"></asp:TextBox>
                </div>

            </div>

            <!-- Buttons -->
            <div class="mt-4 pt-3 border-top">
                <asp:LinkButton ID="btnSaveClass" runat="server" CssClass="btn btn-primary" OnClick="btnSaveClass_Click">
                    <i class="bi bi-plus-circle me-2"></i>Create Class
                </asp:LinkButton>

                <asp:HyperLink ID="lnkCancel" runat="server"
                    NavigateUrl="~/dashboard/admin/classes.aspx"
                    CssClass="btn btn-outline-secondary ms-2">Cancel</asp:HyperLink>
            </div>

        </div>
    </div>
</asp:Content>