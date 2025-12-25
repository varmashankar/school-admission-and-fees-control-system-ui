using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_feedefinition : System.Web.UI.Page
{
    // Dummy Data Structures
    public class FeeDefinition
    {
        public int FeeDefinitionID { get; set; }
        public string FeeName { get; set; }
        public string Description { get; set; }
        public decimal DefaultAmount { get; set; }
        public string ApplicableClassID { get; set; } // e.g., "G1A", or empty for all classes
        public string ApplicableClass { get; set; } // Display name for GridView
        public DateTime DefaultDueDate { get; set; }
        public bool IsActive { get; set; }
    }

    public class ClassInfo // To populate ddlApplicableClass dynamically if needed
    {
        public string ClassID { get; set; }
        public string ClassName { get; set; }
    }

    // Simulate database data
    private static List<FeeDefinition> _feeDefinitions = new List<FeeDefinition>
    {
        new FeeDefinition { FeeDefinitionID = 1, FeeName = "Tuition Fee", Description = "Annual tuition fee", DefaultAmount = 1000.00m, ApplicableClassID = "", ApplicableClass = "All Classes", DefaultDueDate = new DateTime(DateTime.Now.Year, 9, 1), IsActive = true },
        new FeeDefinition { FeeDefinitionID = 2, FeeName = "Library Fee", Description = "Annual library usage fee", DefaultAmount = 50.00m, ApplicableClassID = "G1A", ApplicableClass = "Grade 1 - A", DefaultDueDate = new DateTime(DateTime.Now.Year, 9, 15), IsActive = true },
        new FeeDefinition { FeeDefinitionID = 3, FeeName = "Exam Fee", Description = "Semester exam fee", DefaultAmount = 150.00m, ApplicableClassID = "G5A", ApplicableClass = "Grade 5 - A", DefaultDueDate = new DateTime(DateTime.Now.Year, 11, 1), IsActive = true },
        new FeeDefinition { FeeDefinitionID = 4, FeeName = "Sports Fee", Description = "Annual sports club fee", DefaultAmount = 75.00m, ApplicableClassID = "", ApplicableClass = "All Classes", DefaultDueDate = new DateTime(DateTime.Now.Year, 9, 30), IsActive = false },
    };

    private static List<ClassInfo> _classes = new List<ClassInfo>
    {
        new ClassInfo { ClassID = "G1A", ClassName = "Grade 1 - A" },
        new ClassInfo { ClassID = "G1B", ClassName = "Grade 1 - B" },
        new ClassInfo { ClassID = "G5A", ClassName = "Grade 5 - A" },
        new ClassInfo { ClassID = "G8A", ClassName = "Grade 8 - A" }
    };

    // ViewState to track if we are in edit mode
    private int EditingFeeDefinitionID
    {
        get { return ViewState["EditingFeeDefinitionID"] != null ? (int)ViewState["EditingFeeDefinitionID"] : 0; }
        set { ViewState["EditingFeeDefinitionID"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateStats();
            PopulateClassesDropdown();
            BindFeeDefinitionsGridView();
            txtDefaultDueDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Default due date
        }
    }

    private void PopulateStats()
    {
        litTotalFeeTypes.Text = _feeDefinitions.Count.ToString();
        litFeeStructuresInUse.Text = _feeDefinitions.Count(f => f.IsActive).ToString();
        litUpcomingDueDates.Text = _feeDefinitions.Count(f => f.IsActive && f.DefaultDueDate.Month == DateTime.Now.Month && f.DefaultDueDate.Day >= DateTime.Now.Day).ToString();
    }

    private void PopulateClassesDropdown()
    {
        ddlApplicableClass.DataSource = _classes.OrderBy(c => c.ClassName);
        ddlApplicableClass.DataTextField = "ClassName";
        ddlApplicableClass.DataValueField = "ClassID";
        ddlApplicableClass.DataBind();
        ddlApplicableClass.Items.Insert(0, new ListItem("-- All Classes --", "")); // Add default "All Classes"
    }

    private void BindFeeDefinitionsGridView()
    {
        gvFeeDefinitions.DataSource = _feeDefinitions.OrderBy(f => f.FeeName).ToList();
        gvFeeDefinitions.DataBind();
    }

    protected void btnAddFeeType_Click(object sender, EventArgs e)
    {
        if (!IsValid) return;

        // Simulate getting a new ID
        int newID = _feeDefinitions.Count > 0 ? _feeDefinitions.Max(f => f.FeeDefinitionID) + 1 : 1;

        string applicableClassID = ddlApplicableClass.SelectedValue;
        string applicableClassName = ddlApplicableClass.SelectedItem.Text;
        if (string.IsNullOrEmpty(applicableClassID)) { applicableClassName = "All Classes"; }

        _feeDefinitions.Add(new FeeDefinition
        {
            FeeDefinitionID = newID,
            FeeName = txtFeeName.Text.Trim(),
            Description = txtFeeDescription.Text.Trim(),
            DefaultAmount = decimal.Parse(txtDefaultAmount.Text),
            ApplicableClassID = applicableClassID,
            ApplicableClass = applicableClassName,
            DefaultDueDate = DateTime.Parse(txtDefaultDueDate.Text),
            IsActive = chkIsActive.Checked
        });

        ClearForm();
        BindFeeDefinitionsGridView();
        PopulateStats();
        ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('Fee type added successfully!');", true);
    }

    protected void gvFeeDefinitions_RowEditing(object sender, GridViewEditEventArgs e)
    {
        // Cancel edit mode
        gvFeeDefinitions.EditIndex = -1;

        int feeDefID = (int)gvFeeDefinitions.DataKeys[e.NewEditIndex].Value;
        EditingFeeDefinitionID = feeDefID; // Store ID for update

        FeeDefinition feeDef = _feeDefinitions.FirstOrDefault(f => f.FeeDefinitionID == feeDefID);

        if (feeDef != null)
        {
            txtFeeName.Text = feeDef.FeeName;
            txtFeeDescription.Text = feeDef.Description;
            txtDefaultAmount.Text = feeDef.DefaultAmount.ToString("F2");
            ddlApplicableClass.SelectedValue = feeDef.ApplicableClassID;
            txtDefaultDueDate.Text = feeDef.DefaultDueDate.ToString("yyyy-MM-dd");
            chkIsActive.Checked = feeDef.IsActive;

            // Adjust buttons for edit mode
            btnAddFeeType.Visible = false;
            btnUpdateFeeType.Visible = true;
            btnCancelEdit.Visible = true;
        }
    }

    protected void btnUpdateFeeType_Click(object sender, EventArgs e)
    {
        if (!IsValid) return;

        FeeDefinition feeDef = _feeDefinitions.FirstOrDefault(f => f.FeeDefinitionID == EditingFeeDefinitionID);

        if (feeDef != null)
        {
            string applicableClassID = ddlApplicableClass.SelectedValue;
            string applicableClassName = ddlApplicableClass.SelectedItem.Text;
            if (string.IsNullOrEmpty(applicableClassID)) { applicableClassName = "All Classes"; }

            feeDef.FeeName = txtFeeName.Text.Trim();
            feeDef.Description = txtFeeDescription.Text.Trim();
            feeDef.DefaultAmount = decimal.Parse(txtDefaultAmount.Text);
            feeDef.ApplicableClassID = applicableClassID;
            feeDef.ApplicableClass = applicableClassName;
            feeDef.DefaultDueDate = DateTime.Parse(txtDefaultDueDate.Text);
            feeDef.IsActive = chkIsActive.Checked;

            ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('Fee type updated successfully!');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('Error: Fee type not found for update.');", true);
        }

        ClearForm();
        BindFeeDefinitionsGridView();
        PopulateStats();
        EditingFeeDefinitionID = 0; // Reset editing mode
    }

    protected void gvFeeDefinitions_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int feeDefID = (int)gvFeeDefinitions.DataKeys[e.RowIndex].Value;
        FeeDefinition feeDefToRemove = _feeDefinitions.FirstOrDefault(f => f.FeeDefinitionID == feeDefID);

        if (feeDefToRemove != null)
        {
            _feeDefinitions.Remove(feeDefToRemove);
            ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('Fee type deleted successfully!');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('Error: Fee type not found for deletion.');", true);
        }

        BindFeeDefinitionsGridView();
        PopulateStats();
    }

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        ClearForm();
        EditingFeeDefinitionID = 0; // Exit edit mode
        ScriptManager.RegisterStartupScript(this, GetType(), "cancel", "alert('Edit cancelled.');", true);
    }

    private void ClearForm()
    {
        txtFeeName.Text = "";
        txtFeeDescription.Text = "";
        txtDefaultAmount.Text = "";
        ddlApplicableClass.SelectedValue = ""; // Select "All Classes"
        txtDefaultDueDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Reset date
        chkIsActive.Checked = true;

        btnAddFeeType.Visible = true;
        btnUpdateFeeType.Visible = false;
        btnCancelEdit.Visible = false;

        // Clear validators to prevent error messages from previous inputs showing up
        foreach (BaseValidator validator in Page.Validators)
        {
            validator.Validate();
        }
    }
}