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

public partial class Dashboard_admin_messages : System.Web.UI.Page
{
    //private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMessages();
            UpdateUnreadMessageCount();
        }
    }

    private void LoadMessages()
    {
        //messageList.Controls.Clear();
        //DataTable dtMessages = new DataTable();

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    string query = "SELECT MessageID, Subject, Content, Sender, Recipient, Timestamp, IsRead FROM Messages WHERE Recipient = @CurrentUserID OR Recipient = 'All' ORDER BY Timestamp DESC";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        // You'll need to pass the current logged-in user's ID/Role here
        //        // For demo, let's assume 'All' and a dummy user ID if you implement user-specific messages
        //        cmd.Parameters.AddWithValue("@CurrentUserID", "AdminUser"); // Replace with actual user ID logic

        //        con.Open();
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        da.Fill(dtMessages);
        //    }
        //}

        //if (dtMessages.Rows.Count == 0)
        //{
        //    lblNoMessages.Visible = true;
        //}
        //else
        //{
        //    lblNoMessages.Visible = false;
        //    foreach (DataRow row in dtMessages.Rows)
        //    {
        //        bool isRead = Convert.ToBoolean(row["IsRead"]);
        //        string messageId = row["MessageID"].ToString();
        //        string subject = row["Subject"].ToString();
        //        string content = row["Content"].ToString();
        //        string sender = row["Sender"].ToString(); // Assume Sender is a column
        //        string recipient = row["Recipient"].ToString(); // Assume Recipient is a column
        //        DateTime timestamp = Convert.ToDateTime(row["Timestamp"]);

        //        HtmlGenericControl messageItem = new HtmlGenericControl("div");
        //        messageItem.Attributes["class"] = $"message-item {(isRead ? "message-read" : "message-unread")}";
        //        messageItem.Attributes["data-message-id"] = messageId;

        //        // Add data attributes for detail modal
        //        messageItem.Attributes["data-subject"] = Server.HtmlEncode(subject);
        //        messageItem.Attributes["data-full-content"] = Server.HtmlEncode(content);
        //        messageItem.Attributes["data-sender"] = Server.HtmlEncode(sender);
        //        messageItem.Attributes["data-recipient"] = Server.HtmlEncode(recipient);
        //        messageItem.Attributes["data-timestamp"] = timestamp.ToString("MMM dd, yyyy hh:mm tt");


        //        StringBuilder sb = new StringBuilder();
        //        sb.Append($"<i class='fas fa-bell message-icon {(isRead ? "text-muted" : "")}'></i>");
        //        sb.Append("<div class='message-content'>");
        //        sb.Append($"<h5>{Server.HtmlEncode(subject)}</h5>");
        //        sb.Append($"<p class='mb-0'>{Server.HtmlEncode(content.Length > 150 ? content.Substring(0, 150) + "..." : content)}</p>");
        //        sb.Append("</div>");
        //        sb.Append($"<span class='message-date'>{GetTimeAgo(timestamp)}</span>");

        //        messageItem.InnerHtml = sb.ToString();
        //        messageList.Controls.Add(messageItem);
        //    }
        //}
        //upMessages.Update();
    }

    private void UpdateUnreadMessageCount()
    {
        //int unreadCount = 0;
        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    // Filter by current user if messages are user-specific
        //    string query = "SELECT COUNT(*) FROM Messages WHERE IsRead = 0 AND (Recipient = @CurrentUserID OR Recipient = 'All')";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@CurrentUserID", "AdminUser"); // Replace with actual user ID logic
        //        con.Open();
        //        unreadCount = (int)cmd.ExecuteScalar();
        //    }
        //}
        //unreadMessageCount.InnerText = unreadCount.ToString();
        //unreadMessageCount.Visible = unreadCount > 0;
    }

    protected void btnMarkAllRead_Click(object sender, EventArgs e)
    {
        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    // Mark all messages for the current user/role as read
        //    string query = "UPDATE Messages SET IsRead = 1 WHERE (Recipient = @CurrentUserID OR Recipient = 'All') AND IsRead = 0";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@CurrentUserID", "AdminUser"); // Replace with actual user ID logic
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //}
        //LoadMessages(); // Reload to show all messages as read
        //UpdateUnreadMessageCount();
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('All messages marked as read.');", true);
    }

    protected void btnSendMessage_Click(object sender, EventArgs e)
    {
        //string subject = txtMessageSubject.Text;
        //string content = txtMessageContent.Text;
        //string recipient = ddlMessageRecipient.SelectedValue; // e.g., "All", "Students", "Teachers"

        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    string query = @"INSERT INTO Messages (Subject, Content, Sender, Recipient, Timestamp, IsRead)
        //                     VALUES (@Subject, @Content, @Sender, @Recipient, @Timestamp, @IsRead)";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@Subject", subject);
        //        cmd.Parameters.AddWithValue("@Content", content);
        //        cmd.Parameters.AddWithValue("@Sender", "Admin"); // Or current logged-in user
        //        cmd.Parameters.AddWithValue("@Recipient", recipient);
        //        cmd.Parameters.AddWithValue("@Timestamp", DateTime.Now);
        //        cmd.Parameters.AddWithValue("@IsRead", false); // New messages are unread by default
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //}

        //// Clear form and reload messages
        //txtMessageSubject.Text = "";
        //txtMessageContent.Text = "";
        //ddlMessageRecipient.SelectedValue = "All"; // Reset dropdown
        //LoadMessages();
        //UpdateUnreadMessageCount();

        //// Close the modal via client-side script
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideComposeModal", "var modal = bootstrap.Modal.getInstance(document.getElementById('composeMessageModal')); if(modal) modal.hide();", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Message sent successfully!');", true);
    }

    // Helper method to format time ago (optional)
    private string GetTimeAgo(DateTime dateTime)
    {
        TimeSpan timeAgo = DateTime.Now.Subtract(dateTime);

        if (timeAgo.TotalMinutes < 1)
            return "Just now";

        if (timeAgo.TotalHours < 1)
            return string.Format("{0} minutes ago", Math.Floor(timeAgo.TotalMinutes));

        if (timeAgo.TotalDays < 1)
            return string.Format("{0} hours ago", Math.Floor(timeAgo.TotalHours));

        if (timeAgo.TotalDays < 7)
            return string.Format("{0} days ago", Math.Floor(timeAgo.TotalDays));

        return dateTime.ToString("MMM dd, yyyy");
    }


    // Optional: WebMethod for AJAX calls to get message details without full postback
    // Requires ScriptManager on the page and enabling PageMethods in Web.config
    /*
    [System.Web.Services.WebMethod]
    public static object GetMessageDetails(string messageId)
    {
        // Implement logic to fetch message details from DB
        // Return an anonymous object or a custom class
        return new { Subject = "Sample Subject", Content = "Full sample content...", Sender = "System", Recipient = "User", Timestamp = DateTime.Now.ToString("g") };
    }
    */
}