using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_inquiry_followups : System.Web.UI.Page
{
    private DataTable _followUpsData;

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
            hfInquiryId.Value = Request.QueryString["inquiryId"] ?? "";
            txtFollowUpAt.Text = DateTime.Now.AddMinutes(30).ToString("yyyy-MM-ddTHH:mm");

            RegisterAsyncTask(new PageAsyncTask(LoadInquiryPicker));
            RegisterAsyncTask(new PageAsyncTask(LoadDue));
        }
    }

    #region Helper Methods for GridView

    protected string GetChannelBadgeClass(object channel)
    {
        string ch = channel != null ? channel.ToString().ToUpper() : "";
        switch (ch)
        {
            case "CALL": return "channel-badge channel-call";
            case "WHATSAPP": return "channel-badge channel-whatsapp";
            case "EMAIL": return "channel-badge channel-email";
            case "VISIT": return "channel-badge channel-visit";
            default: return "channel-badge channel-call";
        }
    }

    protected string GetChannelIcon(object channel)
    {
        string ch = channel != null ? channel.ToString().ToUpper() : "";
        switch (ch)
        {
            case "CALL": return "bi bi-telephone-fill";
            case "WHATSAPP": return "bi bi-whatsapp";
            case "EMAIL": return "bi bi-envelope-fill";
            case "VISIT": return "bi bi-house-door-fill";
            default: return "bi bi-telephone-fill";
        }
    }

    protected bool IsOverdue(object followUpAt, object isReminded)
    {
        if (Convert.ToBoolean(isReminded)) return false;
        if (followUpAt == null) return false;
        DateTime dt;
        if (DateTime.TryParse(followUpAt.ToString(), out dt))
            return dt < DateTime.Now;
        return false;
    }

    protected bool IsToday(object followUpAt)
    {
        if (followUpAt == null) return false;
        DateTime dt;
        if (DateTime.TryParse(followUpAt.ToString(), out dt))
            return dt.Date == DateTime.Today;
        return false;
    }

    protected string GetTimeDisplayClass(object followUpAt, object isReminded)
    {
        if (IsOverdue(followUpAt, isReminded))
            return "time-display overdue";
        return "time-display";
    }

    protected string GetStatusBadgeClass(object followUpAt, object isReminded)
    {
        if (Convert.ToBoolean(isReminded)) return "status-badge status-done";
        if (IsOverdue(followUpAt, isReminded)) return "status-badge status-overdue";
        return "status-badge status-pending";
    }

    protected string GetStatusIcon(object followUpAt, object isReminded)
    {
        if (Convert.ToBoolean(isReminded)) return "bi bi-check-circle-fill";
        if (IsOverdue(followUpAt, isReminded)) return "bi bi-exclamation-circle-fill";
        return "bi bi-hourglass-split";
    }

    protected string GetStatusText(object followUpAt, object isReminded)
    {
        if (Convert.ToBoolean(isReminded)) return "Done";
        if (IsOverdue(followUpAt, isReminded)) return "Overdue";
        return "Pending";
    }

    protected string FormatDate(object followUpAt)
    {
        if (followUpAt == null) return "-";
        DateTime dt;
        if (DateTime.TryParse(followUpAt.ToString(), out dt))
            return dt.ToString("dd MMM yyyy");
        return followUpAt.ToString();
    }

    protected string FormatTime(object followUpAt)
    {
        if (followUpAt == null) return "";
        DateTime dt;
        if (DateTime.TryParse(followUpAt.ToString(), out dt))
            return dt.ToString("hh:mm tt");
        return "";
    }

    protected string TruncateText(object text, int maxLength)
    {
        if (text == null) return "-";
        string str = text.ToString();
        if (string.IsNullOrWhiteSpace(str)) return "-";
        if (str.Length <= maxLength) return str;
        return str.Substring(0, maxLength) + "...";
    }

    protected void gvDue_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            var followUpAt = DataBinder.Eval(e.Row.DataItem, "followUpAt");
            var isReminded = DataBinder.Eval(e.Row.DataItem, "isReminded");

            if (IsOverdue(followUpAt, isReminded))
                e.Row.CssClass = "row-overdue";
            else if (IsToday(followUpAt) && !Convert.ToBoolean(isReminded))
                e.Row.CssClass = "row-today";
        }
    }

    #endregion

    #region Data Loading

    private async System.Threading.Tasks.Task LoadInquiryPicker()
    {
        ddlInquiry.Items.Clear();
        ddlInquiry.Items.Add(new ListItem("-- Select Inquiry --", ""));

        try
        {
            var res = await ApiHelper.PostAsync("api/Inquiries/getInquiryList", new { }, HttpContext.Current);
            if (res == null || res.response_code != "200" || res.obj == null)
                return;

            var json = JsonConvert.SerializeObject(res.obj);
            var list = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(json) ?? new List<Dictionary<string, object>>();
            list.Reverse();

            foreach (var x in list)
            {
                object idObj;
                if (!x.TryGetValue("id", out idObj) && !x.TryGetValue("Id", out idObj))
                    continue;

                var idStr = Convert.ToString(idObj);
                if (string.IsNullOrWhiteSpace(idStr)) continue;

                object noObj, fnObj, lnObj;
                var inquiryNo = (x.TryGetValue("inquiryNo", out noObj) ? Convert.ToString(noObj)
                               : (x.TryGetValue("inquiry_no", out noObj) ? Convert.ToString(noObj) : null)) ?? string.Empty;
                var firstName = (x.TryGetValue("firstName", out fnObj) ? Convert.ToString(fnObj)
                               : (x.TryGetValue("first_name", out fnObj) ? Convert.ToString(fnObj) : null)) ?? string.Empty;
                var lastName = (x.TryGetValue("lastName", out lnObj) ? Convert.ToString(lnObj)
                              : (x.TryGetValue("last_name", out lnObj) ? Convert.ToString(lnObj) : null)) ?? string.Empty;

                var text = string.IsNullOrWhiteSpace(inquiryNo)
                    ? (idStr + " - " + (firstName + " " + lastName).Trim())
                    : (inquiryNo + " - " + (firstName + " " + lastName).Trim());

                ddlInquiry.Items.Add(new ListItem(text.Trim(' ', '-'), idStr));
            }

            long inquiryId;
            if (long.TryParse(hfInquiryId.Value, out inquiryId) && inquiryId > 0)
            {
                var item = ddlInquiry.Items.FindByValue(inquiryId.ToString());
                if (item != null) ddlInquiry.SelectedValue = inquiryId.ToString();
            }

            //UpdateSelectedInquiryBadge();
        }
        catch
        {
            //UpdateSelectedInquiryBadge();
        }
    }

    private async System.Threading.Tasks.Task LoadDue()
    {
        try
        {
            var payload = new { toDate = DateTime.Now.AddYears(1) }; // Get all upcoming too

            var res = await ApiHelper.PostAsync("api/Inquiries/getDueFollowUps", payload, HttpContext.Current);
            if (res == null || res.response_code != "200")
            {
                gvDue.DataSource = new List<object>();
                gvDue.DataBind();
                UpdateStats(new DataTable());
                return;
            }

            var json = JsonConvert.SerializeObject(res.obj);
            var rawList = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(json) ?? new List<Dictionary<string, object>>();

            // Filter by selected inquiry
            var selectedInquiryId = GetSelectedInquiryId();
            if (selectedInquiryId.HasValue)
            {
                rawList = rawList.FindAll(x =>
                {
                    object v;
                    if (x.TryGetValue("inquiryId", out v) || x.TryGetValue("inquiry_id", out v) || x.TryGetValue("InquiryId", out v))
                    {
                        long id;
                        return long.TryParse(Convert.ToString(v), out id) && id == selectedInquiryId.Value;
                    }
                    return false;
                });
            }

            var dt = BuildDataTable(rawList);
            _followUpsData = dt;

            // Apply filters
            var filteredDt = ApplyFilters(dt);

            gvDue.DataSource = filteredDt;
            gvDue.DataBind();
            UpdateStats(dt); // Stats from unfiltered data
        }
        catch (Exception ex)
        {
            lblInfo.Text = "Error: " + ex.Message;
        }
    }

    private DataTable BuildDataTable(List<Dictionary<string, object>> rawList)
    {
        var dt = new DataTable();
        dt.Columns.Add("id");
        dt.Columns.Add("inquiryId");
        dt.Columns.Add("followUpAt");
        dt.Columns.Add("channel");
        dt.Columns.Add("remarks");
        dt.Columns.Add("isReminded", typeof(bool));

        foreach (var x in rawList)
        {
            object v;
            var r = dt.NewRow();
            r["id"] = x.TryGetValue("id", out v) ? v : (x.TryGetValue("Id", out v) ? v : null);
            r["inquiryId"] = x.TryGetValue("inquiryId", out v) ? v : (x.TryGetValue("InquiryId", out v) ? v : (x.TryGetValue("inquiry_id", out v) ? v : null));
            r["followUpAt"] = x.TryGetValue("followUpAt", out v) ? v : (x.TryGetValue("FollowUpAt", out v) ? v : (x.TryGetValue("follow_up_at", out v) ? v : null));
            r["channel"] = x.TryGetValue("channel", out v) ? v : (x.TryGetValue("Channel", out v) ? v : null);
            r["remarks"] = x.TryGetValue("remarks", out v) ? v : (x.TryGetValue("Remarks", out v) ? v : null);

            var reminded = x.TryGetValue("isReminded", out v) ? v : (x.TryGetValue("IsReminded", out v) ? v : (x.TryGetValue("is_reminded", out v) ? v : false));
            r["isReminded"] = Convert.ToBoolean(reminded);

            dt.Rows.Add(r);
        }

        return dt;
    }

    private DataTable ApplyFilters(DataTable dt)
    {
        var rows = dt.AsEnumerable();

        // Status filter
        string statusFilter = ddlStatusFilter.SelectedValue;
        if (statusFilter == "PENDING")
            rows = rows.Where(r => !r.Field<bool>("isReminded"));
        else if (statusFilter == "COMPLETED")
            rows = rows.Where(r => r.Field<bool>("isReminded"));

        // Date range filter
        DateTime fromDate, toDate;
        if (DateTime.TryParse(txtFromDate.Text, out fromDate))
        {
            rows = rows.Where(r =>
            {
                DateTime dt2;
                object followUpAtVal = r["followUpAt"];
                string followUpAtStr = followUpAtVal != null ? followUpAtVal.ToString() : "";
                return DateTime.TryParse(followUpAtStr, out dt2) && dt2.Date >= fromDate.Date;
            });
        }
        if (DateTime.TryParse(txtToDate.Text, out toDate))
        {
            rows = rows.Where(r =>
            {
                DateTime dt2;
                object followUpAtVal = r["followUpAt"];
                string followUpAtStr = followUpAtVal != null ? followUpAtVal.ToString() : "";
                return DateTime.TryParse(followUpAtStr, out dt2) && dt2.Date <= toDate.Date;
            });
        }

        if (!rows.Any())
            return dt.Clone();

        return rows.CopyToDataTable();
    }

    private void UpdateStats(DataTable dt)
    {
        int pending = 0, overdue = 0, today = 0, completed = 0;

        foreach (DataRow row in dt.Rows)
        {
            bool isReminded = Convert.ToBoolean(row["isReminded"]);
            DateTime followUpAt;
            object followUpAtVal = row["followUpAt"];
            string followUpAtStr = followUpAtVal != null ? followUpAtVal.ToString() : "";
            DateTime.TryParse(followUpAtStr, out followUpAt);

            if (isReminded)
                completed++;
            else
            {
                pending++;
                if (followUpAt < DateTime.Now)
                    overdue++;
                if (followUpAt.Date == DateTime.Today)
                    today++;
            }
        }

        litPendingCount.Text = pending.ToString();
        litOverdueCount.Text = overdue.ToString();
        litTodayCount.Text = today.ToString();
        litCompletedCount.Text = completed.ToString();
    }

    #endregion

    #region Event Handlers

    private static DateTime? ParseDateTime(string value)
    {
        if (string.IsNullOrWhiteSpace(value)) return null;
        DateTime dt;
        if (DateTime.TryParseExact(value.Trim(), "yyyy-MM-dd'T'HH:mm", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
            return dt;
        if (DateTime.TryParse(value, out dt))
            return dt;
        return null;
    }

    private long? GetSelectedInquiryId()
    {
        long id;
        if (long.TryParse(hfInquiryId.Value, out id) && id > 0) return id;
        if (ddlInquiry != null && long.TryParse(ddlInquiry.SelectedValue, out id) && id > 0) return id;
        return null;
    }

    //private void UpdateSelectedInquiryBadge()
    //{
    //    var selected = GetSelectedInquiryId();
    //    if (selected.HasValue)
    //        lblSelectedInquiry.Text = "<i class='bi bi-person-fill'></i> Inquiry #" + selected.Value;
    //    else
    //        lblSelectedInquiry.Text = "<i class='bi bi-info-circle'></i> Select an inquiry";
    //}

    protected void btnPreset30_Click(object sender, EventArgs e)
    {
        txtFollowUpAt.Text = DateTime.Now.AddMinutes(30).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnPreset1h_Click(object sender, EventArgs e)
    {
        txtFollowUpAt.Text = DateTime.Now.AddHours(1).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnPreset2h_Click(object sender, EventArgs e)
    {
        txtFollowUpAt.Text = DateTime.Now.AddHours(2).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnPresetTomorrow_Click(object sender, EventArgs e)
    {
        txtFollowUpAt.Text = DateTime.Today.AddDays(1).AddHours(10).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnPresetNextWeek_Click(object sender, EventArgs e)
    {
        txtFollowUpAt.Text = DateTime.Today.AddDays(7).AddHours(10).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadDue));
    }

    protected void ddlInquiry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //UpdateSelectedInquiryBadge();
        RegisterAsyncTask(new PageAsyncTask(LoadDue));
    }

    protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadDue));
    }

    protected void txtDateFilter_Changed(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(LoadDue));
    }

    protected void btnClearFilters_Click(object sender, EventArgs e)
    {
        ddlStatusFilter.SelectedValue = "PENDING";
        txtFromDate.Text = "";
        txtToDate.Text = "";
        RegisterAsyncTask(new PageAsyncTask(LoadDue));
    }

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        hfEditFollowUpId.Value = "";
        litFormTitle.Text = "Add Follow-up";
        btnCancelEdit.Visible = false;
        txtRemarks.Text = "";
        txtFollowUpAt.Text = DateTime.Now.AddMinutes(30).ToString("yyyy-MM-ddTHH:mm");
    }

    protected void btnSaveFollowUp_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(async () =>
        {
            try
            {
                var inquiryIdToSave = GetSelectedInquiryId();
                if (!inquiryIdToSave.HasValue)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "bad", "Swal.fire('ERROR','Select an inquiry first.','error');", true);
                    return;
                }

                var dtVal = ParseDateTime(txtFollowUpAt.Text);
                if (!dtVal.HasValue)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "bad2", "Swal.fire('ERROR','Invalid Follow Up At.','error');", true);
                    return;
                }

                long? editId = null;
                long tempId;
                if (long.TryParse(hfEditFollowUpId.Value, out tempId) && tempId > 0)
                    editId = tempId;

                var payload = new
                {
                    id = editId,
                    inquiryId = inquiryIdToSave.Value,
                    followUpAt = dtVal.Value,
                    channel = ddlChannel.SelectedValue,
                    remarks = txtRemarks.Text,
                    isReminded = false,
                    remindedAt = (DateTime?)null
                };

                var res = await ApiHelper.PostAsync("api/Inquiries/saveInquiryFollowUp", payload, HttpContext.Current);
                if (res != null && res.response_code == "200")
                {
                    txtRemarks.Text = "";
                    hfEditFollowUpId.Value = "";
                    litFormTitle.Text = "Add Follow-up";
                    btnCancelEdit.Visible = false;
                    txtFollowUpAt.Text = DateTime.Now.AddMinutes(30).ToString("yyyy-MM-ddTHH:mm");

                    string msg = editId.HasValue ? "Follow-up updated." : "Follow-up saved.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ok", "Swal.fire('SUCCESS','" + msg + "','success');", true);
                    await LoadDue();
                    return;
                }

                string err = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to save follow-up.";
                ScriptManager.RegisterStartupScript(this, GetType(), "bad3", "Swal.fire('ERROR','" + err.Replace("'", "\\'") + "','error');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "Swal.fire('ERROR','" + ex.Message.Replace("'", "\\'") + "','error');", true);
            }
        }));
    }

    protected void gvDue_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MarkReminded")
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                try
                {
                    long followUpId;
                    if (!long.TryParse(Convert.ToString(e.CommandArgument), out followUpId))
                        return;

                    var payload = new
                    {
                        followUpId = (long?)followUpId,
                        remindedAt = DateTime.UtcNow,
                        userId = (long?)null,
                        roleId = (long?)null
                    };

                    var res = await ApiHelper.PostAsync("api/Inquiries/markFollowUpReminded", payload, HttpContext.Current);
                    if (res != null && res.response_code == "200")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ok2", "Swal.fire('SUCCESS','Marked as completed.','success');", true);
                        await LoadDue();
                        return;
                    }

                    string err = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to mark reminded.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "bad4", "Swal.fire('ERROR','" + err.Replace("'", "\\'") + "','error');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err2", "Swal.fire('ERROR','" + ex.Message.Replace("'", "\\'") + "','error');", true);
                }
            }));
        }
        else if (e.CommandName == "EditFollowUp")
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            if (args.Length >= 5)
            {
                hfEditFollowUpId.Value = args[0];
                ddlInquiry.SelectedValue = args[1];
                hfInquiryId.Value = args[1];

                DateTime dt;
                if (DateTime.TryParse(args[2], out dt))
                    txtFollowUpAt.Text = dt.ToString("yyyy-MM-ddTHH:mm");

                ddlChannel.SelectedValue = args[3];
                txtRemarks.Text = string.Join(",", args.Skip(4)); // Remarks might contain commas

                litFormTitle.Text = "Edit Follow-up";
                btnCancelEdit.Visible = true;
                //UpdateSelectedInquiryBadge();
            }
        }
        else if (e.CommandName == "DeleteFollowUp")
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                try
                {
                    long followUpId;
                    if (!long.TryParse(Convert.ToString(e.CommandArgument), out followUpId))
                        return;

                    var payload = new { id = followUpId };
                    var res = await ApiHelper.PostAsync("api/Inquiries/deleteInquiryFollowUp", payload, HttpContext.Current);

                    if (res != null && res.response_code == "200")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ok3", "Swal.fire('SUCCESS','Follow-up deleted.','success');", true);
                        await LoadDue();
                        return;
                    }

                    string err = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to delete.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "bad5", "Swal.fire('ERROR','" + err.Replace("'", "\\'") + "','error');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "err3", "Swal.fire('ERROR','" + ex.Message.Replace("'", "\\'") + "','error');", true);
                }
            }));
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        RegisterAsyncTask(new PageAsyncTask(async () =>
        {
            await LoadDue();

            if (gvDue.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "nodata", "Swal.fire('Info','No data to export.','info');", true);
                return;
            }

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=FollowUps_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                // Remove action buttons for export
                gvDue.Columns[gvDue.Columns.Count - 1].Visible = false;
                gvDue.RenderControl(hw);
                gvDue.Columns[gvDue.Columns.Count - 1].Visible = true;

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }));
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        // Required for Export functionality
    }

    #endregion
}
