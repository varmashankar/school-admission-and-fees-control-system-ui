using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSchoolInfo();
        }
    }

    private void LoadSchoolInfo()
    {
        try
        {
            var csSetting = System.Configuration.ConfigurationManager.ConnectionStrings["schoolerp"];
            if (csSetting == null) return;
            string cs = csSetting.ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string sql = "SELECT TOP 1 school_name, code, address, phone, email, logo_path, current_academic_year_id FROM dbo.schools WHERE deleted=0 AND status=1 ORDER BY id DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string name = dr["school_name"] != DBNull.Value ? Convert.ToString(dr["school_name"]) : string.Empty;
                            string address = dr["address"] != DBNull.Value ? Convert.ToString(dr["address"]) : string.Empty;
                            string phone = dr["phone"] != DBNull.Value ? Convert.ToString(dr["phone"]) : string.Empty;
                            string email = dr["email"] != DBNull.Value ? Convert.ToString(dr["email"]) : string.Empty;
                            string logo = dr["logo_path"] != DBNull.Value ? Convert.ToString(dr["logo_path"]) : string.Empty;

                            // Populate controls
                            litSchoolName.Text = Server.HtmlEncode(name);
                            litSchoolTag.Text = Server.HtmlEncode(""); // optional tagline if available

                            if (!string.IsNullOrEmpty(logo))
                            {
                                // Normalize stored path to an app-relative path if needed and resolve it
                                string appRelative = logo;
                                if (!logo.StartsWith("~") && logo.StartsWith("/"))
                                {
                                    appRelative = "~" + logo; // "/uploads/schools/x.png" -> "~/uploads/schools/x.png"
                                }
                                // If logo is missing a leading slash and does not have a ~, assume it's already app-relative
                                try
                                {
                                    imgLogo.ImageUrl = ResolveUrl(appRelative);
                                }
                                catch
                                {
                                    // fallback to placeholder
                                    imgLogo.ImageUrl = "https://via.placeholder.com/64x64?text=W";
                                }

                                imgLogo.AlternateText = name;
                            }
                            else
                            {
                                // fallback placeholder when no logo configured
                                imgLogo.ImageUrl = "https://via.placeholder.com/64x64?text=W";
                                imgLogo.AlternateText = name;
                            }

                            hfPhone.Value = phone;
                            hfEmail.Value = email;

                            // Also update contact card visible text via client script (safe-encoded)
                            string safeAddress = address.Replace("\r\n", "\\n").Replace("'", "\\'");
                            string safePhone = phone.Replace("'", "\\'");
                            string safeEmail = email.Replace("'", "\\'");

                            string script = "(function(){var addrEl = document.querySelectorAll('#contact .bg-slate-50 p')[0]; if(addrEl) addrEl.innerHTML = '" + safeAddress + "';" +
                                            "var phoneEl = document.querySelectorAll('#contact .bg-slate-50 p')[1]; if(phoneEl) phoneEl.innerHTML = 'Main Office: " + safePhone + "<br/>Admissions: " + safePhone + "';" +
                                            "var emailEl = document.querySelectorAll('#contact .bg-slate-50 p')[2]; if(emailEl) emailEl.innerHTML = 'General: " + safeEmail + "<br/>Admissions: " + safeEmail + "';})();";

                            ClientScript.RegisterStartupScript(this.GetType(), "populateContact", script, true);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // fail silently for now
            System.Diagnostics.Debug.WriteLine("Error loading school info: " + ex.Message);
        }
    }
}