using System;

public abstract class AuthenticatedPage : WebPageBase
{
    protected override void OnLoad(EventArgs e)
    {
        // Restore token from cookie if available
        if (Session["authToken"] == null && Request.Cookies["authToken"] != null)
        {
            string cookieToken = Request.Cookies["authToken"].Value;
            if (!string.IsNullOrEmpty(cookieToken))
            {
                Session["authToken"] = cookieToken;
            }
        }

        if (Session["authToken"] == null)
        {
            string path = Request.Url.AbsolutePath.ToLower();
            bool isTeacherArea = path.Contains("/dashboard/teacher") || path.Contains("/dashboard-teachers") || path.Contains("teacher-");
            string targetLogin = isTeacherArea ? "~/teacher-login.aspx" : "~/login.aspx";

            RedirectSafe(targetLogin);
            return;
        }

        base.OnLoad(e);
    }
}
