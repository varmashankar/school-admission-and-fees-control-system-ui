<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="setupsalary.aspx.cs" Inherits="Dashboard_admin_setupsalary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .form-control:focus, .form-select:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        .card-header-actions {
            display: flex;
            align-items: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <asp:HyperLink ID="lnkBackToSalaries" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/dashboard/admin/salary.aspx">
    <i class="bi bi-arrow-left me-2"></i>Back to Salaries
</asp:HyperLink>
    <h3 class="text-xl font-bold text-gray-800">Setup Teacher Salary</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-white p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">Define Teacher Salary Components</h5>
        </div>
    </div>
    <div class="card-body p-4">
        <p class="text-muted mb-4">Configure the base salary, allowances, and deductions for each teacher. You can search for a teacher and update their salary structure.</p>

        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <label for="txtSearchTeacher" class="form-label fw-semibold">Search Teacher</label>
                <div class="input-group">
                    <asp:TextBox ID="txtSearchTeacher" runat="server" CssClass="form-control" placeholder="Search by Teacher Name or ID"></asp:TextBox>
                    <asp:Button ID="btnSearchTeacher" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearchTeacher_Click" />
                </div>
            </div>
            <div class="col-md-6">
                <label for="ddlSelectTeacher" class="form-label fw-semibold">Select Teacher</label>
                <asp:DropDownList ID="ddlSelectTeacher" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectTeacher_SelectedIndexChanged">
                    <asp:ListItem Text="-- Select a Teacher --" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <asp:Panel ID="pnlSalaryDetails" runat="server" Visible="false" CssClass="border rounded p-4 bg-light mt-4">
            <h6 class="fw-bold mb-3">Salary Details for: <asp:Literal ID="litTeacherName" runat="server"></asp:Literal></h6>
            
            <div class="mb-3">
                <asp:Label ID="lblBaseSalary" runat="server" Text="Base Salary" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtBaseSalary" runat="server" CssClass="form-control" TextMode="Number" Step="0.01"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBaseSalary" runat="server" ControlToValidate="txtBaseSalary" ErrorMessage="Base Salary is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvBaseSalary" runat="server" ControlToValidate="txtBaseSalary" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Base Salary must be a valid number." CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="mb-3">
                <asp:Label ID="lblAllowances" runat="server" Text="Allowances (e.g., Transport, HRA)" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtAllowances" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" placeholder="Enter total allowances"></asp:TextBox>
                 <asp:CompareValidator ID="cvAllowances" runat="server" ControlToValidate="txtAllowances" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Allowances must be a valid number." CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="mb-3">
                <asp:Label ID="lblDeductions" runat="server" Text="Deductions (e.g., Tax, Provident Fund)" CssClass="form-label fw-semibold"></asp:Label>
                <asp:TextBox ID="txtDeductions" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" placeholder="Enter total deductions"></asp:TextBox>
                <asp:CompareValidator ID="cvDeductions" runat="server" ControlToValidate="txtDeductions" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Deductions must be a valid number." CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
            </div>

            <div class="d-grid mt-4">
                <asp:Button ID="btnSaveSalary" runat="server" Text="Save Salary Structure" CssClass="btn btn-success btn-lg" OnClick="btnSaveSalary_Click" />
            </div>

            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
        </asp:Panel>
    </div>
</div>

</asp:Content>