using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

public partial class Dashboard_admin_students : AuthenticatedPage
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            await LoadStudentDashboardStats();
            await LoadStudents();
        }
    }

    protected async Task LoadStudentDashboardStats()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/Students/getStudentDashboardStats", new { }, HttpContext.Current);

            if (res == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            if (res.response_code != "200")
            {
                ShowAlert(
                    res.obj == null ? "Failed to load student dashboard statistics." : res.obj.ToString(),
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
        lblTotalStudents.Text = stats.totalStudents.ToString();
        lblNewAdmissions.Text = stats.newAdmissions.ToString();
        lblAdmissionGrowth.Text = stats.admissionGrowthPercent.ToString();

        int totalToday = stats.presentToday + stats.absentToday;
        int attendancePercent = totalToday == 0
            ? 0
            : (stats.presentToday * 100) / totalToday;

        lblAttendancePercent.Text = attendancePercent.ToString();
        lblAbsentToday.Text = stats.absentToday.ToString();

        attendanceProgress.Style["width"] = attendancePercent + "%";

    }


    protected async Task LoadStudents()
    {
        try
        {
            string apiUrl = "api/Students/getStudentList";

            // Call API
            ApiResponse res = await ApiHelper.PostAsync(apiUrl, new { }, HttpContext.Current);

            if (res == null)
            {
                ShowAlert("No response from server.", "error");
                return;
            }

            if (res.response_code != "200")
            {
                string msg = (res.obj == null) ? "Failed to load students." : res.obj.ToString();
                ShowAlert(msg, "error");
                return;
            }

            // Deserialize student list
            var json = JsonConvert.SerializeObject(res.obj);
            var students = JsonConvert.DeserializeObject<List<dynamic>>(json);

            if (students == null)
            {
                ShowAlert("Unable to read student data.", "error");
                return;
            }

            rptStudents.DataSource = students;
            rptStudents.DataBind();

            // Activate DataTable after rows are rendered
            string script = @"(function(){
              if (typeof initDataTable === 'function') { initDataTable('#tblStudents'); }
              else if (window.jQuery && window.jQuery.fn && window.jQuery.fn.DataTable) { $('#tblStudents').DataTable(); }
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

    protected void btnAddStudent_Click(object sender, EventArgs e)
    {
        RedirectSafe("~/dashboard/admin/admissionform.aspx");
    }
}
