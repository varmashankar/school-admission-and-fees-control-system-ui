using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

public partial class Dashboard_admin_teachers : AuthenticatedPage
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            await LoadTeacherDashboardStats();
            await LoadTeachers();
        }
    }

    protected async Task LoadTeacherDashboardStats()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Teacher/getTeacherDashboardStats", new { }, HttpContext.Current);

            if (res == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            if (res.response_code != "200")
            {
                ShowAlert(
                    res.obj == null ? "Failed to load teacher dashboard statistics." : res.obj.ToString(),
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

    private void BindDashboardStats(dynamic stats)
    {
        if (stats == null)
        {
            ShowAlert("Invalid dashboard data.", "error");
            return;
        }

        litTotalTeachers.Text = stats.totalTeachers.ToString();
        litNewHires.Text = stats.newHiresThisMonth.ToString();
        litActiveCourses.Text = stats.activeCourses.ToString();

    }

    private async Task LoadTeachers()
    {
        try
        {
            string apiUrl = "api/Teacher/getTeacherList";

            ApiResponse res = await ApiHelper.PostAsync(apiUrl, new { }, HttpContext.Current);

            if (res == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            if (res.response_code != "200")
            {
                string msg = res.obj == null ? "Failed to load teachers." : res.obj.ToString();
                ShowAlert(msg, "error");
                return;
            }

            var json = JsonConvert.SerializeObject(res.obj);
            var teachers = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (teachers == null)
            {
                ShowAlert("Unable to read teacher data.", "error");
                return;
            }

            rptTeachers.DataSource = teachers;
            rptTeachers.DataBind();

            // Activate DataTable after rows are rendered
            string script = @"(function(){
              if (typeof initDataTable === 'function') { initDataTable('#tblTeachers'); }
              else if (window.jQuery && window.jQuery.fn && window.jQuery.fn.DataTable) { $('#tblTeachers').DataTable(); }
            })();";
            ScriptManager.RegisterStartupScript(this, GetType(), "activateDT", script, true);
        }
        catch (JsonException jsonEx)
        {
            ShowAlert("JSON parsing error: " + jsonEx.Message, "error");
        }
        catch (HttpRequestException httpEx)
        {
            ShowAlert("Network/API error: " + httpEx.Message, "error");
        }
        catch (Exception ex)
        {
            ShowAlert("Unexpected error: " + ex.Message, "error");
        }
    }
}