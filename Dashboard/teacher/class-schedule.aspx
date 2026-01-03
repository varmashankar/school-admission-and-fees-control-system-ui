<%@ Page Title="Class Schedule" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="class-schedule.aspx.cs" Inherits="Dashboard_Teacher_ClassSchedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Class Schedule</h1>
        <div class="small text-muted">View your upcoming classes</div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow-sm border-0 mb-3">
        <div class="card-body">
            <p class="text-muted mb-2">Today's classes</p>
            <asp:Repeater ID="rptToday" runat="server">
                <ItemTemplate>
                    <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                        <div>
                            <div class="fw-semibold"><%# Eval("subject") %></div>
                            <div class="small text-muted"><%# Eval("className") %> · Room <%# Eval("room") %></div>
                        </div>
                        <div class="text-end small text-muted"><%# Eval("time") %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Panel ID="pnlNoToday" runat="server" CssClass="text-muted small" Visible="false">No classes scheduled today.</asp:Panel>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <p class="text-muted mb-2">Weekly view</p>
            <asp:Panel ID="pnlPlaceholder" runat="server" CssClass="text-muted small">
                Add schedule binding here.
            </asp:Panel>
        </div>
    </div>
</asp:Content>
