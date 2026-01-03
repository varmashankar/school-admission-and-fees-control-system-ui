<%@ Page Title="Resources" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="resources.aspx.cs" Inherits="Dashboard_Teacher_Resources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Resources</h1>
        <div class="small text-muted">Access shared files and links</div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow-sm border-0 mb-3">
        <div class="card-body">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="fw-semibold">Files</div>
                <a href="#" class="btn btn-success btn-sm">Upload</a>
            </div>
            <asp:Repeater ID="rptResources" runat="server">
                <ItemTemplate>
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <div>
                            <div class="fw-semibold"><%# Eval("name") %></div>
                            <div class="small text-muted">Type: <%# Eval("type") %> · <a href='<%# Eval("url") %>' target="_blank" class="text-decoration-none">Open</a></div>
                        </div>
                        <span class="badge bg-light text-muted border"><%# Eval("size") %></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Panel ID="pnlNoResources" runat="server" CssClass="text-muted small" Visible="false">No resources available.</asp:Panel>
        </div>
    </div>
</asp:Content>
