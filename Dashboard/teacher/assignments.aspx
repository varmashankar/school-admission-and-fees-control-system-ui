<%@ Page Title="Assignments" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="assignments.aspx.cs" Inherits="Dashboard_Teacher_Assignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Assignments</h1>
        <div class="small text-muted">Manage and review assignments</div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow-sm border-0 mb-3">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="fw-semibold">Recent Assignments</div>
                <a href="#" class="btn btn-success btn-sm">Create Assignment</a>
            </div>
            <asp:Repeater ID="rptAssignments" runat="server">
                <ItemTemplate>
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <div>
                            <div class="fw-semibold"><%# Eval("title") %></div>
                            <div class="small text-muted">Due: <%# Eval("dueDate") %> · Class: <%# Eval("className") %></div>
                        </div>
                        <span class="badge bg-light text-muted border"><%# Eval("status") %></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Panel ID="pnlNoAssignments" runat="server" CssClass="text-muted small" Visible="false">No assignments yet.</asp:Panel>
        </div>
    </div>
</asp:Content>
