<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="addnewteacher.aspx.cs" Inherits="Dashboard_admin_addnewteacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <div class="d-flex align-items-center">
        <a href="teachers.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left me-2"></i>Back</a>
        <h1 class="h4 mb-0 text-dark">Add New Teacher</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="card shadow-sm border-0">

        <!-- HEADER -->
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Teacher Information Form</h5>
        </div>

        <div class="card-body p-4">

            <!-- =============================
             SECTION: Personal Information
        ================================== -->
            <h6 class="fw-bold mb-3 border-bottom pb-2 text-primary">Personal Information</h6>


            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <asp:Label Text="Teacher ID" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtTeacherId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div class="row g-3 mb-3">

                <div class="col-md-4">
                    <asp:Label Text="First Name" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="FirstName" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Middle Name" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtMiddleName" runat="server" placeholder="MiddleName" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Last Name" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="LastName" CssClass="form-control"></asp:TextBox>
                </div>

            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-8">
                    <asp:Label Text="Email" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="emailaddress@gmail.com" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Mobile" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtMobile" runat="server" placeholder="9876543210" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label Text="Date of Birth" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtDob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Gender" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">-- Select --</asp:ListItem>
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                        <asp:ListItem>Other</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Religion" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtReligion" runat="server" placeholder="Hindu" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- =============================
             SECTION: National & Identity
        ================================== -->
            <h6 class="fw-bold mt-4 mb-3 border-bottom pb-2 text-primary">Identity</h6>
            <div class="row g-3">

                <div class="col-md-4">
                    <asp:Label Text="Nationality" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtNationality" runat="server" placeholder="Indian" CssClass="form-control"></asp:TextBox>
                </div>



                <div class="col-md-4">
                    <asp:Label Text="National ID Number" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtNationalId" runat="server" placeholder="3554 84848 5555" CssClass="form-control"></asp:TextBox>
                </div>

            </div>

            <!-- =============================
             SECTION: Professional Details
        ================================== -->
            <h6 class="fw-bold mt-4 mb-3 border-bottom pb-2 text-primary">Professional Details</h6>
            <div class="row g-3">

                <div class="col-md-4">
                    <asp:Label Text="Date of Joining" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtJoiningDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Designation" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtDesignation" runat="server" placeholder="Teacher" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Department" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Primary Subject" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtPrimarySubject" runat="server" placeholder="Science" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Experience (Years)" runat="server" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtExperienceYears" runat="server" placeholder="3" CssClass="form-control" TextMode="Number"></asp:TextBox>
                </div>

            </div>

            <!-- SAVE BUTTON -->
            <div class="mt-4 pt-3 border-top text-end">
                <asp:LinkButton ID="btnSaveTeacher" runat="server" OnClick="btnSaveTeacher_Click" CssClass="btn btn-success">
                <i class="bi bi-check-circle me-2"></i>Save Teacher
                </asp:LinkButton>
            </div>

        </div>
    </div>


</asp:Content>

