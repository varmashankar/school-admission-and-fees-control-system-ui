<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="collectfee.aspx.cs" Inherits="Dashboard_admin_collectfee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center">
        <a href="fees.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left"></i></a>
        <h1 class="h4 mb-0 text-dark">Collect Fee</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Record Fee Payment</h5>
        </div>
        <div class="card-body p-4">

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <asp:Label ID="lblStudent" runat="server" Text="Select Student" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlStudent" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged">
                        <asp:ListItem Text="-- Select Student --" Value="" />
                        <%-- This will be populated dynamically --%>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblStudentInfo" runat="server" Text="Student Details" CssClass="form-label fw-semibold"></asp:Label>
                    <p class="form-control-plaintext mb-0">
                        <asp:Literal ID="litStudentDetails" runat="server" Text="Select a student to view details."></asp:Literal>
                    </p>
                </div>
            </div>

            <asp:Panel ID="pnlFeeDetails" runat="server" Visible="false">
                <hr class="my-4" />
                <h6 class="fw-bold mb-3">Fee Information for <asp:Literal ID="litFeeStudentName" runat="server"></asp:Literal></h6>
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <p class="mb-0 text-muted">Total Fees:</p>
                        <h5 class="fw-bold"><asp:Literal ID="litTotalFees" runat="server"></asp:Literal></h5>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0 text-muted">Amount Paid:</p>
                        <h5 class="fw-bold"><asp:Literal ID="litAmountPaid" runat="server"></asp:Literal></h5>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0 text-muted">Balance Due:</p>
                        <h5 class="fw-bold text-danger"><asp:Literal ID="litBalanceDue" runat="server"></asp:Literal></h5>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0 text-muted">Fee Status:</p>
                        <span class="badge rounded-pill" id="feeStatusBadge" runat="server"></span>
                    </div>
                    <div class="col-md-4">
                        <p class="mb-0 text-muted">Due Date:</p>
                        <h6 class="fw-normal"><asp:Literal ID="litDueDate" runat="server"></asp:Literal></h6>
                    </div>
                </div>

                <hr class="my-4" />
                <h6 class="fw-bold mb-3">Record New Payment</h6>
                <div class="row g-3">
                    <div class="col-md-6">
                        <asp:Label ID="lblPaymentAmount" runat="server" Text="Payment Amount" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPaymentAmount" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g., 500.00"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPaymentAmount" runat="server" ControlToValidate="txtPaymentAmount"
                            ErrorMessage="Payment amount is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvPaymentAmount" runat="server" ControlToValidate="txtPaymentAmount"
                            Type="Currency" MinimumValue="0.00" MaximumValue="999999.99"
                            ErrorMessage="Amount must be a positive number." CssClass="text-danger" Display="Dynamic"></asp:RangeValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label ID="lblPaymentDate" runat="server" Text="Payment Date" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtPaymentDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPaymentDate" runat="server" ControlToValidate="txtPaymentDate"
                            ErrorMessage="Payment date is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <asp:Label ID="lblPaymentMethod" runat="server" Text="Payment Method" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Cash" Value="Cash" />
                            <asp:ListItem Text="Bank Transfer" Value="Bank Transfer" />
                            <asp:ListItem Text="Cheque" Value="Cheque" />
                            <asp:ListItem Text="Online" Value="Online" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-12">
                        <asp:Label ID="lblRemarks" runat="server" Text="Remarks (Optional)" CssClass="form-label fw-semibold"></asp:Label>
                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>

            <!-- Form Actions -->
            <div class="mt-4 pt-3 border-top">
                <asp:Button ID="btnProcessPayment" runat="server" Text="Process Payment" CssClass="btn btn-primary me-2" OnClick="btnProcessPayment_Click" Enabled="false" />
                <asp:HyperLink ID="lnkCancel" runat="server" NavigateUrl="~/dashboard/admin/fees.aspx" CssClass="btn btn-outline-secondary">Cancel</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>

