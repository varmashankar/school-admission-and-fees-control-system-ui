using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_inquiries : System.Web.UI.Page
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
            BindStatusDropdown(ddlStatus, includeAll: true);
            RegisterAsyncTask(new PageAsyncTask(LoadInquiries));
        }
    }

    private void BindStatusDropdown(DropDownList ddl, bool includeAll)
    {
        ddl.Items.Clear();
        if (includeAll)
            ddl.Items.Add(new ListItem("-- All Status --", ""));

        ddl.Items.Add(new ListItem("New", "NEW"));
        ddl.Items.Add(new ListItem("In Progress", "IN_PROGRESS"));
        ddl.Items.Add(new ListItem("Follow Up", "FOLLOW_UP"));
        ddl.Items.Add(new ListItem("Visited", "VISITED"));
        ddl.Items.Add(new ListItem("Converted", "CONVERTED"));
        ddl.Items.Add(new ListItem("Lost", "LOST"));
    }

    private static DateTime? ParseDate(string value)
    {
        if (string.IsNullOrWhiteSpace(value)) return null;

        DateTime dt;
        if (DateTime.TryParseExact(value.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
            return dt;

        return null;
    }

    // Helper method to format status for display
    protected string FormatStatus(object statusObj)
    {
        if (statusObj == null) return "New";
        var status = statusObj.ToString().ToUpper();
        switch (status)
        {
            case "NEW": return "New";
            case "IN_PROGRESS": return "In Progress";
            case "FOLLOW_UP": return "Follow Up";
            case "VISITED": return "Visited";
            case "CONVERTED": return "Converted";
            case "LOST": return "Lost";
            default: return status;
        }
    }

    // Helper method to format follow-up date
    protected string FormatFollowUpDate(object dateObj)
    {
        if (dateObj == null || dateObj == DBNull.Value || string.IsNullOrWhiteSpace(dateObj.ToString()))
            return "<span class='text-muted'>Not set</span>";

        DateTime dt;
        if (!DateTime.TryParse(dateObj.ToString(), out dt))
            return dateObj.ToString();

        var today = DateTime.Today;
        var diff = (dt.Date - today).Days;

        if (diff == 0)
            return "<i class='bi bi-calendar-event me-1'></i>Today, " + dt.ToString("h:mm tt");
        else if (diff == 1)
            return "<i class='bi bi-calendar-plus me-1'></i>Tomorrow";
        else if (diff == -1)
            return "<i class='bi bi-calendar-x me-1'></i>Yesterday";
        else if (diff < 0)
            return "<i class='bi bi-exclamation-triangle me-1'></i>" + Math.Abs(diff) + " days overdue";
        else if (diff <= 7)
            return "<i class='bi bi-calendar-check me-1'></i>" + dt.ToString("ddd, MMM d");
        else
            return "<i class='bi bi-calendar me-1'></i>" + dt.ToString("MMM d, yyyy");
    }

    // Helper method to get CSS class for follow-up date
    protected string GetFollowUpClass(object dateObj)
    {
        if (dateObj == null || dateObj == DBNull.Value || string.IsNullOrWhiteSpace(dateObj.ToString()))
            return "";

        DateTime dt;
        if (!DateTime.TryParse(dateObj.ToString(), out dt))
            return "";

        var today = DateTime.Today;
        var diff = (dt.Date - today).Days;

        if (diff == 0) return "today";
        if (diff < 0) return "overdue";
        if (diff <= 3) return "upcoming";
        return "";
    }

    private void EnsureDataTablesInit()
    {
        var script = @"(function(){
            if (typeof initDataTable === 'function') { initDataTable('#gvInquiries'); }
            else if (window.jQuery && window.jQuery.fn && window.jQuery.fn.DataTable) { 
                if (!$.fn.DataTable.isDataTable('#gvInquiries')) {
                    $('#gvInquiries').DataTable({
                        pageLength: 10,
                        order: [[0, 'desc']],
                        language: {
                            search: '<i class=""bi bi-search""></i>',
                            searchPlaceholder: 'Search inquiries...'
                        }
                    }); 
                }
            }
            setTimeout(function() { if (typeof updateStats === 'function') updateStats(); }, 100);
        })();";

        ScriptManager.RegisterStartupScript(this, GetType(), "activateDT_inq", script, true);
    }

    private async System.Threading.Tasks.Task LoadInquiries()
    {
        try
        {
            var filter = new
            {
                inquiryNo = string.IsNullOrWhiteSpace(txtSearchInquiryNo.Text) ? null : txtSearchInquiryNo.Text.Trim(),
                status = string.IsNullOrWhiteSpace(ddlStatus.SelectedValue) ? null : ddlStatus.SelectedValue,
                fromDate = ParseDate(txtFromDate.Text),
                toDate = ParseDate(txtToDate.Text)
            };
    
            var res = await ApiHelper.PostAsync("api/Inquiries/getInquiryList", filter, HttpContext.Current);
            if (res == null)
            {
                gvInquiries.DataSource = new List<object>();
                gvInquiries.DataBind();
                lblRecordCount.Text = "0 records";
                return;
            }

            if (res.response_code != "200")
            {
                gvInquiries.DataSource = new List<object>();
                gvInquiries.DataBind();
                lblRecordCount.Text = "0 records";
                return;
            }

            var json = JsonConvert.SerializeObject(res.obj);
            var rawList = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(json) ?? new List<Dictionary<string, object>>();

            // GridView binds reliably to DataTable columns
            var dt = new System.Data.DataTable();
            dt.Columns.Add("id");
            dt.Columns.Add("inquiryNo");
            dt.Columns.Add("firstName");
            dt.Columns.Add("lastName");
            dt.Columns.Add("phone");
            dt.Columns.Add("email");
            dt.Columns.Add("status");
            dt.Columns.Add("nextFollowUpAt");

            foreach (var x in rawList)
            {
                object v;
                var r = dt.NewRow();

                r["id"] = x.TryGetValue("id", out v) ? v : (x.TryGetValue("Id", out v) ? v : null);
                r["inquiryNo"] = x.TryGetValue("inquiryNo", out v) ? v : (x.TryGetValue("InquiryNo", out v) ? v : (x.TryGetValue("inquiry_no", out v) ? v : null));
                r["firstName"] = x.TryGetValue("firstName", out v) ? v : (x.TryGetValue("FirstName", out v) ? v : (x.TryGetValue("first_name", out v) ? v : null));
                r["lastName"] = x.TryGetValue("lastName", out v) ? v : (x.TryGetValue("LastName", out v) ? v : (x.TryGetValue("last_name", out v) ? v : null));
                r["phone"] = x.TryGetValue("phone", out v) ? v : (x.TryGetValue("Phone", out v) ? v : null);
                r["email"] = x.TryGetValue("email", out v) ? v : (x.TryGetValue("Email", out v) ? v : null);
                r["status"] = x.TryGetValue("inquiryStatus", out v) ? v
                           : (x.TryGetValue("inquiry_status", out v) ? v
                           : (x.TryGetValue("status", out v) ? v
                           : (x.TryGetValue("Status", out v) ? v : null)));
                r["nextFollowUpAt"] = x.TryGetValue("nextFollowUpAt", out v) ? v : (x.TryGetValue("NextFollowUpAt", out v) ? v : (x.TryGetValue("next_follow_up_at", out v) ? v : null));

                dt.Rows.Add(r);
            }

            gvInquiries.DataSource = dt;
            gvInquiries.DataBind();

            lblRecordCount.Text = dt.Rows.Count + " record" + (dt.Rows.Count != 1 ? "s" : "");

            EnsureDataTablesInit();
        }
        catch (Exception ex)
        {
            lblRecordCount.Text = "Error loading data";
            lblInfo.Text = "Error: " + ex.Message;
            lblInfo.Visible = true;
        }
    }

    protected void gvInquiries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        var ddlRowStatus = e.Row.FindControl("ddlRowStatus") as DropDownList;
        if (ddlRowStatus == null) return;

        BindStatusDropdown(ddlRowStatus, includeAll: false);

        var currentStatusObj = DataBinder.Eval(e.Row.DataItem, "status");
        var currentStatus = currentStatusObj == null ? string.Empty : currentStatusObj.ToString();
        var item = ddlRowStatus.Items.FindByValue(currentStatus);
        if (item != null) ddlRowStatus.SelectedValue = currentStatus;
    }

    protected void gvInquiries_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.Header) return;

        gvInquiries.UseAccessibleHeader = true;
        e.Row.TableSection = TableRowSection.TableHeader;
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadInquiries));
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadInquiries));
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearchInquiryNo.Text = string.Empty;
        ddlStatus.SelectedIndex = 0;
        txtFromDate.Text = string.Empty;
        txtToDate.Text = string.Empty;

        RegisterAsyncTask(new PageAsyncTask(LoadInquiries));
    }

    protected void gvInquiries_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "ChangeStatus") return;

        RegisterAsyncTask(new PageAsyncTask(async () =>
        {
            try
            {
                long inquiryId;
                if (!long.TryParse(Convert.ToString(e.CommandArgument), out inquiryId) || inquiryId <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "badid", "Swal.fire('ERROR','Invalid inquiry selected.','error');", true);
                    return;
                }

                var row = ((Control)e.CommandSource).NamingContainer as GridViewRow;
                var ddlRowStatus = row != null ? row.FindControl("ddlRowStatus") as DropDownList : null;
                if (ddlRowStatus == null || string.IsNullOrWhiteSpace(ddlRowStatus.SelectedValue))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "badst", "Swal.fire('ERROR','Select a status first.','error');", true);
                    return;
                }

                var payload = new
                {
                    id = (long?)inquiryId,
                    status = ddlRowStatus.SelectedValue
                };

                var res = await ApiHelper.PostAsync("api/Inquiries/changeInquiryStatus", payload, HttpContext.Current);
                if (res != null && res.response_code == "200")
                {
                    string msg = (res.obj == null ? "Status updated successfully!" : res.obj.ToString()).Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "ok", "Swal.fire({icon:'success',title:'SUCCESS',text:'" + msg + "',confirmButtonColor:'#6366f1'});", true);
                    await LoadInquiries();
                }
                else
                {
                    string msg = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to update status.";
                    msg = msg.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "bad", "Swal.fire('ERROR','" + msg + "','error');", true);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "Swal.fire('ERROR','" + msg + "','error');", true);
            }
        }));
    }
}
