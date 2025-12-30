using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_dashboard_teachers : AuthenticatedPage
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblLastUpdated.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            
            // Get teacher name from session
            if (Session["userName"] != null)
                lblTeacherName.Text = Session["userName"].ToString();

            await LoadDashboardData();
        }
    }

    private async Task LoadDashboardData()
    {
        int? teacherId = GetTeacherIdFromSession();
        var filter = new { teacherId = teacherId };

        await Task.WhenAll(
            FetchDashboardStats(filter),
            FetchTodaysClasses(filter),
            FetchAttendanceSummary(filter),
            FetchUpcomingExams(filter),
            FetchRecentNotices()
        );
    }

    private int? GetTeacherIdFromSession()
    {
        if (Session["userId"] != null)
        {
            int id;
            if (int.TryParse(Session["userId"].ToString(), out id))
                return id;
        }
        return null;
    }

    private async Task FetchDashboardStats(object filter)
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/TeacherDashboard/getTeacherDashboardStats",
                filter,
                HttpContext.Current
            );

            if (res == null || res.response_code != "200")
            {
                // Use default values
                return;
            }

            string json = JsonConvert.SerializeObject(res.obj);
            dynamic stats = JsonConvert.DeserializeObject<dynamic>(json);

            if (stats != null)
            {
                lblTodaysClasses.Text = stats.todaysClasses != null ? stats.todaysClasses.ToString() : "0";
                lblTotalStudents.Text = stats.totalStudents != null ? stats.totalStudents.ToString() : "0";
                lblUpcomingExams.Text = stats.upcomingExams != null ? stats.upcomingExams.ToString() : "0";
                
                lblPresentToday.Text = stats.presentToday != null ? stats.presentToday.ToString() : "0";
                lblAbsentToday.Text = stats.absentToday != null ? stats.absentToday.ToString() : "0";
                lblAttendancePercent.Text = stats.attendancePercentage != null 
                    ? Math.Round((decimal)stats.attendancePercentage, 1).ToString() 
                    : "0";
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching dashboard stats: " + ex.Message);
        }
    }

    private async Task FetchTodaysClasses(object filter)
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/TeacherDashboard/getTodaysClasses",
                filter,
                HttpContext.Current
            );

            if (res == null || res.response_code != "200")
            {
                pnlNoClasses.Visible = true;
                return;
            }

            string json = JsonConvert.SerializeObject(res.obj);
            var classes = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (classes != null && classes.Count > 0)
            {
                rptTodaysClasses.DataSource = classes;
                rptTodaysClasses.DataBind();
                pnlNoClasses.Visible = false;
            }
            else
            {
                pnlNoClasses.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching today's classes: " + ex.Message);
            pnlNoClasses.Visible = true;
        }
    }

    private async Task FetchAttendanceSummary(object filter)
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/TeacherDashboard/getAttendanceSummary",
                filter,
                HttpContext.Current
            );

            if (res == null || res.response_code != "200")
            {
                pnlNoAttendance.Visible = true;
                return;
            }

            string json = JsonConvert.SerializeObject(res.obj);
            var summary = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (summary != null && summary.Count > 0)
            {
                rptAttendanceSummary.DataSource = summary;
                rptAttendanceSummary.DataBind();
                pnlNoAttendance.Visible = false;
            }
            else
            {
                pnlNoAttendance.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching attendance summary: " + ex.Message);
            pnlNoAttendance.Visible = true;
        }
    }

    private async Task FetchUpcomingExams(object filter)
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/TeacherDashboard/getUpcomingExams",
                filter,
                HttpContext.Current
            );

            if (res == null || res.response_code != "200")
            {
                pnlNoExams.Visible = true;
                return;
            }

            string json = JsonConvert.SerializeObject(res.obj);
            var exams = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (exams != null && exams.Count > 0)
            {
                rptUpcomingExams.DataSource = exams;
                rptUpcomingExams.DataBind();
                pnlNoExams.Visible = false;
            }
            else
            {
                pnlNoExams.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching upcoming exams: " + ex.Message);
            pnlNoExams.Visible = true;
        }
    }

    private async Task FetchRecentNotices()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/TeacherDashboard/getRecentNotices",
                new { },
                HttpContext.Current
            );

            if (res == null || res.response_code != "200")
            {
                pnlNoNotices.Visible = true;
                return;
            }

            string json = JsonConvert.SerializeObject(res.obj);
            var notices = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (notices != null && notices.Count > 0)
            {
                rptNotices.DataSource = notices;
                rptNotices.DataBind();
                pnlNoNotices.Visible = false;
            }
            else
            {
                pnlNoNotices.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error fetching notices: " + ex.Message);
            pnlNoNotices.Visible = true;
        }
    }
}