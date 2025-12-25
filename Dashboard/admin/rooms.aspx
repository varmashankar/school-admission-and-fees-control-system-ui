<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="rooms.aspx.cs" Inherits="Dashboard_admin_rooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center">
        <h1 class="h4 mb-0 text-dark">Rooms</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Manage Rooms</h5>
        </div>

        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label runat="server" Text="Room No" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtRoomNo" runat="server" CssClass="form-control" placeholder="e.g., R101"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <asp:Label runat="server" Text="Floor" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtFloor" runat="server" CssClass="form-control" placeholder="e.g., 1st"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <asp:Label runat="server" Text="Capacity" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control" placeholder="e.g., 40"></asp:TextBox>
                </div>

            </div>

            <div class="mt-4 pt-3 border-top">
                <asp:HiddenField ID="hfRoomId" runat="server" />
                <asp:LinkButton ID="btnRoomSave" runat="server" CssClass="btn btn-primary" OnClick="btnRoomSave_Click">Save</asp:LinkButton>
                <asp:LinkButton ID="btnRoomClear" runat="server" CssClass="btn btn-outline-secondary ms-2" OnClick="btnRoomClear_Click">Clear</asp:LinkButton>
            </div>

            <hr />

            <asp:GridView ID="gvRooms" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" OnRowCommand="gvRooms_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Room No" DataField="room_no" />
                    <asp:BoundField HeaderText="Floor" DataField="floor" />
                    <asp:BoundField HeaderText="Capacity" DataField="capacity" />
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

