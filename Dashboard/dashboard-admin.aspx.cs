using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

public partial class Dashboard_dashboard_admin : AuthenticatedPage
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblLastUpdated.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            await FetchDashboardStatsFromApi();
        }
    }

    private async Task FetchDashboardStatsFromApi()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync(
                "api/Dashboard/getDashboardStats",
                new { },
                HttpContext.Current
            );

            if (res == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            if (res.response_code != "200")
            {
                ShowAlert(
                    res.obj == null ? "Failed to load dashboard statistics." : res.obj.ToString(),
                    "error"
                );
                return;
            }

            // IMPORTANT: dashboard returns SINGLE object, not list
            string json = JsonConvert.SerializeObject(res.obj);

            JArray arr = JArray.Parse(json);
            if (arr.Count == 0)
            {
                ShowAlert("Dashboard data not available.", "error");
                return;
            }

            JObject stats = (JObject)arr[0];
            BindDashboardStats(stats);

        }
        catch (JsonException)
        {
            ShowAlert("Dashboard data parsing failed.", "error");
        }
        catch (HttpRequestException)
        {
            ShowAlert("Unable to reach server.", "error");
        }
        catch (Exception ex)
        {
            ShowAlert(ex.Message, "error");
        }
    }

    protected void lnkStudents_Click(object sender, EventArgs e)
    {
        RedirectSafe("~/Dashboard/admin/students.aspx");
    }

    protected void lnkTeachers_Click(object sender, EventArgs e)
    {
        RedirectSafe("~/Dashboard/admin/teachers.aspx");
    }

    protected void lnkFees_Click(object sender, EventArgs e)
    {
        RedirectSafe("~/Dashboard/admin/fees.aspx");
    }

    protected void lnkEvents_Click(object sender, EventArgs e)
    {
        RedirectSafe("~/Dashboard/admin/events.aspx");
    }


    private void BindDashboardStats(dynamic stats)
    {
        // remove skeleton classes
        lblTotalStudents.CssClass = "";
        lblTotalTeachers.CssClass = "";
        lblFeesCollected.CssClass = "";
        lblUpcomingEvents.CssClass = "";

        // defensive reading (no DTO, no crashes)
        lblTotalStudents.Text = stats.totalStudents != null
            ? ((int)stats.totalStudents).ToString("N0")
            : "0";

        lblTotalTeachers.Text = stats.totalTeachers != null
            ? ((int)stats.totalTeachers).ToString("N0")
            : "0";

        lblFeesCollected.Text = stats.feesCollectedInLakhs != null
            ? ((decimal)stats.feesCollectedInLakhs).ToString("0.##")
            : "0";

        lblUpcomingEvents.Text = stats.upcomingEvents != null
            ? stats.upcomingEvents.ToString()
            : "0";
    }
}
