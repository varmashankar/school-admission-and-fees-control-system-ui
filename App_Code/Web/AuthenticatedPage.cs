using System;

public abstract class AuthenticatedPage : WebPageBase
{
    protected override void OnLoad(EventArgs e)
    {
        if (Session["authToken"] == null)
        {
            RedirectSafe("~/login.aspx");
            return;
        }

        base.OnLoad(e);
    }
}
