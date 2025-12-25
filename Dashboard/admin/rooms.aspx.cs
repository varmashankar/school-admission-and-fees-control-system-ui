using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_rooms : System.Web.UI.Page
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
            await LoadRooms();
        }
    }

    private async System.Threading.Tasks.Task LoadRooms()
    {
        try
        {
            var res = await ApiHelper.PostAsync("api/Rooms/getRoomList", new { }, HttpContext.Current);
            if (res != null && res.obj != null)
            {
                var list = JsonConvert.DeserializeObject(res.obj.ToString());
                gvRooms.DataSource = list;
                gvRooms.DataBind();
            }
            else
            {
                gvRooms.DataSource = new List<object>();
                gvRooms.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading rooms: " + ex.Message, "danger");
        }
    }

    protected async void btnRoomSave_Click(object sender, EventArgs e)
    {
        try
        {
            string roomNo = txtRoomNo.Text.Trim();
            string floor = txtFloor.Text.Trim();
            int? capacity = null;
            if (!string.IsNullOrEmpty(txtCapacity.Text.Trim()))
            {
                int tmp;
                if (int.TryParse(txtCapacity.Text.Trim(), out tmp))
                    capacity = tmp;
                else
                {
                    ShowMessage("Capacity must be a number.", "warning");
                    return;
                }
            }
            
            if (roomNo == "")
            {
                ShowMessage("Room number is required.", "warning");
                return;
            }

            int? id = null;
            if (!string.IsNullOrEmpty(hfRoomId.Value))
                id = Convert.ToInt32(hfRoomId.Value);

            var payload = new
            {
                id = id,
                roomNo = roomNo,
                floor = floor,
                capacity = capacity
            };

            var apiRes = await ApiHelper.PostAsync("api/Rooms/saveRoom", payload, HttpContext.Current);

            if (apiRes != null && apiRes.response_code == "200")
            {
                string msg = apiRes.obj.ToString().Replace("'", "\\'");
                string script = "Swal.fire({ title: 'Saved', text: '" + msg +
                                "', icon: 'success' }).then(function(){ window.location = 'rooms.aspx'; });";

                ScriptManager.RegisterStartupScript(this, GetType(), "saved", script, true);

            }
            else
            {
                ShowMessage("Failed to save room.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "danger");
        }
    }

    protected void btnRoomClear_Click(object sender, EventArgs e)
    {
        hfRoomId.Value = "";
        txtRoomNo.Text = "";
        txtFloor.Text = "";
        txtCapacity.Text = "";
    }

    protected async void gvRooms_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditItem")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var res = await ApiHelper.PostAsync("api/Rooms/getRoomList", new { }, HttpContext.Current);
                if (res != null && res.obj != null)
                {
                    var list = JsonConvert.DeserializeObject(res.obj.ToString()) as IEnumerable;
                    foreach (dynamic item in list)
                    {
                        if (Convert.ToInt32(item.id) == id)
                        {
                            hfRoomId.Value = Convert.ToString(item.id);
                            txtRoomNo.Text = Convert.ToString(item.room_no);
                            txtFloor.Text = Convert.ToString(item.floor);
                            txtCapacity.Text = Convert.ToString(item.capacity);
                            break;
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteItem")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                string confirm = "Swal.fire({ title: 'Confirm', text: 'Delete this room?', icon: 'warning', showCancelButton: true }).then((result)=>{ if(result.isConfirmed){ __doPostBack('" + gvRooms.UniqueID + "','DeleteConfirmed|" + id + "'); } });";
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
                var apiRes = await ApiHelper.PostAsync("api/Rooms/deleteRoom", payload, HttpContext.Current);
                if (apiRes != null && apiRes.response_code == "200")
                {
                    string script = "Swal.fire({ title: 'Deleted', text: 'Room deleted.', icon: 'success' }).then(function(){ window.location = 'rooms.aspx'; });";
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleted", script, true);
                }
                else
                {
                    ShowMessage("Failed to delete room.", "danger");
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