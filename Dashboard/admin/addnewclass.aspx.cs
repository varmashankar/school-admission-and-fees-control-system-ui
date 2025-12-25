using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_addnewclass : System.Web.UI.Page
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            Response.Redirect("~/login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
        {
            await LoadAcademicYears();
            await LoadTeachers();
            await LoadRooms();
            await LoadStreams();
        }
    }

    // -----------------------------------------------------------
    // LOAD DROPDOWNS FROM API
    // -----------------------------------------------------------
    private async System.Threading.Tasks.Task LoadAcademicYears()
    {
        ddlAcademicYear.Items.Clear();
        ddlAcademicYear.Items.Add(new ListItem("-- Select Academic Year --", ""));

        try
        {
            var res = await ApiHelper.PostAsync("api/AcademicYear/getAcademicYearList", new { }, HttpContext.Current);

            dynamic obj = JsonConvert.DeserializeObject(res.obj.ToString());

            if (obj != null)
            {
                foreach (var item in obj)
                {
                    ddlAcademicYear.Items.Add(
                        new ListItem(
                            Convert.ToString(item.year_code),
                            Convert.ToString(item.id)
                        )
                    );
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading academic years: " + ex.Message, "danger");
        }
    }


    private async System.Threading.Tasks.Task LoadTeachers()
    {
        ddlClassTeacher.Items.Clear();
        ddlClassTeacher.Items.Add(new ListItem("-- Select Teacher --", ""));

        try
        {
            var res = await ApiHelper.PostAsync(
                "api/Teacher/getTeacherList",
                new { },
                HttpContext.Current
            );

            if (res == null || res.obj == null)
                return;

            // obj IS the array
            var teachers = JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(
                res.obj.ToString()
            );

            foreach (var t in teachers)
            {
                string name =
                    Convert.ToString(t["firstName"]) + " " +
                    Convert.ToString(t["lastName"]);

                ddlClassTeacher.Items.Add(
                    new ListItem(
                        name.Trim(),
                        Convert.ToString(t["id"])
                    )
                );
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading teachers: " + ex.Message, "danger");
        }
    }


    private async System.Threading.Tasks.Task LoadRooms()
    {
        ddlRoom.Items.Clear();
        ddlRoom.Items.Add(new ListItem("-- Select Room --", ""));

        try
        {
            var res = await ApiHelper.PostAsync("api/Rooms/getRoomList", new { }, HttpContext.Current);

            dynamic obj = JsonConvert.DeserializeObject(res.obj.ToString());

            if (obj != null)
            {
                foreach (var r in obj)
                {
                    ddlRoom.Items.Add(
                        new ListItem(
                            Convert.ToString(r.room_no),
                            Convert.ToString(r.id)
                        )
                    );
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading rooms: " + ex.Message, "danger");
        }
    }


    private async System.Threading.Tasks.Task LoadStreams()
    {
        ddlStream.Items.Clear();
        ddlStream.Items.Add(new ListItem("-- Select Stream --", ""));

        try
        {
            var res = await ApiHelper.PostAsync("api/Streams/getStreamList", new { }, HttpContext.Current);

            dynamic obj = JsonConvert.DeserializeObject(res.obj.ToString());

            if (obj != null)
            {
                foreach (var s in obj)
                {
                    ddlStream.Items.Add(
                        new ListItem(
                            Convert.ToString(s.stream_name),
                            Convert.ToString(s.id)
                        )
                    );
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading streams: " + ex.Message, "danger");
        }
    }


    // -----------------------------------------------------------
    // SAVE CLASS
    // -----------------------------------------------------------
    protected async void btnSaveClass_Click(object sender, EventArgs e)
    {
        try
        {
            // ---------------- VALIDATION ----------------
            if (txtClassName.Text.Trim() == "")
            {
                ShowMessage("Class Name is required.", "warning");
                return;
            }
            if (txtClassCode.Text.Trim() == "")
            {
                ShowMessage("Class Code is required.", "warning");
                return;
            }
            if (ddlAcademicYear.SelectedValue == "")
            {
                ShowMessage("Academic Year is required.", "warning");
                return;
            }

            // ---------------- PAYLOAD ----------------
            var payload = new
            {
                id = (int?)null,
                className = txtClassName.Text.Trim(),
                section = txtSection.Text.Trim(),
                classCode = txtClassCode.Text.Trim(),

                classTeacherId = ParseNullableInt(ddlClassTeacher.SelectedValue),
                roomId = ParseNullableInt(ddlRoom.SelectedValue),
                streamId = ParseNullableInt(ddlStream.SelectedValue),
                board = txtBoard.Text.Trim(),
                medium = txtMedium.Text.Trim(),

                academicYearId = Convert.ToInt32(ddlAcademicYear.SelectedValue)
            };

            System.Diagnostics.Debug.WriteLine("PAYLOAD:");
            System.Diagnostics.Debug.WriteLine(
                JsonConvert.SerializeObject(payload)
            );


            // ---------------- SAVE API ----------------
            var apiRes = await ApiHelper.PostAsync("api/Classes/saveClass", payload, HttpContext.Current);

            System.Diagnostics.Debug.WriteLine("API RESPONSE:");
            if (apiRes == null)
            {
                System.Diagnostics.Debug.WriteLine("apiRes is NULL");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("response_code: " + apiRes.response_code);
                System.Diagnostics.Debug.WriteLine("obj: " + (apiRes.obj == null ? "NULL" : apiRes.obj.ToString()));
            }

            if (apiRes != null && apiRes.response_code == "200")
            {
                string script = @"
                Swal.fire({
                    title: 'Success',
                    text: 'Class created successfully!',
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonText: 'Go to Class List',
                    cancelButtonText: 'Add Another'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location = 'classes.aspx';
                    } else {
                        window.location = 'addnewclass.aspx';
                    }
                });";

                ScriptManager.RegisterStartupScript(this, GetType(), "classSaved", script, true);
            }
            else
            {
                string msg = "Operation failed.";

                if (apiRes != null && apiRes.obj != null)
                    msg = apiRes.obj.ToString();

                ShowMessage(msg, "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }


    // -----------------------------------------------------------
    // HELPERS
    // -----------------------------------------------------------
    private int? ParseNullableInt(string v)
    {
        if (string.IsNullOrEmpty(v)) return null;
        return Convert.ToInt32(v);
    }

    private void ShowMessage(string msg, string type)
    {
        if (msg == null) msg = "";
        msg = msg.Replace("'", "\\'").Replace("\"", "\\\"");

        string icon = "info";
        if (type == "danger") icon = "error";
        if (type == "warning") icon = "warning";
        if (type == "success") icon = "success";

        string script = "Swal.fire('" + msg + "', '', '" + icon + "');";
        ScriptManager.RegisterStartupScript(this, GetType(), "msg", script, true);
    }
}