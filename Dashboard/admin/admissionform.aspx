<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" 
    CodeFile="admissionform.aspx.cs" Inherits="Dashboard_admin_admissionform" 
    UnobtrusiveValidationMode="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Keep minimal styling for the page */
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="Server">
    <div class="d-flex align-items-center">
        <a href="students.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left"></i> Back</a>
        <h1 class="h4 mb-0 text-dark">Add New Student</h1>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Create New Student</h5>
        </div>

        <div class="card-body p-4">

            <asp:HiddenField ID="hfStudentId" runat="server" />
            <asp:HiddenField ID="hfToken" runat="server" />
            <asp:HiddenField ID="hfAdmissionId" runat="server" />

            <!-- ONLY STEP-1 FORM -->
            <h6 class="fw-bold mb-3">Student Information</h6>

            <div class="row g-3">
                
                <div class="col-md-4">
                    <asp:Label runat="server" Text="First Name" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtFirstName" placeholder="Shankar" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Middle Name" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtMiddleName" placeholder="Avdhesh" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Last Name" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtLastName" placeholder="Varma" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Date of Birth" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtDob" runat="server" CssClass="form-control" TextMode="Date" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Gender" CssClass="form-label fw-semibold required" />
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select --" Value="" />
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                        <asp:ListItem>Other</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Blood Group" CssClass="form-label fw-semibold" />
                    <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select --" Value="" />
                        <asp:ListItem>A+</asp:ListItem>
                        <asp:ListItem>A-</asp:ListItem>
                        <asp:ListItem>B+</asp:ListItem>
                        <asp:ListItem>B-</asp:ListItem>
                        <asp:ListItem>AB+</asp:ListItem>
                        <asp:ListItem>AB-</asp:ListItem>
                        <asp:ListItem>O+</asp:ListItem>
                        <asp:ListItem>O-</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Nationality" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtNationality" placeholder="Indian" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Religion" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtReligion" placeholder="Hindu" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Aadhar/National ID" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtAadhar" placeholder="8700 000 000" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <asp:Label runat="server" Text="Email" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtEmail" placeholder="shankarvarma@gmail.com" runat="server" CssClass="form-control" TextMode="Email" />
                </div>

                <div class="col-md-6">
                    <asp:Label runat="server" Text="Phone" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtPhone" placeholder="9876543210" runat="server" CssClass="form-control" TextMode="Phone" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Admission Date" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtAdmissionDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Class" CssClass="form-label fw-semibold required" />
                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" Text="Transport Required?" CssClass="form-label fw-semibold" />
                    <asp:DropDownList ID="ddlTransport" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select --" Value="" />
                        <asp:ListItem Value="false">No</asp:ListItem>
                        <asp:ListItem Value="true">Yes</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <asp:Label runat="server" Text="Sibling Info" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtSiblingInfo" placeholder="4B Vijay Pal" runat="server" CssClass="form-control" />
                </div>

                <div class="col-12">
                    <asp:Label runat="server" Text="Address" CssClass="form-label fw-semibold required" />
                    <asp:TextBox ID="txtAddress" placeholder="123 Society Near New Area" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                </div>

                <div class="col-12">
                    <asp:Label runat="server" Text="Medical Info" CssClass="form-label fw-semibold" />
                    <asp:TextBox ID="txtMedicalInfo" placeholder="if any allergies" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                </div>
            </div>

            <div class="d-flex justify-content-end mt-4">
                <asp:LinkButton ID="btnSaveStep1" CssClass="btn btn-save me-2" OnClick="btnSaveStep1_Click" runat="server">
                    <span>
                        <svg
                          height="24"
                          width="24"
                          viewBox="0 0 24 24"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path d="M0 0h24v24H0z" fill="none"></path>
                          <path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z" fill="currentColor"></path>
                        </svg>
                        Save Student
                      </span>
                </asp:LinkButton>
            </div>

        </div>
    </div>

    <!-- Token + Admission ID Loader -->
    <script type="text/javascript">
        Sys.Application.add_load(function () {

            const token = localStorage.getItem("authToken");
            if (token) {
                document.getElementById("<%= hfToken.ClientID %>").value = token;
            }

            console.log(token);
        });

       
    </script>

</asp:Content>
