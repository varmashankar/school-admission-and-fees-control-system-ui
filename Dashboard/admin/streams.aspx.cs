using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_streams : System.Web.UI.Page
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
            await LoadStreams();
        }
    }

    private async System.Threading.Tasks.Task LoadStreams()
    {
        try
        {
            var res = await ApiHelper.PostAsync("api/Streams/getStreamList", new { }, HttpContext.Current);
            if (res != null && res.obj != null)
            {
                var list = JsonConvert.DeserializeObject(res.obj.ToString());
                gvStreams.DataSource = list;
                gvStreams.DataBind();
            }
            else
            {
                gvStreams.DataSource = new List<object>();
                gvStreams.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading streams: " + ex.Message, "danger");
        }
    }

    protected async void btnStreamSave_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txtStreamName.Text.Trim();
            if (name == "")
            {
                ShowMessage("Stream name is required.", "warning");
                return;
            }

            int? id = null;
            if (!string.IsNullOrEmpty(hfStreamId.Value))
                id = Convert.ToInt32(hfStreamId.Value);

            var payload = new
            {
                id = id,
                streamName = name,
            };

            var apiRes = await ApiHelper.PostAsync("api/Streams/saveStream", payload, HttpContext.Current);

            if (apiRes != null && apiRes.response_code == "200")
            {
                string script = "Swal.fire({ title: 'Saved', text: 'Stream saved successfully', icon: 'success' }).then(function(){ window.location = 'streams.aspx'; });";
                ScriptManager.RegisterStartupScript(this, GetType(), "saved", script, true);
            }
            else
            {
                ShowMessage("Failed to save stream.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    protected void btnStreamClear_Click(object sender, EventArgs e)
    {
        hfStreamId.Value = "";
        txtStreamName.Text = "";
    }

    protected async void gvStreams_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditItem")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var res = await ApiHelper.PostAsync("api/Streams/getStreamList", new { }, HttpContext.Current);
                if (res != null && res.obj != null)
                {
                    var list = JsonConvert.DeserializeObject(res.obj.ToString()) as IEnumerable;
                    foreach (dynamic item in list)
                    {
                        if (Convert.ToInt32(item.id) == id)
                        {
                            hfStreamId.Value = Convert.ToString(item.id);
                            txtStreamName.Text = Convert.ToString(item.stream_name);
                            break;
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteItem")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                string confirm = "Swal.fire({ title: 'Confirm', text: 'Delete this stream?', icon: 'warning', showCancelButton: true }).then((result)=>{ if(result.isConfirmed){ __doPostBack('" + gvStreams.UniqueID + "','DeleteConfirmed|" + id + "'); } });";
                ScriptManager.RegisterStartupScript(this, GetType(), "confirmDelete", confirm, true);
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    protected async void Page_LoadComplete(object sender, EventArgs e)
    {
        string eventArg = Request["__EVENTARGUMENT"];
        if (!string.IsNullOrEmpty(eventArg) && eventArg.StartsWith("DeleteConfirmed|"))
        {
            int id = Convert.ToInt32(eventArg.Split(new char[] { '|' })[1]);
            try
            {
                var payload = new { id = id };
                var apiRes = await ApiHelper.PostAsync("api/Streams/deleteStream", payload, HttpContext.Current);
                if (apiRes != null && apiRes.response_code == "200")
                {
                    string script = "Swal.fire({ title: 'Deleted', text: 'Stream deleted.', icon: 'success' }).then(function(){ window.location = 'streams.aspx'; });";
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleted", script, true);
                }
                else
                {
                    ShowMessage("Failed to delete stream.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting: " + ex.Message, "danger");
            }
        }
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