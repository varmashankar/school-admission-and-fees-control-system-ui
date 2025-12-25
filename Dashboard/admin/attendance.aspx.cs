using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_attendance : System.Web.UI.Page
{
    // ---------------------------
    //   BASIC CLASSES (C#5 SAFE)
    // ---------------------------

    public class Student
    {
        public int ID { get; set; }
        public string RollNo { get; set; }
        public string Name { get; set; }
        public string ClassSectionID { get; set; }
    }

    public class AttendanceTeacher
    {
        public int ID { get; set; }
        public string EmployeeID { get; set; }
        public string Name { get; set; }
        public string DepartmentID { get; set; }
    }

    public class AttendanceRecord
    {
        public int AttendanceID { get; set; }
        public int EntityID { get; set; }
        public string EntityType { get; set; }
        public DateTime AttendanceDate { get; set; }
        public string Status { get; set; }
        public string Remarks { get; set; }
    }

    // ------------------------------------------
    //   SIMULATED DATABASE (NO MODERN SYNTAX)
    // ------------------------------------------

    private static List<Student> _students = new List<Student>
    {
        new Student { ID = 1, RollNo = "S001", Name = "Alice Smith", ClassSectionID = "G1A" },
        new Student { ID = 2, RollNo = "S002", Name = "Bob Johnson", ClassSectionID = "G1A" },
        new Student { ID = 3, RollNo = "S003", Name = "Charlie Brown", ClassSectionID = "G1A" },
        new Student { ID = 4, RollNo = "S001", Name = "David Lee", ClassSectionID = "G1B" },
        new Student { ID = 5, RollNo = "S002", Name = "Eve Davis", ClassSectionID = "G1B" },
        new Student { ID = 6, RollNo = "S001", Name = "Frank White", ClassSectionID = "G5A" },
        new Student { ID = 7, RollNo = "S002", Name = "Grace Black", ClassSectionID = "G5A" }
    };

    private static List<AttendanceTeacher> _teachers = new List<AttendanceTeacher>
    {
        new AttendanceTeacher { ID = 101, EmployeeID = "T001", Name = "Ms. Radha Sharma", DepartmentID = "SCI" },
        new AttendanceTeacher { ID = 102, EmployeeID = "T002", Name = "Mr. Vipul Gupta", DepartmentID = "MATH" },
        new AttendanceTeacher { ID = 103, EmployeeID = "T003", Name = "Ms. Tanvi Mehta", DepartmentID = "SCI" },
        new AttendanceTeacher { ID = 104, EmployeeID = "T004", Name = "Dr. Kavita Singh", DepartmentID = "ADMIN" }
    };

    private static List<AttendanceRecord> _attendanceRecords = new List<AttendanceRecord>();


    // ------------------------
    //   STATE PROPERTY (SAFE)
    // ------------------------

    public string CurrentAttendanceType
    {
        get
        {
            object val = ViewState["CurrentAttendanceType"];
            return val == null ? "Student" : val.ToString();
        }
        set { ViewState["CurrentAttendanceType"] = value; }
    }


    // ------------------------
    //   PAGE LOAD
    // ------------------------

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtAttendanceDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            SetAttendanceType(CurrentAttendanceType);
            PopulateStats();
        }
    }


    // ------------------------
    //   SET TYPE BUTTON
    // ------------------------

    private void SetAttendanceType(string type)
    {
        CurrentAttendanceType = type;

        btnStudentAttendance.CssClass = "btn " + (type == "Student" ? "btn-primary active" : "btn-outline-primary");
        btnTeacherAttendance.CssClass = "btn " + (type == "Teacher" ? "btn-primary active" : "btn-outline-primary");

        divClassSelection.Visible = (type == "Student");
        divTeacherSelection.Visible = (type == "Teacher");

        pnlAttendanceGrid.Visible = false;
        gvAttendance.DataSource = null;
        gvAttendance.DataBind();

        string label = type == "Student" ? "Students" : "Teachers";
        //litTypePresent.Text = label;
        //litTypeAbsent.Text = label;

        PopulateStats();
    }


    protected void btnAttendanceType_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        SetAttendanceType(btn.CommandArgument);
    }


    // ------------------------
    //   POPULATE STATS
    // ------------------------

    private void PopulateStats()
    {
        DateTime today = DateTime.Today;
        int totalPresent = 0;
        int totalAbsent = 0;
        int pendingMarks = 0;

        if (CurrentAttendanceType == "Student")
        {
            List<AttendanceRecord> todays = _attendanceRecords
                .Where(a => a.EntityType == "Student" && a.AttendanceDate.Date == today)
                .ToList();

            totalPresent = todays.Count(a => a.Status == "P");
            totalAbsent = todays.Count(a => a.Status == "A");

            int expected = _students.Count;
            int marked = todays.Select(a => a.EntityID).Distinct().Count();

            pendingMarks = expected - marked;
            if (pendingMarks < 0) pendingMarks = 0;
        }
        else
        {
            List<AttendanceRecord> todays = _attendanceRecords
                .Where(a => a.EntityType == "Teacher" && a.AttendanceDate.Date == today)
                .ToList();

            totalPresent = todays.Count(a => a.Status == "P");
            totalAbsent = todays.Count(a => a.Status == "A");

            int expected = _teachers.Count;
            int marked = todays.Select(a => a.EntityID).Distinct().Count();

            pendingMarks = expected - marked;
            if (pendingMarks < 0) pendingMarks = 0;
        }

        litTodayPresent.Text = totalPresent.ToString();
        litTodayAbsent.Text = totalAbsent.ToString();
        litPendingMarks.Text = pendingMarks.ToString();
    }


    // ------------------------
    //   LOAD GRID
    // ------------------------

    protected void btnLoadAttendance_Click(object sender, EventArgs e)
    {
        if (txtAttendanceDate.Text == "")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please select a date.');", true);
            pnlAttendanceGrid.Visible = false;
            return;
        }

        if (CurrentAttendanceType == "Student" && ddlClasses.SelectedValue == "")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Please select a class.');", true);
            pnlAttendanceGrid.Visible = false;
            return;
        }

        LoadAttendanceGrid();
        pnlAttendanceGrid.Visible = true;
    }


    private void LoadAttendanceGrid()
    {
        DateTime selectedDate = DateTime.Parse(txtAttendanceDate.Text);
        string header = "";
        List<object> list = new List<object>();

        if (CurrentAttendanceType == "Student")
        {
            string classId = ddlClasses.SelectedValue;
            header = ddlClasses.SelectedItem.Text;

            List<Student> students = _students.Where(s => s.ClassSectionID == classId).ToList();

            foreach (Student s in students)
            {
                AttendanceRecord rec = _attendanceRecords
                    .Where(a => a.EntityType == "Student" && a.EntityID == s.ID && a.AttendanceDate.Date == selectedDate.Date)
                    .FirstOrDefault();

                string status = rec != null ? rec.Status : "P";
                string remarks = rec != null ? rec.Remarks : "";

                list.Add(new AttendanceDisplayRow(s.ID, s.RollNo, s.Name, status, remarks));
            }
        }
        else
        {
            string dept = ddlDepartments.SelectedValue;
            header = ddlDepartments.SelectedItem.Text;

            IEnumerable<AttendanceTeacher> teachers =
                dept == "" ? _teachers : _teachers.Where(t => t.DepartmentID == dept);

            foreach (AttendanceTeacher t in teachers)
            {
                AttendanceRecord rec = _attendanceRecords
                    .Where(a => a.EntityType == "Teacher" && a.EntityID == t.ID && a.AttendanceDate.Date == selectedDate.Date)
                    .FirstOrDefault();

                string status = rec != null ? rec.Status : "P";
                string remarks = rec != null ? rec.Remarks : "";

                list.Add(new AttendanceDisplayRow(t.ID, t.EmployeeID, t.Name, status, remarks));
            }
        }

        litSelectedEntityDate.Text = header + " on " + selectedDate.ToShortDateString();

        gvAttendance.DataSource = list;
        gvAttendance.DataBind();
    }


    // ------------------------
    //   SAFE DISPLAY OBJECT
    // ------------------------

    public class AttendanceDisplayRow
    {
        public int ID;
        public string Identifier;
        public string Name;
        public string Status;
        public string Remarks;

        public AttendanceDisplayRow(int id, string identifier, string name, string status, string remarks)
        {
            ID = id;
            Identifier = identifier;
            Name = name;
            Status = status;
            Remarks = remarks;
        }
    }


    // ------------------------
    //   ROW DATABOUND
    // ------------------------

    protected void gvAttendance_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            RadioButtonList rblStatus = (RadioButtonList)e.Row.FindControl("rblStatus");
            if (rblStatus != null && e.Row.DataItem != null)
            {
                AttendanceDisplayRow row = (AttendanceDisplayRow)e.Row.DataItem;
                string status = row.Status;

                // Fix styling manually
                foreach (ListItem item in rblStatus.Items)
                {
                    string css = "";
                    if (item.Value == "P") css = "attendance-status-present";
                    if (item.Value == "A") css = "attendance-status-absent";
                    if (item.Value == "L") css = "attendance-status-late";
                    if (item.Value == "LV") css = "attendance-status-leave";

                    item.Text = "<span class='" + css + "'>" + item.Text + "</span>";
                }

                ListItem sel = rblStatus.Items.FindByValue(status);
                if (sel != null) sel.Selected = true;
            }
        }
    }


    // ------------------------
    //   SAVE ATTENDANCE
    // ------------------------

    protected void btnSaveAttendance_Click(object sender, EventArgs e)
    {
        DateTime date = DateTime.Parse(txtAttendanceDate.Text);
        string type = CurrentAttendanceType;

        _attendanceRecords.RemoveAll(a => a.EntityType == type && a.AttendanceDate.Date == date.Date);

        foreach (GridViewRow row in gvAttendance.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(gvAttendance.DataKeys[row.RowIndex].Value);
                RadioButtonList rbl = (RadioButtonList)row.FindControl("rblStatus");
                TextBox txt = (TextBox)row.FindControl("txtRemarks");

                AttendanceRecord rec = new AttendanceRecord();
                rec.AttendanceID = _attendanceRecords.Count > 0 ? _attendanceRecords.Max(a => a.AttendanceID) + 1 : 1;
                rec.EntityID = id;
                rec.EntityType = type;
                rec.AttendanceDate = date;
                rec.Status = rbl.SelectedValue;
                rec.Remarks = txt != null ? txt.Text : "";

                _attendanceRecords.Add(rec);
            }
        }

        ScriptManager.RegisterStartupScript(this, GetType(), "ok", "alert('Attendance saved successfully!');", true);

        PopulateStats();
        pnlAttendanceGrid.Visible = false;
    }

    protected void txtAttendanceDate_TextChanged(object sender, EventArgs e)
    {
        pnlAttendanceGrid.Visible = false;
        PopulateStats();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ddlClasses.SelectedValue = "";
        ddlDepartments.SelectedValue = "";
        txtAttendanceDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
        pnlAttendanceGrid.Visible = false;
        PopulateStats();
    }
}
