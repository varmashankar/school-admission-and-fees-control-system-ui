<%@ Page Title="Teacher Dashboard" Async="true" Language="C#" MasterPageFile="~/Master/teachers.master" AutoEventWireup="true" CodeFile="dashboard-teachers.aspx.cs" Inherits="Dashboard_dashboard_teachers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="pageTitle" runat="server">
    <div>
        <h1 class="text-xl font-bold text-gray-800">Dashboard</h1>
        <div class="text-sm text-gray-500">Last updated: <asp:Label ID="lblLastUpdated" runat="server" Text="--"></asp:Label></div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Welcome Banner -->
    <div class="bg-gradient-to-r from-green-500 to-green-600 rounded-lg shadow-lg p-6 mb-6 text-white">
        <h2 class="text-2xl font-bold mb-2">Welcome back, <asp:Label ID="lblTeacherName" runat="server" Text="Teacher"></asp:Label>!</h2>
        <p class="opacity-90">Here's an overview of your classes and activities for today.</p>
    </div>

    <!-- Stats Cards Row -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">

        <!-- Today's Classes -->
        <div class="bg-white rounded-lg shadow p-4 border-l-4 border-green-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm">Today's Classes</p>
                    <h3 class="text-2xl font-bold text-gray-800">
                        <asp:Label ID="lblTodaysClasses" runat="server" Text="--"></asp:Label>
                    </h3>
                </div>
                <div class="bg-green-100 p-3 rounded-full">
                    <i class="bi bi-calendar3 text-2xl text-green-600"></i>
                </div>
            </div>
        </div>

        <!-- Total Students -->
        <div class="bg-white rounded-lg shadow p-4 border-l-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm">My Students</p>
                    <h3 class="text-2xl font-bold text-gray-800">
                        <asp:Label ID="lblTotalStudents" runat="server" Text="--"></asp:Label>
                    </h3>
                </div>
                <div class="bg-blue-100 p-3 rounded-full">
                    <i class="bi bi-people-fill text-2xl text-blue-600"></i>
                </div>
            </div>
        </div>

        <!-- Attendance Today -->
        <div class="bg-white rounded-lg shadow p-4 border-l-4 border-yellow-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm">Attendance Today</p>
                    <h3 class="text-2xl font-bold text-gray-800">
                        <asp:Label ID="lblAttendancePercent" runat="server" Text="--"></asp:Label>%
                    </h3>
                    <p class="text-xs text-gray-400">
                        <asp:Label ID="lblPresentToday" runat="server" Text="0"></asp:Label> present / 
                        <asp:Label ID="lblAbsentToday" runat="server" Text="0"></asp:Label> absent
                    </p>
                </div>
                <div class="bg-yellow-100 p-3 rounded-full">
                    <i class="bi bi-clipboard-check text-2xl text-yellow-600"></i>
                </div>
            </div>
        </div>

        <!-- Upcoming Exams -->
        <div class="bg-white rounded-lg shadow p-4 border-l-4 border-red-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm">Upcoming Exams</p>
                    <h3 class="text-2xl font-bold text-gray-800">
                        <asp:Label ID="lblUpcomingExams" runat="server" Text="--"></asp:Label>
                    </h3>
                </div>
                <div class="bg-red-100 p-3 rounded-full">
                    <i class="bi bi-pencil-square text-2xl text-red-600"></i>
                </div>
            </div>
        </div>

    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">

        <!-- Today's Schedule -->
        <div class="lg:col-span-2 bg-white rounded-lg shadow">
            <div class="p-4 border-b flex items-center justify-between">
                <h3 class="font-semibold text-gray-800">
                    <i class="bi bi-clock-history text-green-600 mr-2"></i>Today's Schedule
                </h3>
                <span class="text-sm text-gray-500"><%= DateTime.Now.ToString("dddd, MMMM dd") %></span>
            </div>
            <div class="p-4">
                <asp:Repeater ID="rptTodaysClasses" runat="server">
                    <ItemTemplate>
                        <div class="flex items-center gap-4 p-3 hover:bg-gray-50 rounded-lg border-b last:border-b-0">
                            <div class="bg-green-100 text-green-700 font-bold rounded-lg px-3 py-2 text-center min-w-16">
                                <div class="text-xs">Period</div>
                                <div class="text-lg"><%# Eval("periodNo") %></div>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-semibold text-gray-800"><%# Eval("subjectName") %></h4>
                                <p class="text-sm text-gray-500"><%# Eval("className") %> <%# Eval("section") %></p>
                            </div>
                            <div class="text-right">
                                <p class="text-sm font-medium text-gray-700"><%# Eval("startTime") %> - <%# Eval("endTime") %></p>
                                <p class="text-xs text-gray-400">Room: <%# Eval("roomNo") ?? "TBD" %></p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoClasses" runat="server" Visible="false" CssClass="text-center py-8 text-gray-500">
                    <i class="bi bi-calendar-x text-4xl mb-2"></i>
                    <p>No classes scheduled for today.</p>
                </asp:Panel>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="bg-white rounded-lg shadow">
            <div class="p-4 border-b">
                <h3 class="font-semibold text-gray-800">
                    <i class="bi bi-lightning-charge-fill text-yellow-500 mr-2"></i>Quick Actions
                </h3>
            </div>
            <div class="p-4 space-y-3">
                <a href="attendance.aspx" class="flex items-center gap-3 p-3 bg-green-50 hover:bg-green-100 rounded-lg transition">
                    <i class="bi bi-clipboard-check text-green-600 text-xl"></i>
                    <span class="font-medium text-gray-700">Mark Attendance</span>
                </a>
                <a href="assignments.aspx" class="flex items-center gap-3 p-3 bg-blue-50 hover:bg-blue-100 rounded-lg transition">
                    <i class="bi bi-journal-text text-blue-600 text-xl"></i>
                    <span class="font-medium text-gray-700">Create Assignment</span>
                </a>
                <a href="exam-results.aspx" class="flex items-center gap-3 p-3 bg-purple-50 hover:bg-purple-100 rounded-lg transition">
                    <i class="bi bi-pencil-square text-purple-600 text-xl"></i>
                    <span class="font-medium text-gray-700">Enter Exam Marks</span>
                </a>
                <a href="student-performance.aspx" class="flex items-center gap-3 p-3 bg-orange-50 hover:bg-orange-100 rounded-lg transition">
                    <i class="bi bi-bar-chart-line text-orange-600 text-xl"></i>
                    <span class="font-medium text-gray-700">View Performance</span>
                </a>
                <a href="messages.aspx" class="flex items-center gap-3 p-3 bg-gray-50 hover:bg-gray-100 rounded-lg transition">
                    <i class="bi bi-chat-dots text-gray-600 text-xl"></i>
                    <span class="font-medium text-gray-700">Send Message</span>
                </a>
            </div>
        </div>

    </div>

    <!-- Second Row -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">

        <!-- Attendance Summary by Class -->
        <div class="bg-white rounded-lg shadow">
            <div class="p-4 border-b">
                <h3 class="font-semibold text-gray-800">
                    <i class="bi bi-pie-chart-fill text-blue-600 mr-2"></i>Class Attendance Summary
                </h3>
            </div>
            <div class="p-4">
                <asp:Repeater ID="rptAttendanceSummary" runat="server">
                    <ItemTemplate>
                        <div class="mb-4 last:mb-0">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-sm font-medium text-gray-700"><%# Eval("className") %></span>
                                <span class="text-sm text-gray-500"><%# Eval("presentCount") %>/<%# Eval("totalStudents") %> present</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-green-500 h-2 rounded-full" style='width: <%# Eval("attendancePercentage") ?? "0" %>%'></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoAttendance" runat="server" Visible="false" CssClass="text-center py-6 text-gray-500">
                    <i class="bi bi-clipboard text-3xl mb-2"></i>
                    <p>No attendance data for today.</p>
                </asp:Panel>
            </div>
        </div>

        <!-- Upcoming Exams List -->
        <div class="bg-white rounded-lg shadow">
            <div class="p-4 border-b flex items-center justify-between">
                <h3 class="font-semibold text-gray-800">
                    <i class="bi bi-calendar-event text-red-600 mr-2"></i>Upcoming Exams
                </h3>
                <a href="create-exam.aspx" class="text-sm text-green-600 hover:underline">View All</a>
            </div>
            <div class="p-4">
                <asp:Repeater ID="rptUpcomingExams" runat="server">
                    <ItemTemplate>
                        <div class="flex items-center gap-3 p-3 hover:bg-gray-50 rounded-lg border-b last:border-b-0">
                            <div class="bg-red-100 text-red-700 rounded-lg px-3 py-2 text-center">
                                <div class="text-xs"><%# Convert.ToDateTime(Eval("examDate")).ToString("MMM") %></div>
                                <div class="text-lg font-bold"><%# Convert.ToDateTime(Eval("examDate")).ToString("dd") %></div>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-semibold text-gray-800"><%# Eval("examName") %></h4>
                                <p class="text-sm text-gray-500"><%# Eval("subjectName") %> - <%# Eval("className") %></p>
                            </div>
                            <div class="text-right text-sm text-gray-500">
                                <%# Eval("maxMarks") %> marks
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoExams" runat="server" Visible="false" CssClass="text-center py-6 text-gray-500">
                    <i class="bi bi-calendar-x text-3xl mb-2"></i>
                    <p>No upcoming exams in the next 30 days.</p>
                </asp:Panel>
            </div>
        </div>

    </div>

    <!-- Recent Notices -->
    <div class="bg-white rounded-lg shadow">
        <div class="p-4 border-b flex items-center justify-between">
            <h3 class="font-semibold text-gray-800">
                <i class="bi bi-megaphone-fill text-orange-500 mr-2"></i>Recent Notices
            </h3>
            <a href="notifications.aspx" class="text-sm text-green-600 hover:underline">View All</a>
        </div>
        <div class="p-4">
            <asp:Repeater ID="rptNotices" runat="server">
                <ItemTemplate>
                    <div class="flex items-start gap-4 p-3 hover:bg-gray-50 rounded-lg border-b last:border-b-0">
                        <div class="bg-orange-100 p-2 rounded-full">
                            <i class="bi bi-bell text-orange-600"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="font-semibold text-gray-800"><%# Eval("title") %></h4>
                            <p class="text-sm text-gray-500 line-clamp-2"><%# Eval("description") %></p>
                            <p class="text-xs text-gray-400 mt-1"><%# Eval("publishDate") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Panel ID="pnlNoNotices" runat="server" Visible="false" CssClass="text-center py-6 text-gray-500">
                <i class="bi bi-bell-slash text-3xl mb-2"></i>
                <p>No recent notices.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>

