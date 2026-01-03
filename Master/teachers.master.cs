using System;
using System.Web;
using System.Web.UI;

public partial class Master_teachers : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTeacherInfo();
        }
    }

    private void LoadTeacherInfo()
    {
        // Get teacher info from session (C# 5 compatible)
        string teacherName = Session["TeacherName"] != null ? Session["TeacherName"].ToString() : "Teacher";
        string teacherEmail = Session["TeacherEmail"] != null ? Session["TeacherEmail"].ToString() : "teacher@school.com";

        // Generate initials (first letter of first and last name)
        string initials = GetInitials(teacherName);

        // Set header labels
        lblUserName.Text = teacherName;
        lblHeaderInitials.Text = initials;

        // Set profile menu labels
        lblMenuName.Text = teacherName;
        lblMenuEmail.Text = teacherEmail;
    }

    private string GetInitials(string name)
    {
        if (string.IsNullOrWhiteSpace(name))
            return "T";

        var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
        
        if (parts.Length >= 2)
        {
            // First letter of first name + first letter of last name
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }
        else if (parts.Length == 1 && parts[0].Length >= 2)
        {
            // First two letters of single name
            return parts[0].Substring(0, 2).ToUpper();
        }
        else if (parts.Length == 1)
        {
            return parts[0][0].ToString().ToUpper();
        }

        return "T";
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        // Clear all session data
        Session.Clear();
        Session.Abandon();

        // Clear authentication cookie if exists
        if (Request.Cookies["authToken"] != null)
        {
            HttpCookie cookie = new HttpCookie("authToken");
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);
        }

        // Redirect to login
        Response.Redirect("~/teacher-login.aspx");
    }
}
