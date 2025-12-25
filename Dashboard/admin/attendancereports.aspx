<%@ Page Title="" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="attendancereports.aspx.cs" Inherits="Dashboard_admin_attendancereports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .summary-box {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 0.5rem;
            padding: 1.25rem;
            text-align: center;
            margin-bottom: 1rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
        }
        .summary-box h4 {
            font-weight: bold;
            margin-bottom: 0.25rem;
        }
        .summary-box p {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 0;
        }
        .summary-box.present { border-left: 5px solid #198754; }
        .summary-box.absent { border-left: 5px solid #dc3545; }
        .summary-box.late { border-left: 5px solid #ffc107; }
        .summary-box.leave { border-left: 5px solid #0dcaf0; }
        .summary-box.total { border-left: 5px solid #0d6efd; } /* Primary color for total */

        .report-section-title {
            margin-top: 2rem;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 0.5rem;
            color: #343a40;
        }
    </style>
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            drawOverallAttendanceChart();
            // You can add more chart functions here
        }

        function drawOverallAttendanceChart() {
            var data = google.visualization.arrayToDataTable([
                ['Status', 'Count'],
                ['Present', <%= litChartPresent.Text %>],
                ['Absent', <%= litChartAbsent.Text %>],
                ['Late', <%= litChartLate.Text %>],
                ['Leave', <%= litChartLeave.Text %>]
            ]);

            var options = {
                title: 'Overall Attendance Distribution',
                pieHole: 0.4,
                colors: ['#198754', '#dc3545', '#ffc107', '#0dcaf0'], // Match badge colors
                chartArea: { left: 15, top: 30, right: 15, bottom: 0, width: '100%', height: '85%' },
                legend: { position: 'bottom' }
            };

            var chart = new google.visualization.PieChart(document.getElementById('overallAttendanceChart'));
            chart.draw(data, options);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageTitle" Runat="Server">
    <asp:HyperLink ID="lnkBackToAttendance" runat="server" CssClass="btn btn-outline-secondary btn-sm" NavigateUrl="~/dashboard/admin/attendance.aspx">
    <i class="bi bi-arrow-left me-2"></i>Back to Attendance
</asp:HyperLink>
    <h3 class="text-xl font-bold text-gray-800">Attendance Reports</h3>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">Generate Attendance Reports</h5>
            </div>
        </div>
        <div class="card-body p-4">
            <p class="text-muted mb-4">Select criteria to generate detailed attendance reports for students or teachers over a specified period.</p>

            <div class="row g-3 mb-4">
                <div class="col-md-6 col-lg-3">
                    <asp:Label ID="lblReportType" runat="server" Text="Report For" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                        <asp:ListItem Text="Students" Value="Student" Selected="True" />
                        <asp:ListItem Text="Teachers" Value="Teacher" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-3" id="divClassFilter" runat="server">
                    <asp:Label ID="lblFilterClass" runat="server" Text="Filter by Class" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlFilterClass" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- All Classes --" Value="" />
                        <asp:ListItem Text="Grade 1 - A" Value="G1A" />
                        <asp:ListItem Text="Grade 1 - B" Value="G1B" />
                        <asp:ListItem Text="Grade 5 - A" Value="G5A" />
                        <asp:ListItem Text="Grade 8 - A" Value="G8A" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-3" id="divDepartmentFilter" runat="server" Visible="false">
                    <asp:Label ID="lblFilterDepartment" runat="server" Text="Filter by Department" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:DropDownList ID="ddlFilterDepartment" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- All Departments --" Value="" />
                        <asp:ListItem Text="Science" Value="SCI" />
                        <asp:ListItem Text="Math" Value="MATH" />
                        <asp:ListItem Text="Arts" Value="ART" />
                        <asp:ListItem Text="Administration" Value="ADMIN" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-3">
                    <asp:Label ID="lblStartDate" runat="server" Text="Start Date" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-3">
                    <asp:Label ID="lblEndDate" runat="server" Text="End Date" CssClass="form-label fw-semibold"></asp:Label>
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-3 d-grid">
                    <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn btn-primary" OnClick="btnGenerateReport_Click" />
                </div>
            </div>

            <asp:Panel ID="pnlReportResults" runat="server" Visible="false" CssClass="mt-4 pt-4 border-top">
                <h4 class="report-section-title">Report Summary</h4>
                <div class="row g-3 mb-4 d-flex justify-content-center">
                    <div class="col-sm-6 col-md-2">
                        <div class="summary-box present">
                            <h4><asp:Literal ID="litPresentCount" runat="server"></asp:Literal></h4>
                            <p>Present Days</p>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-2">
                        <div class="summary-box absent">
                            <h4><asp:Literal ID="litAbsentCount" runat="server"></asp:Literal></h4>
                            <p>Absent Days</p>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-2">
                        <div class="summary-box late">
                            <h4><asp:Literal ID="litLateCount" runat="server"></asp:Literal></h4>
                            <p>Late Days</p>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-2">
                        <div class="summary-box leave">
                            <h4><asp:Literal ID="litLeaveCount" runat="server"></asp:Literal></h4>
                            <p>Leave Days</p>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-2">
                        <div class="summary-box total">
                            <h4><asp:Literal ID="litTotalDays" runat="server"></asp:Literal></h4>
                            <p>Total Marked Days</p>
                        </div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-lg-8 offset-lg-2">
                         <h5 class="fw-bold mb-3 text-center">Attendance Distribution</h5>
                        <div id="overallAttendanceChart" style="height: 300px;"></div>
                         <asp:Literal ID="litChartPresent" runat="server" Visible="false"></asp:Literal>
                         <asp:Literal ID="litChartAbsent" runat="server" Visible="false"></asp:Literal>
                         <asp:Literal ID="litChartLate" runat="server" Visible="false"></asp:Literal>
                         <asp:Literal ID="litChartLeave" runat="server" Visible="false"></asp:Literal>
                    </div>
                </div>

                <h4 class="report-section-title">Detailed Attendance Data</h4>
                <div class="table-responsive">
                    <asp:GridView ID="gvAttendanceReport" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover align-middle"
                        DataKeyNames="EntryID"> <%-- Assuming an EntryID for each attendance record --%>
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Student / Teacher Name" />
                            <asp:BoundField DataField="Identifier" HeaderText="Roll No / Employee ID" />
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:BoundField DataField="ClassDept" HeaderText="Class / Department" />
                        </Columns>
                         <EmptyDataTemplate>
                            <div class="alert alert-info" role="alert">
                                No detailed attendance records found for the selected criteria.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <div class="mt-4 text-center">
                    <asp:Button ID="btnExportPdf" runat="server" Text="Export to PDF" CssClass="btn btn-outline-danger me-2" OnClick="btnExportPdf_Click" />
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" CssClass="btn btn-outline-success" OnClick="btnExportExcel_Click" />
                </div>
            </asp:Panel>
            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
        </div>
    </div>
</asp:Content>