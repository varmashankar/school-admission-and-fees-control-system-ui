<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="feedefinition.aspx.cs" Inherits="Dashboard_admin_feedefinition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .stat-card {
            border: 1px solid #e9ecef;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            cursor: default;
        }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1) !important;
            }

        .icon-bg {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.75rem;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <div class="d-flex align-items-center">
        <a href="fees.aspx" class="btn btn-light btn-sm me-3"><i class="bi bi-arrow-left"></i></a>
        <h1 class="h4 mb-0 text-dark">Define Fees</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Fee Definition Stats (Optional, could be count of fee types etc.) -->
    <div class="row g-4 mb-4">
        <div class="col-md-6 col-xl-4">
            <div class="card shadow-sm stat-card border-0 h-100">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-info bg-opacity-10 me-3">
                        <i class="bi bi-tags fs-2 text-info"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Total Fee Types Defined</p>
                        <h3 class="h4 fw-bold mb-0">
                            <asp:Literal ID="litTotalFeeTypes" runat="server" Text="0"></asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-xl-4">
            <div class="card shadow-sm stat-card border-0 h-100">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-primary bg-opacity-10 me-3">
                        <i class="bi bi-calendar-range fs-2 text-primary"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Fee Structures in Use</p>
                        <h3 class="h4 fw-bold mb-0">
                            <asp:Literal ID="litFeeStructuresInUse" runat="server" Text="0"></asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-xl-4">
            <div class="card shadow-sm stat-card border-0 h-100">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-warning bg-opacity-10 me-3">
                        <i class="bi bi-bell fs-2 text-warning"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Upcoming Due Dates</p>
                        <h3 class="h4 fw-bold mb-0">
                            <asp:Literal ID="litUpcomingDueDates" runat="server" Text="0"></asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Add New Fee Type Form -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Add New Fee Type / Update Fee Structure</h5>
        </div>
        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-6">
                    <asp:Label ID="lblFeeName" runat="server" Text="Fee Name" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtFeeName" runat="server" CssClass="form-control" placeholder="e.g., Tuition Fee, Library Fee"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFeeName" runat="server" ControlToValidate="txtFeeName" ErrorMessage="Fee Name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <asp:Label ID="lblFeeDescription" runat="server" Text="Description (Optional)" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtFeeDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Brief description of this fee"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Label ID="lblDefaultAmount" runat="server" Text="Default Amount" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtDefaultAmount" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDefaultAmount" runat="server" ControlToValidate="txtDefaultAmount" ErrorMessage="Default Amount is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvDefaultAmount" runat="server" ControlToValidate="txtDefaultAmount"
                        Operator="DataTypeCheck" Type="Currency" ErrorMessage="Amount must be a valid number." CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label ID="lblApplicableClass" runat="server" Text="Applicable Class (Optional)" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlApplicableClass" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- All Classes --" Value="" />
                        <asp:ListItem Text="Grade 1 - A" Value="G1A" />
                        <asp:ListItem Text="Grade 1 - B" Value="G1B" />
                        <asp:ListItem Text="Grade 5 - A" Value="G5A" />
                        <asp:ListItem Text="Grade 8 - A" Value="G8A" />
                    </asp:DropDownList>
                    <small class="text-muted">Leave blank for a general fee.</small>
                </div>
                <div class="col-md-4">
                    <asp:Label ID="lblDueDate" runat="server" Text="Default Due Date" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtDefaultDueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDefaultDueDate" runat="server" ControlToValidate="txtDefaultDueDate" ErrorMessage="Due Date is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="col-12">
                    <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" Checked="true" CssClass="form-check-input me-2" />
                    <asp:Label AssociatedControlID="chkIsActive" runat="server" Text="Set this fee as active for new enrollments/periods." CssClass="form-check-label"></asp:Label>
                </div>
            </div>
            <div class="mt-4 pt-3 border-top">
                <asp:Button ID="btnAddFeeType" runat="server" Text="Add Fee Type" CssClass="btn btn-primary me-2" OnClick="btnAddFeeType_Click" />
                <asp:Button ID="btnUpdateFeeType" runat="server" Text="Update Fee Type" CssClass="btn btn-warning me-2" OnClick="btnUpdateFeeType_Click" Visible="false" />
                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary" OnClick="btnCancelEdit_Click" Visible="false" />
            </div>
        </div>
    </div>

    <!-- Existing Fee Types List -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Defined Fee Structures</h5>
        </div>
        <div class="card-body">
            <p class="text-muted">A list of all fee types and their default amounts per class or generally applicable.</p>

            <div class="table-responsive">
                <asp:GridView ID="gvFeeDefinitions" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                    DataKeyNames="FeeDefinitionID" OnRowEditing="gvFeeDefinitions_RowEditing" OnRowDeleting="gvFeeDefinitions_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="FeeName" HeaderText="Fee Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:BoundField DataField="DefaultAmount" HeaderText="Default Amount" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="ApplicableClass" HeaderText="Applicable Class" />
                        <asp:BoundField DataField="DefaultDueDate" HeaderText="Due Date" DataFormatString="{0:d}" />
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkActiveStatus" runat="server" Checked='<%# Eval("IsActive") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn btn-sm btn-outline-primary me-2" CommandName="Edit" CommandArgument='<%# Eval("FeeDefinitionID") %>'>
                                    <i class="bi bi-pencil-square"></i> Edit
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this fee type? This action cannot be undone.');" CommandArgument='<%# Eval("FeeDefinitionID") %>'>
                                    <i class="bi bi-trash"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="alert alert-info" role="alert">
                            No fee types defined yet. Use the form above to add one.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>