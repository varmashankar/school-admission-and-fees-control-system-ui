<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="attendance.aspx.cs" Inherits="Dashboard_Teacher_Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Attendance</h1>
        <div class="small text-muted">Mark and review attendance</div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow-sm border-0 mb-3">
        <div class="card-body">
            <div class="row g-2 mb-3">
                <div class="col-md-4">
                    <label class="form-label small">Class</label>
                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="form-label small">Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <asp:Button ID="btnLoad" runat="server" Text="Load" CssClass="btn btn-success btn-sm me-2" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-outline-success btn-sm" />
                </div>
            </div>

            <asp:Repeater ID="rptStudents" runat="server">
                <HeaderTemplate>
                    <div class="table-responsive">
                    <table class="table table-sm align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>
                                <th class="text-center" style="width:120px;">Present</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("name") %></td>
                        <td class="text-center">
                            <asp:CheckBox ID="chkPresent" runat="server" Checked='<%# Eval("present") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Panel ID="pnlNoStudents" runat="server" CssClass="text-muted small" Visible="false">No students loaded.</asp:Panel>
        </div>
    </div>
</asp:Content>
