using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_addstudentdetails : AuthenticatedPage
{
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        string tab = hfActiveTab.Value;

        if (!string.IsNullOrEmpty(tab))
        {
            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "ActivateTab",
                "var tabTrigger = document.querySelector('a[href=\"" + tab + "\"]');" +
                "if (tabTrigger) { var tabInstance = new bootstrap.Tab(tabTrigger); tabInstance.show(); }",
                true
            );

        }
    }

    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string raw = Request.QueryString["sid"];

            if (!string.IsNullOrEmpty(raw))
            {
                string sid = CryptoHelper.Decrypt(raw);

                await LoadStudentMain(sid);
                await LoadAllDetails(sid);
            }
        }

    }

    private async System.Threading.Tasks.Task LoadStudentMain(string sid)
    {
        ApiResponse res =
            await ApiHelper.PostAsync("api/Students/getStudentDetails", new { student_code = sid }, HttpContext.Current);

        if (res != null && res.response_code == "200")
        {
            string json = JsonConvert.SerializeObject(res.obj);
            dynamic data = JsonConvert.DeserializeObject(json);

            hfStudentId.Value = data.id;
            lblStudentName.Text = data.firstName + " " + data.lastName;
            lblSID.Text = data.studentCode;
            lblDOB.Text = Convert.ToString(data.dob).Split(' ')[0];
            lblClass.Text = data.classId;
            lblPhone.Text = data.phone;
        }

    }

    private async System.Threading.Tasks.Task LoadAllDetails(string sid)
    {
        // ------------------- PARENTS -------------------
        ApiResponse parentsRes =
            await ApiHelper.PostAsync("api/StudentParents/getStudentParents",
                                      new { student_code = sid },
                                      HttpContext.Current);

        if (parentsRes != null && parentsRes.response_code == "200")
        {
            var json = JsonConvert.SerializeObject(parentsRes.obj);
            System.Diagnostics.Debug.WriteLine("PARENTS RAW: " + json);
            var parents = JsonConvert.DeserializeObject<List<dynamic>>(json);

            rptParents.DataSource = parents;
            rptParents.DataBind();
        }

        // ------------------- EMERGENCY CONTACTS -------------------
        ApiResponse emergencyRes =
            await ApiHelper.PostAsync("api/EmergencyContacts/getStudentEmergencyContacts",
                                      new { student_code = sid },
                                      HttpContext.Current);

        if (emergencyRes != null && emergencyRes.response_code == "200")
        {
            var json = JsonConvert.SerializeObject(emergencyRes.obj);
            var emergency = JsonConvert.DeserializeObject<List<dynamic>>(json);

            rptEmergency.DataSource = emergency;
            rptEmergency.DataBind();
        }

        // ------------------- PREVIOUS SCHOOL -------------------
        ApiResponse schoolRes =
            await ApiHelper.PostAsync("api/PreviousSchool/getStudentPreviousSchool",
                                      new { student_code = sid },
                                      HttpContext.Current);

        if (schoolRes != null && schoolRes.response_code == "200")
        {
            var json = JsonConvert.SerializeObject(schoolRes.obj);
            var schools = JsonConvert.DeserializeObject<List<dynamic>>(json);

            rptSchool.DataSource = schools;
            rptSchool.DataBind();
        }
    }


    // ============================
    // SAVE PARENT
    // ============================
    protected async void btnSaveParent_Click(object sender, EventArgs e)
    {
        try
        {
            var parent = new
            {
                studentId = hfStudentId.Value,
                parentType = ddlParentType.SelectedValue,
                fullName = txtParentName.Text.Trim(),
                mobile = txtParentMobile.Text.Trim(),
                occupation = txtParentOccupation.Text.Trim(),
                isGuardian = chkGuardian.Checked,
                relationship = txtParentRelation.Text.Trim()
            };

            ApiResponse res =
                await ApiHelper.PostAsync("api/StudentParents/saveStudentParents",
                                          parent,
                                          HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                Alert.Show(this, "Parent saved successfully.", "success");

                // RESET FORM
                ddlParentType.SelectedIndex = 0;
                txtParentName.Text = "";
                txtParentMobile.Text = "";
                txtParentOccupation.Text = "";
                chkGuardian.Checked = false;
                txtParentRelation.Text = "";

                await LoadAllDetails(hfStudentId.Value);

            }
            else
            {
                string msg = (res != null && res.obj != null)
                    ? res.obj.ToString()
                    : "Failed to save parent.";

                Alert.Show(this, msg, "error");
            }
        }
        catch (Exception ex)
        {
            Alert.Show(this, "Unexpected error while saving parent: " + ex.Message, "error");
        }
    }


    // ============================
    // SAVE EMERGENCY CONTACT
    // ============================
    protected async void btnSaveEmergency_Click(object sender, EventArgs e)
    {
        try
        {
            var model = new
            {
                studentId = hfStudentId.Value,
                contactName = txtECName.Text.Trim(),
                contactNumber = txtECPhone.Text.Trim(),
                relation = txtECRelation.Text.Trim()
            };

            ApiResponse res =
                await ApiHelper.PostAsync("api/EmergencyContacts/saveStudentEmergencyContact",
                                          model,
                                          HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                Alert.Show(this, "Emergency contact saved.", "success");

                // RESET
                txtECName.Text = "";
                txtECPhone.Text = "";
                txtECRelation.Text = "";

                await LoadAllDetails(hfStudentId.Value);
            }
            else
            {
                string msg = (res != null && res.obj != null)
                    ? res.obj.ToString()
                    : "Failed to save emergency contact.";

                Alert.Show(this, msg, "error");
            }
        }
        catch (Exception ex)
        {
            Alert.Show(this, "Unexpected error while saving emergency contact: " + ex.Message, "error");
        }
    }


    // ============================
    // SAVE PREVIOUS SCHOOL
    // ============================
    protected async void btnSaveSchool_Click(object sender, EventArgs e)
    {
        try
        {
            var model = new
            {
                studentId = hfStudentId.Value,
                schoolName = txtPrevSchool.Text.Trim(),
                previousClass = txtPrevClass.Text.Trim(),
                tcNumber = txtTCNo.Text.Trim()
            };

            ApiResponse res =
                await ApiHelper.PostAsync("api/PreviousSchool/saveStudentPreviousSchool",
                                          model,
                                          HttpContext.Current);

            if (res != null && res.response_code == "200")
            {
                Alert.Show(this, "Previous school record saved.", "success");

                // RESET
                txtPrevSchool.Text = "";
                txtPrevClass.Text = "";
                txtTCNo.Text = "";

                await LoadAllDetails(hfStudentId.Value);
            }
            else
            {
                string msg = (res != null && res.obj != null)
                    ? res.obj.ToString()
                    : "Failed to save previous school.";

                Alert.Show(this, msg, "error");
            }
        }
        catch (Exception ex)
        {
            Alert.Show(this, "Unexpected error while saving previous school: " + ex.Message, "error");
        }
    }




}