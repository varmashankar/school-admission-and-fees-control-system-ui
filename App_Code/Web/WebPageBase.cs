using System;
using System.Web;
using System.Web.UI;

public abstract class WebPageBase : Page
{
    protected void RedirectSafe(string url)
    {
        Response.Redirect(url, false);
        if (Context != null && Context.ApplicationInstance != null)
            Context.ApplicationInstance.CompleteRequest();
    }

    protected void ShowAlert(string message, string type)
    {
        if (message == null)
            message = string.Empty;

        message = message.Replace("'", string.Empty);

        string script = "Swal.fire({" +
                        "title: '" + (type == "success" ? "Success" : "Error") + "'," +
                        "text: '" + message + "'," +
                        "icon: '" + type + "'" +
                        "});";

        ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), script, true);
    }
}
