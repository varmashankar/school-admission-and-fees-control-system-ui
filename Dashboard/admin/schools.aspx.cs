using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_schools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            Response.Redirect("~/login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
        {
            RegisterAsyncTask(new PageAsyncTask(LoadSchools));
        }
    }

    private async System.Threading.Tasks.Task LoadSchools()
    {
        try
        {
            var filter = new { };

            var res = await ApiHelper.PostAsync("api/School/getSchoolList", filter, HttpContext.Current);
            if (res == null)
            {
                gvSchools.DataSource = new List<object>();
                gvSchools.DataBind();
                lblRecordCount.Text = "0 records";
                return;
            }

            if (res.response_code != "200")
            {
                gvSchools.DataSource = new List<object>();
                gvSchools.DataBind();
                lblRecordCount.Text = "0 records";
                return;
            }

            var json = JsonConvert.SerializeObject(res.obj);
            var rawList = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(json) ?? new List<Dictionary<string, object>>();

            // GridView binds reliably to DataTable columns
            var dt = new System.Data.DataTable();
            dt.Columns.Add("id");
            dt.Columns.Add("school_name");
            dt.Columns.Add("code");
            dt.Columns.Add("phone");
            dt.Columns.Add("email");
            dt.Columns.Add("address");
            dt.Columns.Add("logo_path");
            dt.Columns.Add("status", typeof(bool));

            foreach (var x in rawList)
            {
                object v;
                var r = dt.NewRow();

                r["id"] = x.TryGetValue("id", out v) ? v : (x.TryGetValue("Id", out v) ? v : null);
                r["school_name"] = x.TryGetValue("school_name", out v) ? v : (x.TryGetValue("schoolName", out v) ? v : (x.TryGetValue("SchoolName", out v) ? v : null));
                r["code"] = x.TryGetValue("code", out v) ? v : (x.TryGetValue("Code", out v) ? v : null);
                r["phone"] = x.TryGetValue("phone", out v) ? v : (x.TryGetValue("Phone", out v) ? v : null);
                r["email"] = x.TryGetValue("email", out v) ? v : (x.TryGetValue("Email", out v) ? v : null);
                r["address"] = x.TryGetValue("address", out v) ? v : (x.TryGetValue("Address", out v) ? v : null);
                r["logo_path"] = x.TryGetValue("logo_path", out v) ? v : (x.TryGetValue("logoPath", out v) ? v : (x.TryGetValue("LogoPath", out v) ? v : null));

                // Handle status as boolean
                object statusVal = null;
                if (x.TryGetValue("status", out v)) statusVal = v;
                else if (x.TryGetValue("Status", out v)) statusVal = v;

                bool statusBool = false;
                if (statusVal != null)
                {
                    if (statusVal is bool) statusBool = (bool)statusVal;
                    else if (statusVal is long) statusBool = ((long)statusVal) == 1;
                    else if (statusVal is int) statusBool = ((int)statusVal) == 1;
                    else bool.TryParse(statusVal.ToString(), out statusBool);
                }
                r["status"] = statusBool;

                dt.Rows.Add(r);
            }

            gvSchools.DataSource = dt;
            gvSchools.DataBind();

            lblRecordCount.Text = dt.Rows.Count + " record" + (dt.Rows.Count != 1 ? "s" : "");
        }
        catch (Exception ex)
        {
            lblRecordCount.Text = "Error loading data";
            lblInfo.Text = "Error: " + ex.Message;
            lblInfo.Visible = true;
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadSchools));
    }

    protected void gvSchools_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditItem")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("addnewschool.aspx?id=" + id, false);
            Context.ApplicationInstance.CompleteRequest();
        }
        else if (e.CommandName == "ToggleStatus")
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                try
                {
                    string[] args = e.CommandArgument.ToString().Split('|');
                    int id = Convert.ToInt32(args[0]);
                    bool currentStatus = Convert.ToBoolean(args[1]);
                    bool newStatus = !currentStatus;

                    var payload = new { id = id, status = newStatus };
                    var apiRes = await ApiHelper.PostAsync("api/School/changeSchoolStatus", payload, HttpContext.Current);

                    if (apiRes != null && apiRes.response_code == "200")
                    {
                        string msg = "School status updated successfully.".Replace("'", "\\'");
                        ScriptManager.RegisterStartupScript(this, GetType(), "statusUpdated",
                            "Swal.fire({icon:'success',title:'SUCCESS',text:'" + msg + "',confirmButtonColor:'#6366f1'}).then(function(){ window.location = 'schools.aspx'; });", true);
                    }
                    else
                    {
                        string msg = (apiRes != null && apiRes.obj != null) ? apiRes.obj.ToString() : "Failed to update status.";
                        msg = msg.Replace("'", "\\'");
                        ScriptManager.RegisterStartupScript(this, GetType(), "statusError",
                            "Swal.fire('ERROR','" + msg + "','error');", true);
                    }
                }
                catch (Exception ex)
                {
                    string msg = ex.Message.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "Swal.fire('ERROR','" + msg + "','error');", true);
                }
            }));
        }
        else if (e.CommandName == "DeleteItem")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            string confirmScript = "Swal.fire({ title: 'Confirm Delete', text: 'Are you sure you want to delete this school?', icon: 'warning', showCancelButton: true, confirmButtonColor: '#dc2626', cancelButtonColor: '#6b7280', confirmButtonText: 'Yes, delete it!' }).then((result)=>{ if(result.isConfirmed){ __doPostBack('" + gvSchools.UniqueID + "','DeleteConfirmed|" + id + "'); } });";
            ScriptManager.RegisterStartupScript(this, GetType(), "confirmDelete", confirmScript, true);
        }
        else if (e.CommandName.StartsWith("DeleteConfirmed"))
        {
            // This is handled in Page_LoadComplete
        }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        string eventArg = Request["__EVENTARGUMENT"];
        if (!string.IsNullOrEmpty(eventArg) && eventArg.StartsWith("DeleteConfirmed|"))
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                int id = Convert.ToInt32(eventArg.Split(new char[] { '|' })[1]);
                try
                {
                    var payload = new { id = id };
                    var apiRes = await ApiHelper.PostAsync("api/School/deleteSchool", payload, HttpContext.Current);
                    if (apiRes != null && apiRes.response_code == "200")
                    {
                        string script = "Swal.fire({icon:'success',title:'Deleted',text:'School deleted successfully.',confirmButtonColor:'#6366f1'}).then(function(){ window.location = 'schools.aspx'; });";
                        ScriptManager.RegisterStartupScript(this, GetType(), "deleted", script, true);
                    }
                    else
                    {
                        string msg = (apiRes != null && apiRes.obj != null) ? apiRes.obj.ToString() : "Failed to delete school.";
                        msg = msg.Replace("'", "\\'");
                        ScriptManager.RegisterStartupScript(this, GetType(), "deleteError",
                            "Swal.fire('ERROR','" + msg + "','error');", true);
                    }
                }
                catch (Exception ex)
                {
                    string msg = ex.Message.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        "Swal.fire('ERROR','" + msg + "','error');", true);
                }
            }));
        }
    }
}
