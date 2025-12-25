<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="streams.aspx.cs" Inherits="Dashboard_admin_streams" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center">
        <h1 class="h4 mb-0 text-dark">Streams</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Manage Streams</h5>
        </div>

        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-6">
                    <asp:Label runat="server" Text="Stream Name" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtStreamName" runat="server" CssClass="form-control" placeholder="e.g., Science"></asp:TextBox>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top">
                <asp:HiddenField ID="hfStreamId" runat="server" />
                <asp:LinkButton ID="btnStreamSave" runat="server" CssClass="btn btn-primary" OnClick="btnStreamSave_Click">Save</asp:LinkButton>
                <asp:LinkButton ID="btnStreamClear" runat="server" CssClass="btn btn-outline-secondary ms-2" OnClick="btnStreamClear_Click">Clear</asp:LinkButton>
            </div>

            <hr />

            <asp:GridView ID="gvStreams" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" OnRowCommand="gvStreams_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Stream Name" DataField="stream_name" />
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

