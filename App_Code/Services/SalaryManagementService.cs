using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// Summary description for SalaryManagementService
/// </summary>
public class SalaryManagementService
{
    // -------- Data for payroll (page: processpayroll) --------
    private List<Teacher> teachers = new List<Teacher>
    {
        new Teacher { TeacherID = 1, TeacherName = "John Smith", Department = "Math" },
        new Teacher { TeacherID = 2, TeacherName = "Jane Doe", Department = "Science" },
        new Teacher { TeacherID = 3, TeacherName = "Sam Wilson", Department = "English" }
    };

    private List<TeacherSalary> teacherSalaries = new List<TeacherSalary>
    {
        new TeacherSalary { TeacherID = 1, TeacherName = "John Smith", BaseSalary = 30000, Allowances = 5000, Deductions = 2000 },
        new TeacherSalary { TeacherID = 2, TeacherName = "Jane Doe", BaseSalary = 32000, Allowances = 4000, Deductions = 1500 }
    };


    // -------- C# 5 compatible methods --------
    public List<Teacher> GetAllTeachers()
    {
        return teachers;
    }

    public TeacherSalary GetTeacherSalaryById(int id)
    {
        return teacherSalaries.FirstOrDefault(t => t.TeacherID == id);
    }


    // -------- Payroll summary logic --------
    public PayrollSummary GetPayrollSummary(int month, int year)
    {
        var configured = teachers
            .Select(t => GetTeacherSalaryById(t.TeacherID))
            .Where(s => s != null)
            .ToList();

        int totalTeachers = teachers.Count;
        int configuredTeachers = configured.Count;
        int unconfigured = totalTeachers - configuredTeachers;

        decimal estimatedPayout = configured.Sum(s => s.BaseSalary + s.Allowances - s.Deductions);
        int alreadyProcessed = new Random().Next(0, configuredTeachers / 2);

        return new PayrollSummary
        {
            TeachersForPayout = configuredTeachers - alreadyProcessed,
            EstimatedTotalPayout = estimatedPayout,
            UnconfiguredSalaries = unconfigured,
            AlreadyProcessed = alreadyProcessed
        };
    }


    public PayrollResult ProcessMonthlyPayroll(int month, int year)
    {
        var summary = GetPayrollSummary(month, year);

        if (summary.TeachersForPayout == 0)
        {
            return new PayrollResult
            {
                Success = false,
                TeachersProcessed = 0,
                ErrorMessage = "No teachers found to process payroll."
            };
        }

        System.Threading.Thread.Sleep(1000);

        return new PayrollResult
        {
            Success = true,
            TeachersProcessed = summary.TeachersForPayout
        };
    }


    // -------- Salary Listing Page (salary.aspx.cs) --------
    public List<TeacherSalaryView> GetTeacherSalaries(string dept, string status, string search)
    {
        List<TeacherSalaryView> all = new List<TeacherSalaryView>
        {
            new TeacherSalaryView { TeacherID=1001, TeacherName="Anjali Sharma", Department="Mathematics", BaseSalary=4000, Allowances=500, Deductions=100, NetSalary=4400, Status="Paid", LastPaymentDate=DateTime.Now.AddDays(-5) },
            new TeacherSalaryView { TeacherID=1002, TeacherName="Rajesh Kumar", Department="Science", BaseSalary=4500, Allowances=600, Deductions=150, NetSalary=4950, Status="Paid", LastPaymentDate=DateTime.Now.AddMonths(-1) },
            new TeacherSalaryView { TeacherID=1003, TeacherName="Deepika Padukone", Department="English", BaseSalary=3800, Allowances=400, Deductions=80, NetSalary=4120, Status="Pending" },
            new TeacherSalaryView { TeacherID=1004, TeacherName="Amir Khan", Department="History", BaseSalary=4200, Allowances=550, Deductions=120, NetSalary=4630, Status="Processed" },
            new TeacherSalaryView { TeacherID=1005, TeacherName="Priya Singh", Department="Computer Science", BaseSalary=4800, Allowances=700, Deductions=200, NetSalary=5300, Status="On Hold" },
            new TeacherSalaryView { TeacherID=1006, TeacherName="Amitabh Bachchan", Department="Arts", BaseSalary=5000, Allowances=800, Deductions=250, NetSalary=5550, Status="Paid", LastPaymentDate=DateTime.Now.AddDays(-10) }
        };

        var q = all.AsQueryable();

        if (!string.IsNullOrEmpty(dept))
            q = q.Where(s => s.Department == dept);

        if (!string.IsNullOrEmpty(status))
            q = q.Where(s => s.Status == status);

        if (!string.IsNullOrEmpty(search))
        {
            string low = search.ToLower();
            q = q.Where(s =>
                (s.TeacherName != null && s.TeacherName.ToLower().Contains(low)) ||
                s.TeacherID.ToString().Contains(low));
        }

        return q.ToList();
    }


    public List<Teacher> SearchTeachers(string searchTerm)
    {
        searchTerm = searchTerm.ToLower();

        return teachers
            .Where(t =>
                t.TeacherName.ToLower().Contains(searchTerm) ||
                t.TeacherID.ToString().Contains(searchTerm))
            .ToList();
    }


    public void SaveTeacherSalary(TeacherSalary salary)
    {
        var existing = teacherSalaries.FirstOrDefault(s => s.TeacherID == salary.TeacherID);
        if (existing != null)
        {
            existing.BaseSalary = salary.BaseSalary;
            existing.Allowances = salary.Allowances;
            existing.Deductions = salary.Deductions;
        }
        else
        {
            teacherSalaries.Add(salary);
        }
    }


    // -------- Old-style non-expression C# 5 methods --------
    public decimal GetTotalMonthlyPayout()
    {
        return 85000;
    }

    public decimal GetSalariesPaidCurrentMonth()
    {
        return 62000;
    }

    public decimal GetSalariesPending()
    {
        return 23000;
    }

    public int GetTotalTeachersCount()
    {
        return 25;
    }
}
