<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="attendance.aspx.cs" Inherits="Dashboard_admin_attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .stat-card {
            border: 1px solid #e9ecef;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            cursor: default; /* Remove pointer cursor as it's just a stat */
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

        /* Styles for attendance status */
        .attendance-status-present { color: #198754; font-weight: bold; } /* Green */
        .attendance-status-absent { color: #dc3545; font-weight: bold; }   /* Red */
        .attendance-status-late { color: #ffc107; font-weight: bold; }    /* Yellow/Orange */
        .attendance-status-leave { color: #0dcaf0; font-weight: bold; }   /* Light Blue */

        /* Custom toggle button styling */
        .btn-toggle {
            display: flex;
            border-radius: .375rem;
            overflow: hidden;
        }
        .btn-toggle .btn {
            border-radius: 0;
            flex-grow: 1;
        }
        .btn-toggle .btn:first-child {
            border-top-left-radius: .375rem;
            border-bottom-left-radius: .375rem;
        }
        .btn-toggle .btn:last-child {
            border-top-right-radius: .375rem;
            border-bottom-right-radius: .375rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <h3 class="text-xl font-bold text-gray-800">Attendance Management</h3>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Attendance Stats Overview -->
    <div class="row g-4 mb-4">

    <!-- Present -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-success bg-opacity-10 me-3">
                    <i class="bi bi-person-check text-success fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Present</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTodayPresent" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Marked today</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Absent -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-danger bg-opacity-10 me-3">
                    <i class="bi bi-person-x text-danger fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Absent</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litTodayAbsent" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Not present today</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending -->
    <div class="col-md-6 col-xl-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-bg bg-warning bg-opacity-10 me-3">
                    <i class="bi bi-hourglass-split text-warning fs-3"></i>
                </div>
                <div>
                    <small class="text-uppercase text-muted fw-semibold">Pending</small>
                    <div class="fs-2 fw-bold text-dark">
                        <asp:Literal ID="litPendingMarks" runat="server" Text="—" />
                    </div>
                    <small class="text-muted">Yet to be marked</small>
                </div>
            </div>
        </div>
    </div>

</div>


    <!-- Attendance Entry / View Section -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">Mark / View Attendance</h5>
                <div class="btn-group btn-toggle" role="group">
                    <asp:LinkButton ID="btnStudentAttendance" runat="server" CssClass="btn btn-primary active" OnClick="btnAttendanceType_Click" CommandArgument="Student">
                        <i class="bi bi-mortarboard me-2"></i>Students
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnTeacherAttendance" runat="server" CssClass="btn btn-outline-primary" OnClick="btnAttendanceType_Click" CommandArgument="Teacher">
                        <i class="bi bi-person-badge me-2"></i>Teachers
                    </asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row g-3 align-items-end mb-4">
                <div class="col-md-4" id="divClassSelection" runat="server">
                    <asp:Label ID="lblSelectClass" runat="server" Text="Select Class & Section" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlClasses" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select Class --" Value="" />
                        <asp:ListItem Text="Grade 1 - A" Value="G1A" />
                        <asp:ListItem Text="Grade 1 - B" Value="G1B" />
                        <asp:ListItem Text="Grade 5 - A" Value="G5A" />
                        <asp:ListItem Text="Grade 8 - A" Value="G8A" />
                        <asp:ListItem Text="Grade 10 - B" Value="G10B" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4" id="divTeacherSelection" runat="server" visible="false">
                    <asp:Label ID="lblSelectDepartment" runat="server" Text="Select Department (Optional)" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlDepartments" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- All Departments --" Value="" />
                        <asp:ListItem Text="Science" Value="SCI" />
                        <asp:ListItem Text="Math" Value="MATH" />
                        <asp:ListItem Text="Arts" Value="ART" />
                        <asp:ListItem Text="Administration" Value="ADMIN" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <asp:Label ID="lblSelectDate" runat="server" Text="Select Date" CssClass="form-label fw-semibold"></asp:Label>
          <asp:TextBox ID="txtAttendanceDate" runat="server" CssClass="form-control" TextMode="Date" AutoPostBack="True" OnTextChanged="txtAttendanceDate_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnLoadAttendance" runat="server" Text="Load Attendance" CssClass="btn btn-primary w-100" OnClick="btnLoadAttendance_Click" />
                </div>
            </div>

            <asp:Panel ID="pnlAttendanceGrid" runat="server" Visible="false">
                 <h6 class="fw-bold mb-3">Attendance for <asp:Literal ID="litSelectedEntityDate" runat="server"></asp:Literal></h6>
                 <div class="table-responsive">
                    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle"
                        DataKeyNames="ID" OnRowDataBound="gvAttendance_RowDataBound">
                        <Columns>
                            <%-- These BoundFields will be dynamically hidden/shown or adjusted in code-behind --%>
                            <asp:BoundField DataField="Identifier" HeaderText="Roll No / Employee ID" />
                            <asp:BoundField DataField="Name" HeaderText="Student / Teacher Name" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" CssClass="d-flex justify-content-around w-100">
                                        <asp:ListItem Text="Present" Value="P" Selected="True" />
                                        <asp:ListItem Text="Absent" Value="A" />
                                        <asp:ListItem Text="Late" Value="L" />
                                        <asp:ListItem Text="Leave" Value="LV" />
                                    </asp:RadioButtonList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control form-control-sm" placeholder="Optional remarks"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                         <EmptyDataTemplate>
                            <div class="alert alert-info" role="alert">
                                No records found for the selected criteria. Please adjust your selection.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
                <div class="mt-4 pt-3 border-top">
                    <asp:Button ID="btnSaveAttendance" runat="server" Text="Save Attendance" CssClass="btn btn-success" OnClick="btnSaveAttendance_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary ms-2" OnClick="btnCancel_Click" />
                </div>
            </asp:Panel>
        </div>
    </div>

    <!-- Attendance History/Reports (Optional, could be a separate page) -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white p-3">
            <h5 class="mb-0 fw-bold">Attendance History & Reports</h5>
        </div>
        <div class="card-body">
            <p class="text-muted">View past attendance records, generate reports, and analyze trends for both students and staff.</p>
            <asp:HyperLink ID="lnkViewReports" runat="server" CssClass="btn btn-outline-primary" NavigateUrl="~/dashboard/admin/attendancereports.aspx">
                <i class="bi bi-file-earmark-bar-graph me-2"></i>Go to Reports
            </asp:HyperLink>
        </div>
    </div>
</asp:Content>