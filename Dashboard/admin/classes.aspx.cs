using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_classes : System.Web.UI.Page
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
            await LoadClasses();
        }
    }

    public async Task LoadClasses()
    {
        var payload = new
        {
            id = (int?)null,
            academicYearId = (int?)null,
            schoolId = (int?)null
        };

        var res = await ApiHelper.PostAsync(
            "api/Classes/getClassList",
            payload,
            HttpContext.Current
        );

        if (res.response_code == "200" && res.obj != null)
        {
            rptClasses.DataSource = JsonConvert.DeserializeObject(res.obj.ToString());
            rptClasses.DataBind();
        }
        else
        {
            rptClasses.DataSource = null;
            rptClasses.DataBind();
        }
    }
}
