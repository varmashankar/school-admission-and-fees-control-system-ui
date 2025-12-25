<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="academic-years.aspx.cs" Inherits="Dashboard_admin_academic_years" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center">
        <h1 class="h4 mb-0 text-dark">Academic Years</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Manage Academic Years</h5>
        </div>

        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Year Code" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtYearCode" runat="server" CssClass="form-control" placeholder="e.g., 2024-2025"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <asp:Label runat="server" Text="Start Date" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" placeholder="YYYY-MM-DD" TextMode="Date"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <asp:Label runat="server" Text="End Date" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" placeholder="YYYY-MM-DD" TextMode="Date"></asp:TextBox>
                </div>

                <div class="col-md-2">
                    <asp:Label runat="server" Text="Active" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Yes" Value="1" />
                        <asp:ListItem Text="No" Value="0" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top">
                <asp:HiddenField ID="hfEditId" runat="server" />
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click">
                    <i class="bi bi-plus-circle me-2"></i><span id="saveLabel">Create</span>
                </asp:LinkButton>
                <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-outline-secondary ms-2" OnClick="btnClear_Click">Clear</asp:LinkButton>
            </div>

            <hr />

            <asp:GridView ID="gvAcademicYears" runat="server" CssClass="table table-striped"
                AutoGenerateColumns="false" OnRowCommand="gvAcademicYears_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="id" />
                    <asp:BoundField HeaderText="Year Code" DataField="year_code" />
                    <asp:BoundField HeaderText="Start Date" DataField="start_date" />
                    <asp:BoundField HeaderText="End Date" DataField="end_date"/>
                    <asp:TemplateField HeaderText="Active">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("is_active")) ? "Yes" : "No" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditItem" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-outline-primary me-1">Edit</asp:LinkButton>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("id") %>' CssClass="btn btn-sm btn-outline-danger">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>

