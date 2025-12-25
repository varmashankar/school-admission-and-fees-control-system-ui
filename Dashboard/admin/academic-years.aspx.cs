using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;


public partial class Dashboard_admin_academic_years : System.Web.UI.Page
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
        }
    }

    private async Task LoadAcademicYears()
    {
        try
        {
            ApiResponse res = await ApiHelper.PostAsync("api/AcademicYear/getAcademicYearList", new { deleted = false, status = true }, HttpContext.Current);

            if (res == null)
            {
                ShowMessage("No response from server.", "danger");
                return;
            }

            if (res.response_code != "200")
            {
                string msg = (res.obj == null) ? "Failed to load academic years." : res.obj.ToString();
                ShowMessage(msg, "danger");
                return;
            }

            var json = JsonConvert.SerializeObject(res.obj);
            var list = JsonConvert.DeserializeObject<List<dynamic>>(json);

            gvAcademicYears.DataSource = list;
            gvAcademicYears.DataBind();

            // ensure header is rendered as THEAD so DataTables can detect columns
            if (gvAcademicYears.HeaderRow != null)
                gvAcademicYears.HeaderRow.TableSection = TableRowSection.TableHeader;

            // mark table for the dynamic initializer
            gvAcademicYears.Attributes["data-datatable"] = "true";

            // trigger client-side initializer (auto-detects tables)
            // trigger client-side initializer (auto-detects tables)
            string script = @"
$(function () {
    var dt = $('#" + gvAcademicYears.ClientID + @"').DataTable();
    dt.order([[0, 'desc']]).draw();
});
";
            ScriptManager.RegisterStartupScript(this, GetType(), "forceOrder", script, true);

        }
        catch (Exception ex)
        {
            ShowMessage("Error loading academic years: " + ex.Message, "danger");
        }
    }

    protected async void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(txtYearCode.Text))
            {
                ShowMessage("Year Code is required.", "warning");
                return;
            }

            int? editId = null;
            if (!string.IsNullOrEmpty(hfEditId.Value))
            {
                int tmp;
                if (int.TryParse(hfEditId.Value, out tmp)) editId = tmp;
            }

            var payload = new
            {
                id = editId,
                year_code = txtYearCode.Text.Trim(),
                start_date = string.IsNullOrEmpty(txtStartDate.Text) ? "" : txtStartDate.Text.Trim(),
                end_date = string.IsNullOrEmpty(txtEndDate.Text) ? "" : txtEndDate.Text.Trim(),
                is_active = ddlIsActive.SelectedValue == "1"
            };

            ApiResponse res = await ApiHelper.PostAsync("api/AcademicYear/saveAcademicYear", payload, HttpContext.Current);

            if (res == null)
            {
                ShowMessage("No response from server.", "danger");
                return;
            }

            if (res.response_code == "200")
            {
                ShowMessage(editId.HasValue ? "Academic year updated successfully." : "Academic year created successfully.", "success");
                ClearForm();
                await LoadAcademicYears();
            }
            else
            {
                string msg = res.obj == null ? "Failed to save academic year." : res.obj.ToString();
                ShowMessage(msg, "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error saving academic year: " + ex.Message, "danger");
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    protected async void gvAcademicYears_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditItem")
            {
                string idStr = Convert.ToString(e.CommandArgument);
                int id;
                if (int.TryParse(idStr, out id))
                {
                    ApiResponse res = await ApiHelper.PostAsync("api/AcademicYear/getAcademicYearDetails", new { id = id }, HttpContext.Current);

                    if (res != null && res.response_code == "200" && res.obj != null)
                    {
                        var json = JsonConvert.SerializeObject(res.obj);
                        dynamic data = JsonConvert.DeserializeObject(json);

                        hfEditId.Value = data.id != null ? data.id.ToString() : "";
                        txtYearCode.Text = data.year_code ?? "";
                        txtStartDate.Text = data.start_date ?? "";
                        txtEndDate.Text = data.end_date ?? "";
                        bool isActive = false;
                        try { isActive = data.is_active == true; } catch { }
                        ddlIsActive.SelectedValue = isActive ? "1" : "0";

                        ScriptManager.RegisterStartupScript(this, GetType(), "setSaveLabel", "document.getElementById('saveLabel').innerText='Update';", true);
                    }
                    else
                    {
                        string msg = (res != null && res.obj != null) ? res.obj.ToString() : "Unable to load details.";
                        ShowMessage(msg, "danger");
                    }
                }
            }
            else if (e.CommandName == "DeleteItem")
            {
                string idStr = Convert.ToString(e.CommandArgument);
                int id;
                if (int.TryParse(idStr, out id))
                {
                    var payload = new { id = id };
                    ApiResponse res = await ApiHelper.PostAsync("api/AcademicYear/deleteAcademicYears", payload, HttpContext.Current);

                    if (res != null && res.response_code == "200")
                    {
                        ShowMessage("Academic year deleted successfully.", "success");
                        await LoadAcademicYears();
                    }
                    else
                    {
                        string msg = (res != null && res.obj != null) ? res.obj.ToString() : "Failed to delete.";
                        ShowMessage(msg, "danger");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error processing action: " + ex.Message, "danger");
        }
    }

    private void ClearForm()
    {
        hfEditId.Value = "";
        txtYearCode.Text = "";
        txtStartDate.Text = "";
        txtEndDate.Text = "";
        ddlIsActive.SelectedIndex = 0;

        ScriptManager.RegisterStartupScript(this, GetType(), "setSaveLabelClear", "document.getElementById('saveLabel').innerText='Create';", true);
    }

    private void ShowMessage(string message, string type)
    {
        if (message == null) message = "";

        message = message.Replace("\\", "\\\\")
                         .Replace("'", "\\'")
                         .Replace("\"", "\\\"")
                         .Replace("\r", "")
                         .Replace("\n", " ");

        string script = "Swal.fire('" + type.ToUpper() + "', '" + message + "', '" + type + "');";

        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }
}