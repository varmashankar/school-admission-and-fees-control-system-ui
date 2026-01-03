<%@ Page Title="Teacher Dashboard" Async="true" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="dashboard-teachers.aspx.cs" Inherits="Dashboard_dashboard_teachers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Dashboard</h1>
        <div class="small text-muted">Welcome back, <asp:Label ID="lblTeacherName" runat="server" Text="Teacher"></asp:Label></div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Date Range Filter (matches admin) -->
    <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2 mb-3">
        <div class="text-muted small">
            <i class="bi bi-calendar3 me-1"></i><%= DateTime.Now.ToString("dddd, MMMM dd, yyyy") %>
        </div>
        <div class="btn-group" role="group" aria-label="Dashboard range">
            <button type="button" class="btn btn-outline-secondary btn-sm active" data-range="today">Today</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" data-range="week">This Week</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" data-range="month">This Month</button>
        </div>
    </div>

    <!-- Stats Cards (matches admin pattern) -->
    <div class="row g-4 mb-4">

        <!-- Today's Classes -->
        <div class="col-md-6 col-xl-3">
            <div class="card shadow-sm stat-card border-0 h-100" style="--accent-color: #16a34a">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-success bg-opacity-10 me-3">
                        <i class="bi bi-calendar3 fs-2 text-success"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Today's Classes</p>
                        <h3 class="stat-value mb-0">
                            <asp:Label ID="lblTodaysClasses" runat="server">--</asp:Label>
                        </h3>
                        <span class="stat-sub text-muted">Scheduled</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- My Students -->
        <div class="col-md-6 col-xl-3">
            <div class="card shadow-sm stat-card border-0 h-100" style="--accent-color: #0d6efd">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-primary bg-opacity-10 me-3">
                        <i class="bi bi-people-fill fs-2 text-primary"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">My Students</p>
                        <h3 class="stat-value mb-0">
                            <asp:Label ID="lblTotalStudents" runat="server">--</asp:Label>
                        </h3>
                        <span class="stat-sub text-muted">Total</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Attendance Today -->
        <div class="col-md-6 col-xl-3">
            <div class="card shadow-sm stat-card border-0 h-100" style="--accent-color: #ffc107">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-warning bg-opacity-10 me-3">
                        <i class="bi bi-clipboard-check fs-2 text-warning"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Attendance Today</p>
                        <h3 class="stat-value mb-0">
                            <asp:Label ID="lblAttendancePercent" runat="server">--</asp:Label>%
                        </h3>
                        <span class="stat-sub">
                            <span class="text-success"><asp:Label ID="lblPresentToday" runat="server">0</asp:Label> present</span> · 
                            <span class="text-danger"><asp:Label ID="lblAbsentToday" runat="server">0</asp:Label> absent</span>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upcoming Exams -->
        <div class="col-md-6 col-xl-3">
            <div class="card shadow-sm stat-card border-0 h-100" style="--accent-color: #dc3545">
                <div class="card-body d-flex align-items-center p-3">
                    <div class="icon-bg bg-danger bg-opacity-10 me-3">
                        <i class="bi bi-pencil-square fs-2 text-danger"></i>
                    </div>
                    <div>
                        <p class="text-muted mb-1">Upcoming Exams</p>
                        <h3 class="stat-value mb-0">
                            <asp:Label ID="lblUpcomingExams" runat="server">--</asp:Label>
                        </h3>
                        <span class="stat-sub text-muted">Next 30 days</span>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Quick Actions & Attention Needed (matches admin) -->
    <div class="row g-4 mb-4">
        <!-- Quick Actions -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h6 class="fw-bold mb-0">
                            <i class="bi bi-lightning-charge-fill text-warning me-2"></i>Quick Actions
                        </h6>
                        <span class="badge bg-light text-muted border">Shortcuts</span>
                    </div>

                    <div class="d-flex flex-wrap gap-2">
                        <a class="btn btn-success btn-sm" href="attendance.aspx"><i class="bi bi-clipboard-check me-1"></i>Mark Attendance</a>
                        <a class="btn btn-primary btn-sm" href="assignments.aspx"><i class="bi bi-journal-text me-1"></i>Create Assignment</a>
                        <a class="btn btn-outline-success btn-sm" href="exam-results.aspx"><i class="bi bi-pencil-square me-1"></i>Enter Marks</a>
                        <a class="btn btn-outline-primary btn-sm" href="student-performance.aspx"><i class="bi bi-bar-chart-line me-1"></i>View Performance</a>
                        <a class="btn btn-outline-secondary btn-sm" href="messages.aspx"><i class="bi bi-chat-dots me-1"></i>Send Message</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Attention Needed -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h6 class="fw-bold mb-0">
                            <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>Attention Needed
                        </h6>
                        <span class="badge bg-light text-muted border">Priority</span>
                    </div>

                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0 d-flex justify-content-between align-items-center">
                            <span class="small"><i class="bi bi-clipboard-x me-2 text-warning"></i>Attendance not marked</span>
                            <span class="badge bg-warning-subtle text-warning-emphasis">2 classes</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between align-items-center">
                            <span class="small"><i class="bi bi-journal-text me-2 text-secondary"></i>Assignments to review</span>
                            <span class="badge bg-secondary-subtle text-secondary-emphasis">15</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between align-items-center">
                            <span class="small"><i class="bi bi-person-x me-2 text-danger"></i>Low attendance students</span>
                            <span class="badge bg-danger-subtle text-danger-emphasis">5</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Today's Schedule & Recent Activities (matches admin) -->
    <div class="row g-4 mb-4">
        <!-- Today's Schedule -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-clock-history text-success me-2"></i>Today's Schedule
                        </h5>
                        <span class="badge bg-light text-muted border"><%= DateTime.Now.ToString("dddd") %></span>
                    </div>

                    <asp:Repeater ID="rptTodaysClasses" runat="server">
                        <ItemTemplate>
                            <div class="d-flex align-items-center gap-3 p-3 border-bottom">
                                <div class="icon-bg-sm bg-success bg-opacity-10 d-flex align-items-center justify-content-center">
                                    <span class="fw-bold text-success small">P<%# Eval("periodNo") %></span>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold"><%# Eval("subjectName") %></div>
                                    <div class="text-muted small"><%# Eval("className") %> <%# Eval("section") %></div>
                                </div>
                                <div class="text-end">
                                    <div class="small fw-medium"><%# Eval("startTime") %> - <%# Eval("endTime") %></div>
                                    <div class="text-muted small">Room: <%# Eval("roomNo") ?? "TBD" %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoClasses" runat="server" Visible="false" CssClass="text-center py-5 text-muted">
                        <i class="bi bi-calendar-x fs-1 mb-2 d-block"></i>
                        <p class="mb-0">No classes scheduled for today.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>

        <!-- Class Attendance Summary -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-pie-chart-fill text-primary me-2"></i>Attendance Summary
                        </h5>
                        <span class="badge bg-light text-muted border">By Class</span>
                    </div>

                    <asp:Repeater ID="rptAttendanceSummary" runat="server">
                        <ItemTemplate>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="small fw-medium"><%# Eval("className") %></span>
                                    <span class="small text-muted">
                                        <span class="text-success fw-semibold"><%# Eval("presentCount") %></span>/<%# Eval("totalStudents") %>
                                    </span>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-success" role="progressbar" style='width: <%# Eval("attendancePercentage") ?? "0" %>%'></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoAttendance" runat="server" Visible="false" CssClass="text-center py-4 text-muted">
                        <i class="bi bi-clipboard fs-2 mb-2 d-block"></i>
                        <p class="mb-0 small">No attendance data for today.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <!-- Upcoming Exams & Recent Notices -->
    <div class="row g-4">
        <!-- Upcoming Exams -->
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-calendar-event-fill text-danger me-2"></i>Upcoming Exams
                        </h5>
                        <a href="create-exam.aspx" class="btn btn-outline-success btn-sm">View all</a>
                    </div>

                    <asp:Repeater ID="rptUpcomingExams" runat="server">
                        <ItemTemplate>
                            <div class="d-flex align-items-center gap-3 p-3 border-bottom">
                                <div class="bg-danger bg-opacity-10 rounded px-2 py-1 text-center" style="min-width: 50px;">
                                    <div class="small text-danger text-uppercase"><%# Convert.ToDateTime(Eval("examDate")).ToString("MMM") %></div>
                                    <div class="fw-bold text-danger"><%# Convert.ToDateTime(Eval("examDate")).ToString("dd") %></div>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold"><%# Eval("examName") %></div>
                                    <div class="text-muted small"><%# Eval("subjectName") %> · <%# Eval("className") %></div>
                                </div>
                                <span class="badge bg-light text-muted border"><%# Eval("maxMarks") %> marks</span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoExams" runat="server" Visible="false" CssClass="text-center py-4 text-muted">
                        <i class="bi bi-calendar-x fs-2 mb-2 d-block"></i>
                        <p class="mb-0 small">No upcoming exams.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>

        <!-- Recent Notices -->
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-megaphone-fill text-warning me-2"></i>Recent Notices
                        </h5>
                        <a href="notifications.aspx" class="btn btn-outline-success btn-sm">View all</a>
                    </div>

                    <asp:Repeater ID="rptNotices" runat="server">
                        <ItemTemplate>
                            <div class="d-flex align-items-start gap-3 p-3 border-bottom">
                                <div class="icon-bg-sm bg-warning bg-opacity-10 d-flex align-items-center justify-content-center">
                                    <i class="bi bi-bell text-warning"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold"><%# Eval("title") %></div>
                                    <div class="text-muted small text-truncate" style="max-width: 300px;"><%# Eval("description") %></div>
                                    <div class="text-muted small mt-1"><%# Eval("publishDate") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoNotices" runat="server" Visible="false" CssClass="text-center py-4 text-muted">
                        <i class="bi bi-bell-slash fs-2 mb-2 d-block"></i>
                        <p class="mb-0 small">No recent notices.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

