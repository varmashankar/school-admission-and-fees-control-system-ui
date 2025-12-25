using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_notice : System.Web.UI.Page
{
    // Replace with your actual connection string
    //private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set initial date for the textbox if it's empty
            if (string.IsNullOrEmpty(txtPublishedDate.Text))
            {
                txtPublishedDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
            LoadNotices(); // Load notices when the page first loads
        }
    }

    private void LoadNotices()
    {
        //DataTable dtNotices = new DataTable();
        //// Example: Fetch notices from a database
        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    // You'll need to create your 'Notices' table in your database
        //    string query = "SELECT NoticeID, Title, PublishedDate, ExpiryDate, Audience, IsImportant, Status FROM Notices ORDER BY PublishedDate DESC";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        con.Open();
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        da.Fill(dtNotices);
        //    }
        //}

        //// Clear existing rows (if any) before adding new ones
        //noticeTableBody.Controls.Clear();

        //// Dynamically add rows to the table
        //int rowNumber = 1;
        //foreach (DataRow row in dtNotices.Rows)
        //{
        //    HtmlTableRow tr = new HtmlTableRow();

        //    // ID Column
        //    HtmlTableCell tcId = new HtmlTableCell("th");
        //    //tcId.Scope = "row";
        //    tcId.InnerText = (rowNumber++).ToString();
        //    tr.Cells.Add(tcId);

        //    // Title Column
        //    HtmlTableCell tcTitle = new HtmlTableCell();
        //    tcTitle.InnerText = row["Title"].ToString();
        //    tr.Cells.Add(tcTitle);

        //    // Published Date Column
        //    HtmlTableCell tcPublishedDate = new HtmlTableCell();
        //    tcPublishedDate.InnerText = Convert.ToDateTime(row["PublishedDate"]).ToString("yyyy-MM-dd");
        //    tr.Cells.Add(tcPublishedDate);

        //    // Expiry Date Column
        //    HtmlTableCell tcExpiryDate = new HtmlTableCell();
        //    tcExpiryDate.InnerText = row["ExpiryDate"] == DBNull.Value ? "N/A" : Convert.ToDateTime(row["ExpiryDate"]).ToString("yyyy-MM-dd");
        //    tr.Cells.Add(tcExpiryDate);

        //    // Status Column
        //    HtmlTableCell tcStatus = new HtmlTableCell();
        //    string status = GetNoticeStatus(Convert.ToDateTime(row["PublishedDate"]), row["ExpiryDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["ExpiryDate"]));
        //    string badgeClass = status == "Active" ? "bg-success" : (status == "Upcoming" ? "bg-info" : "bg-secondary");
        //    tcStatus.InnerHtml = $"<span class='badge {badgeClass}'>{status}</span>";
        //    tr.Cells.Add(tcStatus);

        //    // Actions Column
        //    HtmlTableCell tcActions = new HtmlTableCell();
        //    tcActions.Attributes["class"] = "notice-actions";
        //    // For View, Edit, Delete, you'd typically have buttons that postback or open new modals
        //    // Here we use simple HTML buttons, you might replace them with LinkButtons or ImageButtons with CommandArguments
        //    tcActions.InnerHtml = $@"
        //        <button type='button' class='btn btn-sm btn-info me-1' title='View' onclick=""alert('View Notice ID: {row["NoticeID"]}');""><i class='fas fa-eye'></i></button>
        //        <button type='button' class='btn btn-sm btn-warning me-1' title='Edit' onclick=""alert('Edit Notice ID: {row["NoticeID"]}');""><i class='fas fa-edit'></i></button>
        //        <button type='button' class='btn btn-sm btn-danger' title='Delete' onclick=""if(confirm('Are you sure?')) {{ /* __doPostBack or call server method */ alert('Delete Notice ID: {row["NoticeID"]}'); }} return false;""><i class='fas fa-trash-alt'></i></button>";
        //    tr.Cells.Add(tcActions);

        //    noticeTableBody.Controls.Add(tr);
        //}
    }

    private string GetNoticeStatus(DateTime publishedDate, DateTime? expiryDate)
    {
        DateTime today = DateTime.Today;
        if (publishedDate > today)
        {
            return "Upcoming";
        }
        else if (expiryDate.HasValue && expiryDate.Value < today)
        {
            return "Expired";
        }
        else
        {
            return "Active";
        }
    }


    protected void btnSaveNotice_Click(object sender, EventArgs e)
    {
        //string title = txtNoticeTitle.Text;
        //string content = txtNoticeContent.Text;
        //DateTime publishedDate = Convert.ToDateTime(txtPublishedDate.Text);
        //DateTime? expiryDate = null;
        //if (!string.IsNullOrEmpty(txtExpiryDate.Text))
        //{
        //    expiryDate = Convert.ToDateTime(txtExpiryDate.Text);
        //}
        //string audience = ddlNoticeAudience.SelectedValue;
        //bool isImportant = chkIsImportant.Checked;

        //// Save to database
        //using (SqlConnection con = new SqlConnection(connectionString))
        //{
        //    string query = @"INSERT INTO Notices (Title, Content, PublishedDate, ExpiryDate, Audience, IsImportant, Status)
        //                     VALUES (@Title, @Content, @PublishedDate, @ExpiryDate, @Audience, @IsImportant, @Status)";
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@Title", title);
        //        cmd.Parameters.AddWithValue("@Content", content);
        //        cmd.Parameters.AddWithValue("@PublishedDate", publishedDate);
        //        cmd.Parameters.AddWithValue("@ExpiryDate", (object)expiryDate ?? DBNull.Value); // Handle nullable expiry date
        //        cmd.Parameters.AddWithValue("@Audience", audience);
        //        cmd.Parameters.AddWithValue("@IsImportant", isImportant);
        //        cmd.Parameters.AddWithValue("@Status", GetNoticeStatus(publishedDate, expiryDate)); // Set initial status
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //}

        //// After saving, reload the notices to update the table
        //LoadNotices();

        //// Optionally, show a success message
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Notice saved successfully!');", true);

        //// Hide the modal using client-side script
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "hideModal", "var addNoticeModal = bootstrap.Modal.getInstance(document.getElementById('addNoticeModal')); if(addNoticeModal) { addNoticeModal.hide(); }", true);

        //// Clear form fields
        //txtNoticeTitle.Text = "";
        //txtNoticeContent.Text = "";
        //txtPublishedDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Reset to today
        //txtExpiryDate.Text = "";
        //ddlNoticeAudience.SelectedValue = "All";
        //chkIsImportant.Checked = false;

        //// To ensure the UpdatePanel updates
        //upAddNotice.Update();
    }
}