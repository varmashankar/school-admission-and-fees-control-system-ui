<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="addnewschool.aspx.cs" Inherits="Dashboard_admin_addnewschool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <div class="d-flex align-items-center">
        <a href="schools.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left me-2"></i>Back</a>
        <h1 class="h4 mb-0 text-dark">Add New School</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card shadow-sm border-0">

        <!-- HEADER -->
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">School Information Form</h5>
        </div>

        <div class="card-body p-4">

            <h6 class="fw-bold mb-3 border-bottom pb-2 text-primary">Basic Details</h6>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <asp:Label Text="School Name" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtSchoolName" runat="server" CssClass="form-control" placeholder="School Name"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <asp:Label Text="Code" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Short Code"></asp:TextBox>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-12">
                    <asp:Label Text="Address" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Address"></asp:TextBox>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <asp:Label Text="Phone" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="(555) 123-4567"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Email" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="info@example.com"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Logo" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:FileUpload ID="fuLogo" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="mt-4 pt-3 border-top text-end">
                <asp:LinkButton ID="btnSaveSchool" runat="server" OnClick="btnSaveSchool_Click" CssClass="btn btn-success">
                <i class="bi bi-check-circle me-2"></i>Save School
                </asp:LinkButton>
            </div>

        </div>
    </div>
n</asp:Content>