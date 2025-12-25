<%@ Page Title="Dashboard" Async="true" Language="C#" MasterPageFile="~/Master/admin.master" AutoEventWireup="true" CodeFile="dashboard-admin.aspx.cs" Inherits="Dashboard_dashboard_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="/Master/js/dashboard-admin.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="h4 mb-0 text-dark">Dashboard</h1>
        <div class="small text-muted">Last updated: <asp:Label ID="lblLastUpdated" runat="server" Text="--"></asp:Label>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2 mb-3">
        <div class="text-muted small">
            <i class="bi bi-funnel me-1"></i>Range
        </div>
        <div class="btn-group" role="group" aria-label="Dashboard range">
            <button type="button" class="btn btn-outline-secondary btn-sm active" data-range="today">Today</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" data-range="week">This week</button>
            <button type="button" class="btn btn-outline-secondary btn-sm" data-range="month">This month</button>
        </div>
    </div>

    <div class="row g-4 mb-4">

        <!-- Total Students -->
        <div class="col-md-6 col-xl-3">
            <asp:LinkButton ID="lnkStudents"
                runat="server"
                CssClass="text-decoration-none text-reset"
                OnClick="lnkStudents_Click">

                <div class="card shadow-sm stat-card border-0 h-100"
                    style="--accent-color: #0d6efd">
                    <div class="card-body d-flex align-items-center p-3">
                        <div class="icon-bg bg-primary bg-opacity-10 me-3">
                            <i class="bi bi-people-fill fs-2 text-primary"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-1">Total Students</p>
                            <h3 class="stat-value mb-0">
                                <asp:Label ID="lblTotalStudents" runat="server">--</asp:Label>
                            </h3>
                        </div>
                    </div>
                </div>

            </asp:LinkButton>
        </div>


        <!-- Total Teachers -->
        <div class="col-md-6 col-xl-3">
            <asp:LinkButton ID="lnkTeachers"
                runat="server"
                CssClass="text-decoration-none text-reset"
                OnClick="lnkTeachers_Click">

                <div class="card shadow-sm stat-card border-0 h-100"
                    style="--accent-color: #198754">
                    <div class="card-body d-flex align-items-center p-3">
                        <div class="icon-bg bg-success bg-opacity-10 me-3">
                            <i class="bi bi-mortarboard-fill fs-2 text-success"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-1">Total Teachers</p>
                            <h3 class="stat-value mb-0">
                                <asp:Label ID="lblTotalTeachers" runat="server" CssClass="skeleton">--</asp:Label>
                            </h3>
                        </div>
                    </div>
                </div>

            </asp:LinkButton>
        </div>


        <!-- Fees Collected -->
        <div class="col-md-6 col-xl-3">
            <asp:LinkButton ID="lnkFees"
                runat="server"
                CssClass="text-decoration-none text-reset"
                OnClick="lnkFees_Click">

                <div class="card shadow-sm stat-card border-0 h-100"
                    style="--accent-color: #ffc107">
                    <div class="card-body d-flex align-items-center p-3">
                        <div class="icon-bg bg-warning bg-opacity-10 me-3">
                            <i class="bi bi-cash-coin fs-2 text-warning"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-1">Fees Collected</p>
                            <h3 class="stat-value mb-0">₹<asp:Label ID="lblFeesCollected" runat="server" CssClass="skeleton">--</asp:Label>
                                <span class="fs-6 text-muted">Lakhs</span>
                            </h3>
                        </div>
                    </div>
                </div>

            </asp:LinkButton>
        </div>


        <!-- Upcoming Events -->
        <div class="col-md-6 col-xl-3">
            <asp:LinkButton ID="lnkEvents"
                runat="server"
                CssClass="text-decoration-none text-reset"
                OnClick="lnkEvents_Click">

                <div class="card shadow-sm stat-card border-0 h-100"
                    style="--accent-color: #dc3545">
                    <div class="card-body d-flex align-items-center p-3">
                        <div class="icon-bg bg-danger bg-opacity-10 me-3">
                            <i class="bi bi-calendar-check-fill fs-2 text-danger"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-1">Upcoming Events</p>
                            <h3 class="stat-value mb-0">
                                <asp:Label ID="lblUpcomingEvents" runat="server" CssClass="skeleton">--</asp:Label>
                            </h3>
                        </div>
                    </div>
                </div>

            </asp:LinkButton>
        </div>


    </div>



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
                        <a class="btn btn-primary btn-sm" href="/Dashboard/admin/admissionform.aspx"><i class="bi bi-person-plus me-1"></i>Add Student</a>
                        <a class="btn btn-success btn-sm" href="/Dashboard/admin/addnewteacher.aspx"><i class="bi bi-mortarboard me-1"></i>Add Teacher</a>
                        <a class="btn btn-outline-primary btn-sm" href="/Dashboard/admin/attendance.aspx"><i class="bi bi-check2-square me-1"></i>Mark Attendance</a>
                        <a class="btn btn-outline-warning btn-sm" href="/Dashboard/admin/fees.aspx"><i class="bi bi-cash-coin me-1"></i>Collect Fee</a>
                        <a class="btn btn-outline-secondary btn-sm" href="/Dashboard/admin/notice.aspx"><i class="bi bi-megaphone me-1"></i>Create Notice</a>
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
                            <span class="small"><i class="bi bi-receipt-cutoff me-2 text-warning"></i>Fee dues pending</span>
                            <span class="badge bg-warning-subtle text-warning-emphasis">12</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between align-items-center">
                            <span class="small"><i class="bi bi-file-earmark-text me-2 text-secondary"></i>Missing student documents</span>
                            <span class="badge bg-secondary-subtle text-secondary-emphasis">7</span>
                        </li>
                        <li class="list-group-item px-0 d-flex justify-content-between align-items-center">
                            <span class="small"><i class="bi bi-person-x me-2 text-danger"></i>Low attendance alerts</span>
                            <span class="badge bg-danger-subtle text-danger-emphasis">3</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>



    <!-- Charts & Activities -->
    <div class="row g-4">
        <!-- Student Admission Trend Chart -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-bar-chart-line-fill text-primary me-2"></i>Student Admission Trend
                        </h5>
                        <span class="badge bg-light text-muted border">Last 6 months</span>
                    </div>

                    <div style="height: 280px;">
                        <canvas id="chartAdmissions"></canvas>
                    </div>

                    <div id="chartAdmissionsEmpty" class="text-center text-muted small mt-3 d-none">
                        Chart data not available.
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-clock-history text-primary me-2"></i>Recent Activities
                        </h5>
                        <span class="badge bg-light text-muted border">Today</span>
                    </div>

                    <ul class="list-unstyled mb-0">
                        <li class="d-flex align-items-start gap-3 mb-4">
                            <div class="icon-bg icon-bg-sm bg-primary bg-opacity-10">
                                <i class="bi bi-person-plus-fill text-primary"></i>
                            </div>
                            <div class="small">
                                New student <strong>Ravi Kumar</strong> admitted to Grade 8.
                                <div class="text-muted">2 hours ago</div>
                            </div>
                        </li>
                        <li class="d-flex align-items-start gap-3 mb-4">
                            <div class="icon-bg icon-bg-sm bg-success bg-opacity-10">
                                <i class="bi bi-cash text-success"></i>
                            </div>
                            <div class="small">
                                Fees payment of ₹15,000 received from <strong>Anjali Sharma</strong>.
                                <div class="text-muted">4 hours ago</div>
                            </div>
                        </li>
                        <li class="d-flex align-items-start gap-3">
                            <div class="icon-bg icon-bg-sm bg-danger bg-opacity-10">
                                <i class="bi bi-calendar-event-fill text-danger"></i>
                            </div>
                            <div class="small">
                                Annual Sports Day scheduled on 30th Oct.
                                <div class="text-muted">Yesterday</div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4 mt-1">
        <div class="col-12">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                        <h5 class="card-title fw-bold mb-0">
                            <i class="bi bi-people-fill text-primary me-2"></i>Recent Admissions
                        </h5>
                        <a href="/Dashboard/admin/students.aspx" class="btn btn-outline-primary btn-sm">View all</a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-sm align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Student</th>
                                    <th>Class</th>
                                    <th>Admission Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="fw-semibold">Ravi Kumar</div>
                                        <div class="text-muted small">SID-10021</div>
                                    </td>
                                    <td>Grade 8</td>
                                    <td>2025-12-01</td>
                                    <td><span class="badge bg-success-subtle text-success-emphasis">Active</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="fw-semibold">Anjali Sharma</div>
                                        <div class="text-muted small">SID-10020</div>
                                    </td>
                                    <td>Grade 6</td>
                                    <td>2025-11-28</td>
                                    <td><span class="badge bg-success-subtle text-success-emphasis">Active</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="fw-semibold">Mohit Verma</div>
                                        <div class="text-muted small">SID-10019</div>
                                    </td>
                                    <td>Grade 9</td>
                                    <td>2025-11-22</td>
                                    <td><span class="badge bg-secondary-subtle text-secondary-emphasis">Pending Docs</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-muted small mt-3">Table is UI-only for now; can be wired to students list API later.</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (window.DashboardAdmin && typeof window.DashboardAdmin.renderAdmissionsChart === 'function') {
                window.DashboardAdmin.renderAdmissionsChart('chartAdmissions',
                    ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                    [12, 19, 14, 22, 28, 35]
                );
            }
        });
    </script>
</asp:Content>
