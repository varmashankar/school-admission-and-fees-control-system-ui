using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard_admin_attendancereports : System.Web.UI.Page
{
    private AttendanceService _attendanceService = new AttendanceService(); // Your service class for attendance data

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set default date range for last 30 days or current month
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");

            PopulateDropdowns();
        }
    }

    private void PopulateDropdowns()
    {
        // Populate DDLs from service or static lists
        ddlFilterClass.DataSource = _attendanceService.GetAllClasses();
        ddlFilterClass.DataTextField = "ClassName";
        ddlFilterClass.DataValueField = "ClassID";
        ddlFilterClass.DataBind();
        ddlFilterClass.Items.Insert(0, new ListItem("-- All Classes --", ""));

        ddlFilterDepartment.DataSource = _attendanceService.GetAllDepartments();
        ddlFilterDepartment.DataTextField = "DepartmentName";
        ddlFilterDepartment.DataValueField = "DepartmentID";
        ddlFilterDepartment.DataBind();
        ddlFilterDepartment.Items.Insert(0, new ListItem("-- All Departments --", ""));
    }

    protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReportType.SelectedValue == "Student")
        {
            divClassFilter.Visible = true;
            divDepartmentFilter.Visible = false;
        }
        else // Teacher
        {
            divClassFilter.Visible = false;
            divDepartmentFilter.Visible = true;
        }
        pnlReportResults.Visible = false; // Hide results when type changes
        litMessage.Text = "";
    }

    protected void btnGenerateReport_Click(object sender, EventArgs e)
    {
        DateTime startDate, endDate;
        if (!DateTime.TryParse(txtStartDate.Text, out startDate) || !DateTime.TryParse(txtEndDate.Text, out endDate))
        {
            litMessage.Text = "<div class='alert alert-danger mt-3'>Please enter valid start and end dates.</div>";
            pnlReportResults.Visible = false;
            return;
        }

        if (startDate > endDate)
        {
            litMessage.Text = "<div class='alert alert-danger mt-3'>Start date cannot be after end date.</div>";
            pnlReportResults.Visible = false;
            return;
        }

        string reportType = ddlReportType.SelectedValue;
        string classId = ddlFilterClass.SelectedValue;
        string departmentId = ddlFilterDepartment.SelectedValue;

        // Fetch data based on selected criteria
        List<AttendanceRecord> records = _attendanceService.GetAttendanceRecords(
            reportType, classId, departmentId, startDate, endDate);

        if (records.Any())
        {
            gvAttendanceReport.DataSource = records;
            gvAttendanceReport.DataBind();

            UpdateSummaryStats(records);
            UpdateChartData(records);
            pnlReportResults.Visible = true;
            litMessage.Text = "";
        }
        else
        {
            gvAttendanceReport.DataSource = null;
            gvAttendanceReport.DataBind();
            litMessage.Text = "<div class='alert alert-info mt-3'>No attendance records found for the selected criteria.</div>";
            pnlReportResults.Visible = false;
        }
    }

    private void UpdateSummaryStats(List<AttendanceRecord> records)
    {
        int presentCount = records.Count(r => r.Status == "Present");
        int absentCount = records.Count(r => r.Status == "Absent");
        int lateCount = records.Count(r => r.Status == "Late");
        int leaveCount = records.Count(r => r.Status == "Leave");
        int totalDays = records.Count;

        litPresentCount.Text = presentCount.ToString();
        litAbsentCount.Text = absentCount.ToString();
        litLateCount.Text = lateCount.ToString();
        litLeaveCount.Text = leaveCount.ToString();
        litTotalDays.Text = totalDays.ToString();
    }

    private void UpdateChartData(List<AttendanceRecord> records)
    {
        // These literals are used by the JavaScript for Google Charts
        litChartPresent.Text = records.Count(r => r.Status == "Present").ToString();
        litChartAbsent.Text = records.Count(r => r.Status == "Absent").ToString();
        litChartLate.Text = records.Count(r => r.Status == "Late").ToString();
        litChartLeave.Text = records.Count(r => r.Status == "Leave").ToString();

        // Re-register the script to draw charts with new data
        ScriptManager.RegisterStartupScript(this, GetType(), "DrawCharts", "drawCharts();", true);
    }

    protected void btnExportPdf_Click(object sender, EventArgs e)
    {
        // This is a placeholder. Real PDF export requires a library (e.g., iTextSharp).
        litMessage.Text = "<div class='alert alert-info mt-3'>PDF Export functionality needs to be implemented.</div>";
        // Example with iTextSharp (requires installing iTextSharp NuGet package)
        /*
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=AttendanceReport.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        gvAttendanceReport.RenderControl(hw);
        StringReader sr = new StringReader(sw.ToString());
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
        */
    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        // This is a placeholder. Real Excel export requires a library (e.g., EPPlus).
        litMessage.Text = "<div class='alert alert-info mt-3'>Excel Export functionality needs to be implemented.</div>";
        // Example with EPPlus (requires installing EPPlus NuGet package)
        /*
        using (ExcelPackage excelPackage = new ExcelPackage())
        {
            ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("Attendance Report");
            // Load data into worksheet from GridView or List<AttendanceRecord>
            worksheet.Cells["A1"].LoadFromDataTable(ConvertToDataTable(gvAttendanceReport.DataSource as List<AttendanceRecord>), true);

            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment; filename=AttendanceReport.xlsx");
            Response.BinaryWrite(excelPackage.GetAsByteArray());
            Response.End();
        }
        */
    }

    // Helper to convert List<T> to DataTable for EPPlus if needed
    /*
    private DataTable ConvertToDataTable<T>(List<T> data)
    {
        DataTable dataTable = new DataTable(typeof(T).Name);
        foreach (PropertyInfo prop in typeof(T).GetProperties())
        {
            dataTable.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        }
        foreach (T item in data)
        {
            var values = new object[typeof(T).GetProperties().Length];
            for (int i = 0; i < typeof(T).GetProperties().Length; i++)
            {
                values[i] = typeof(T).GetProperties()[i].GetValue(item, null);
            }
            dataTable.Rows.Add(values);
        }
        return dataTable;
    }
    */
}

// --- Placeholder Classes for Attendance Reports ---
// (These would be in your Model/Service layer, similar to what was discussed for fees/salary)

public class AttendanceRecord
{
    public int EntryID { get; set; } // Unique ID for the attendance entry
    public string Identifier { get; set; } // RollNo for student, EmployeeID for teacher
    public string Name { get; set; } // StudentName or TeacherName
    public DateTime Date { get; set; }
    public string Status { get; set; } // "Present", "Absent", "Late", "Leave"
    public string Remarks { get; set; }
    public string Type { get; set; } // "Student" or "Teacher"
    public string ClassDept { get; set; } // ClassName or DepartmentName
    public string ClassID { get; set; } // For filtering
    public string DepartmentID { get; set; } // For filtering
}

public class ClassInfo
{
    public string ClassID { get; set; }
    public string ClassName { get; set; }
}

public class DepartmentInfo
{
    public string DepartmentID { get; set; }
    public string DepartmentName { get; set; }
}

public class AttendanceService
{
    // Placeholder for your data access layer methods

    public List<ClassInfo> GetAllClasses()
    {
        return new List<ClassInfo>
        {
            new ClassInfo { ClassID = "G1A", ClassName = "Grade 1 - A" },
            new ClassInfo { ClassID = "G1B", ClassName = "Grade 1 - B" },
            new ClassInfo { ClassID = "G5A", ClassName = "Grade 5 - A" },
            new ClassInfo { ClassID = "G8A", ClassName = "Grade 8 - A" },
            new ClassInfo { ClassID = "G10B", ClassName = "Grade 10 - B" }
        };
    }

    public List<DepartmentInfo> GetAllDepartments()
    {
        return new List<DepartmentInfo>
        {
            new DepartmentInfo { DepartmentID = "SCI", DepartmentName = "Science" },
            new DepartmentInfo { DepartmentID = "MATH", DepartmentName = "Math" },
            new DepartmentInfo { DepartmentID = "ART", DepartmentName = "Arts" },
            new DepartmentInfo { DepartmentID = "ADMIN", DepartmentName = "Administration" }
        };
    }

    public List<AttendanceRecord> GetAttendanceRecords(string reportType, string classId, string departmentId, DateTime startDate, DateTime endDate)
    {
        // Simulate fetching attendance data based on filters
        List<AttendanceRecord> dummyRecords = new List<AttendanceRecord>
        {
            // Student Records
            new AttendanceRecord { EntryID = 1, Identifier = "S001", Name = "Alice Smith", Date = DateTime.Now.AddDays(-1), Status = "Present", Remarks = "", Type = "Student", ClassID = "G1A", ClassDept = "Grade 1 - A" },
            new AttendanceRecord { EntryID = 2, Identifier = "S002", Name = "Bob Johnson", Date = DateTime.Now.AddDays(-1), Status = "Absent", Remarks = "Sick", Type = "Student", ClassID = "G1A", ClassDept = "Grade 1 - A" },
            new AttendanceRecord { EntryID = 3, Identifier = "S001", Name = "Alice Smith", Date = DateTime.Now.AddDays(-2), Status = "Late", Remarks = "Traffic", Type = "Student", ClassID = "G1A", ClassDept = "Grade 1 - A" },
            new AttendanceRecord { EntryID = 4, Identifier = "S003", Name = "Charlie Brown", Date = DateTime.Now.AddDays(-1), Status = "Present", Remarks = "", Type = "Student", ClassID = "G1B", ClassDept = "Grade 1 - B" },
            new AttendanceRecord { EntryID = 5, Identifier = "S002", Name = "Bob Johnson", Date = DateTime.Now.AddDays(-3), Status = "Leave", Remarks = "Family event", Type = "Student", ClassID = "G1A", ClassDept = "Grade 1 - A" },
            new AttendanceRecord { EntryID = 6, Identifier = "S004", Name = "Diana Prince", Date = DateTime.Now.AddDays(-1), Status = "Present", Remarks = "", Type = "Student", ClassID = "G5A", ClassDept = "Grade 5 - A" },

            // Teacher Records
            new AttendanceRecord { EntryID = 101, Identifier = "T001", Name = "Mr. David Lee", Date = DateTime.Now.AddDays(-1), Status = "Present", Remarks = "", Type = "Teacher", DepartmentID = "MATH", ClassDept = "Math" },
            new AttendanceRecord { EntryID = 102, Identifier = "T002", Name = "Ms. Emily Chen", Date = DateTime.Now.AddDays(-1), Status = "Absent", Remarks = "Conference", Type = "Teacher", DepartmentID = "SCI", ClassDept = "Science" },
            new AttendanceRecord { EntryID = 103, Identifier = "T001", Name = "Mr. David Lee", Date = DateTime.Now.AddDays(-2), Status = "Present", Remarks = "", Type = "Teacher", DepartmentID = "MATH", ClassDept = "Math" },
            new AttendanceRecord { EntryID = 104, Identifier = "T003", Name = "Dr. Frank White", Date = DateTime.Now.AddDays(-1), Status = "Late", Remarks = "Appointment", Type = "Teacher", DepartmentID = "ADMIN", ClassDept = "Administration" },
        };

        var filteredRecords = dummyRecords.AsQueryable();

        filteredRecords = filteredRecords.Where(r => r.Type == reportType);

        if (reportType == "Student" && !string.IsNullOrEmpty(classId))
        {
            filteredRecords = filteredRecords.Where(r => r.ClassID == classId);
        }
        else if (reportType == "Teacher" && !string.IsNullOrEmpty(departmentId))
        {
            filteredRecords = filteredRecords.Where(r => r.DepartmentID == departmentId);
        }

        filteredRecords = filteredRecords.Where(r => r.Date >= startDate && r.Date <= endDate);

        return filteredRecords.OrderBy(r => r.Date).ThenBy(r => r.Name).ToList();
    }
}