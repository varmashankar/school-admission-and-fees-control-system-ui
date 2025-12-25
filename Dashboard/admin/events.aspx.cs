using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_events : System.Web.UI.Page
{
    //private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set default date for event start date on initial load
            txtEventStartDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            LoadEvents();
        }
    }

    private void LoadEvents()
    {
        //eventList.Controls.Clear(); // Clear existing events before loading new ones
        //DataTable dtEvents = new DataTable();

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    // Fetch events, ordering by start date. You might want to filter upcoming vs. past.
        //    string query = "SELECT EventID, Title, Description, StartDate, EndDate, StartTime, EndTime, Location, Audience FROM Events ORDER BY StartDate ASC, StartTime ASC";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        con.Open();
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        da.Fill(dtEvents);
        //    }
        //}

        //if (dtEvents.Rows.Count == 0)
        //{
        //    lblNoEvents.Visible = true;
        //}
        //else
        //{
        //    lblNoEvents.Visible = false;
        //    foreach (DataRow row in dtEvents.Rows)
        //    {
        //        string eventId = row["EventID"].ToString();
        //        string title = row["Title"].ToString();
        //        string description = row["Description"].ToString();
        //        DateTime startDate = Convert.ToDateTime(row["StartDate"]);
        //        DateTime? endDate = row["EndDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["EndDate"]);
        //        TimeSpan? startTime = row["StartTime"] == DBNull.Value ? (TimeSpan?)null : (TimeSpan)row["StartTime"];
        //        TimeSpan? endTime = row["EndTime"] == DBNull.Value ? (TimeSpan?)null : (TimeSpan)row["EndTime"];
        //        string location = row["Location"].ToString();

        //        HtmlGenericControl eventItem = new HtmlGenericControl("div");
        //        string eventStatusClass = GetEventStatusClass(startDate, endDate);
        //        eventItem.Attributes["class"] = $"event-item {eventStatusClass}";
        //        eventItem.Attributes["data-event-id"] = eventId;

        //        StringBuilder sb = new StringBuilder();
        //        sb.Append($"<i class='fas fa-calendar-check event-icon'></i>"); // Icon can be changed based on status
        //        sb.Append("<div class='event-content'>");
        //        sb.Append($"<h5>{Server.HtmlEncode(title)}</h5>");
        //        sb.Append($"<p class='mb-0'><strong>Date:</strong> {startDate.ToString("MMM dd, yyyy")}");
        //        if (endDate.HasValue && endDate.Value != startDate)
        //        {
        //            sb.Append($" - {endDate.Value.ToString("MMM dd, yyyy")}");
        //        }
        //        if (startTime.HasValue)
        //        {
        //            sb.Append($" | <strong>Time:</strong> {startTime.Value.ToString(@"hh\:mm tt")}");
        //            if (endTime.HasValue)
        //            {
        //                sb.Append($" - {endTime.Value.ToString(@"hh\:mm tt")}");
        //            }
        //        }
        //        sb.Append("</p>");
        //        if (!string.IsNullOrEmpty(location))
        //        {
        //            sb.Append($"<small class='text-muted'>{Server.HtmlEncode(location)}</small>");
        //        }
        //        sb.Append("</div>");
        //        sb.Append("<div class='event-actions'>");
        //        // Client-side call to openEditEventModal which triggers a server postback
        //        sb.Append($"<button type='button' class='btn btn-sm btn-warning me-1' title='Edit Event' onclick=\"openEditEventModal('{eventId}'); return false;\"><i class='fas fa-edit'></i></button>");
        //        // LinkButton for Delete action, triggering server-side postback via Command event
        //        sb.Append($"<asp:LinkButton ID='lnkDeleteEvent{eventId}' runat='server' CssClass='btn btn-sm btn-danger' ToolTip='Delete Event' CommandName='DeleteEvent' CommandArgument='{eventId}' OnCommand='HandleEventAction' OnClientClick=\"return confirm('Are you sure you want to delete this event?');\"><i class='fas fa-trash-alt'></i></asp:LinkButton>");
        //        sb.Append("</div>");

        //        eventItem.InnerHtml = sb.ToString();
        //        eventList.Controls.Add(eventItem);
        //    }
        //}
        //upEvents.Update(); // Update the UpdatePanel
    }

    private string GetEventStatusClass(DateTime startDate, DateTime? endDate)
    {
        DateTime today = DateTime.Today;
        if (startDate > today)
        {
            return "event-upcoming";
        }
        else if (endDate.HasValue && endDate.Value < today)
        {
            return "event-past";
        }
        else
        {
            return "event-current"; // Event is currently active or happening today
        }
    }


    protected void btnSaveEvent_Click(object sender, EventArgs e)
    {
        //string title = txtEventTitle.Text;
        //string description = txtEventDescription.Text;
        //DateTime startDate = Convert.ToDateTime(txtEventStartDate.Text);
        //DateTime? endDate = null;
        //if (!string.IsNullOrEmpty(txtEventEndDate.Text))
        //{
        //    endDate = Convert.ToDateTime(txtEventEndDate.Text);
        //}
        //TimeSpan? startTime = null;
        //if (!string.IsNullOrEmpty(txtEventStartTime.Text))
        //{
        //    startTime = TimeSpan.Parse(txtEventStartTime.Text);
        //}
        //TimeSpan? endTime = null;
        //if (!string.IsNullOrEmpty(txtEventEndTime.Text))
        //{
        //    endTime = TimeSpan.Parse(txtEventEndTime.Text);
        //}
        //string location = txtEventLocation.Text;
        //string audience = ddlEventAudience.SelectedValue;

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    string query = @"INSERT INTO Events (Title, Description, StartDate, EndDate, StartTime, EndTime, Location, Audience)
        //                     VALUES (@Title, @Description, @StartDate, @EndDate, @StartTime, @EndTime, @Location, @Audience)";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@Title", title);
        //        cmd.Parameters.AddWithValue("@Description", description);
        //        cmd.Parameters.AddWithValue("@StartDate", startDate);
        //        cmd.Parameters.AddWithValue("@EndDate", (object)endDate ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@StartTime", (object)startTime ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@EndTime", (object)endTime ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@Location", location);
        //        cmd.Parameters.AddWithValue("@Audience", audience);
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //}

        //// Clear form fields
        //txtEventTitle.Text = "";
        //txtEventDescription.Text = "";
        //txtEventStartDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Reset to today
        //txtEventEndDate.Text = "";
        //txtEventStartTime.Text = "";
        //txtEventEndTime.Text = "";
        //txtEventLocation.Text = "";
        //ddlEventAudience.SelectedValue = "All";

        //LoadEvents(); // Reload events list
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Event saved successfully!');", true);
        //// Hide the modal
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideAddModal", "var modal = bootstrap.Modal.getInstance(document.getElementById('addEventModal')); if(modal) modal.hide();", true);
    }

    protected void btnLoadEventForEdit_Click(object sender, EventArgs e)
    {
        //string eventId = hfEditEventId.Value; // Get event ID from hidden field

        //if (!string.IsNullOrEmpty(eventId))
        //{
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string query = "SELECT Title, Description, StartDate, EndDate, StartTime, EndTime, Location, Audience FROM Events WHERE EventID = @EventID";
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddWithValue("@EventID", eventId);
        //            con.Open();
        //            using (SqlDataReader reader = cmd.ExecuteReader())
        //            {
        //                if (reader.Read())
        //                {
        //                    // Populate edit modal fields
        //                    txtEditEventTitle.Text = reader["Title"].ToString();
        //                    txtEditEventDescription.Text = reader["Description"].ToString();
        //                    txtEditEventStartDate.Text = Convert.ToDateTime(reader["StartDate"]).ToString("yyyy-MM-dd");
        //                    txtEditEventEndDate.Text = reader["EndDate"] == DBNull.Value ? "" : Convert.ToDateTime(reader["EndDate"]).ToString("yyyy-MM-dd");
        //                    txtEditEventStartTime.Text = reader["StartTime"] == DBNull.Value ? "" : ((TimeSpan)reader["StartTime"]).ToString(@"hh\:mm");
        //                    txtEditEventEndTime.Text = reader["EndTime"] == DBNull.Value ? "" : ((TimeSpan)reader["EndTime"]).ToString(@"hh\:mm");
        //                    txtEditEventLocation.Text = reader["Location"].ToString();
        //                    ddlEditEventAudience.SelectedValue = reader["Audience"].ToString();

        //                    // Show the edit modal using JavaScript
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showEditModal", "var modal = new bootstrap.Modal(document.getElementById('editEventModal')); modal.show();", true);
        //                }
        //            }
        //        }
        //    }
        //}
        //upEditEvent.Update(); // Update the edit modal's UpdatePanel
    }

    protected void btnUpdateEvent_Click(object sender, EventArgs e)
    {
        //string eventId = hfEditEventId.Value; // Get ID of event being edited

        //string title = txtEditEventTitle.Text;
        //string description = txtEditEventDescription.Text;
        //DateTime startDate = Convert.ToDateTime(txtEditEventStartDate.Text);
        //DateTime? endDate = null;
        //if (!string.IsNullOrEmpty(txtEditEventEndDate.Text))
        //{
        //    endDate = Convert.ToDateTime(txtEditEventEndDate.Text);
        //}
        //TimeSpan? startTime = null;
        //if (!string.IsNullOrEmpty(txtEditEventStartTime.Text))
        //{
        //    startTime = TimeSpan.Parse(txtEditEventStartTime.Text);
        //}
        //TimeSpan? endTime = null;
        //if (!string.IsNullOrEmpty(txtEditEventEndTime.Text))
        //{
        //    endTime = TimeSpan.Parse(txtEditEventEndTime.Text);
        //}
        //string location = txtEditEventLocation.Text;
        //string audience = ddlEditEventAudience.SelectedValue;

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    string query = @"UPDATE Events SET Title = @Title, Description = @Description, StartDate = @StartDate,
        //                     EndDate = @EndDate, StartTime = @StartTime, EndTime = @EndTime, Location = @Location, Audience = @Audience
        //                     WHERE EventID = @EventID";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@Title", title);
        //        cmd.Parameters.AddWithValue("@Description", description);
        //        cmd.Parameters.AddWithValue("@StartDate", startDate);
        //        cmd.Parameters.AddWithValue("@EndDate", (object)endDate ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@StartTime", (object)startTime ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@EndTime", (object)endTime ?? DBNull.Value);
        //        cmd.Parameters.AddWithValue("@Location", location);
        //        cmd.Parameters.AddWithValue("@Audience", audience);
        //        cmd.Parameters.AddWithValue("@EventID", eventId); // Important: specify which event to update
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //}

        //LoadEvents(); // Reload events list
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Event updated successfully!');", true);
        //// Hide the modal
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideEditModal", "var modal = bootstrap.Modal.getInstance(document.getElementById('editEventModal')); if(modal) modal.hide();", true);
    }


    protected void HandleEventAction(object sender, CommandEventArgs e)
    {
        //string eventId = e.CommandArgument.ToString();

        //if (e.CommandName == "DeleteEvent")
        //{
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string query = "DELETE FROM Events WHERE EventID = @EventID";
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddWithValue("@EventID", eventId);
        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //        }
        //    }
        //    LoadEvents(); // Reload events after deletion
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Event deleted successfully!');", true);
        //}
        //// You could add other command names here like "ViewEvent", etc.
    }
}