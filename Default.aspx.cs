using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using EmployeeManagement.Data;

namespace EmployeeManagement
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserName"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                // Set welcome message
                lblWelcomeName.Text = Session["UserName"].ToString();
                lblDepartment.Text = Session["Department"].ToString();

                JsonDatabase db = new JsonDatabase();
                
                // Get all employees
                List<Employee> allEmployees = db.GetAllEmployees();
                
                // Get department employees
                string userDepartment = Session["Department"].ToString();
                List<Employee> deptEmployees = db.GetEmployeesByDepartment(userDepartment);

                // Calculate statistics
                lblTotalEmployees.Text = allEmployees.Count.ToString();
                lblDeptEmployees.Text = deptEmployees.Count.ToString();

                // Recent hires (last 30 days)
                DateTime thirtyDaysAgo = DateTime.Now.AddDays(-30);
                int recentHires = allEmployees.Count(e => e.HireDate >= thirtyDaysAgo);
                lblNewHires.Text = recentHires.ToString();

                // Average salary for department
                if (deptEmployees.Count > 0)
                {
                    decimal avgSalary = deptEmployees.Average(e => e.Salary);
                    lblAvgSalary.Text = avgSalary.ToString("C0");
                }
                else
                {
                    lblAvgSalary.Text = "$0";
                }

                // Load recent department employees (last 5)
                var recentDeptEmployees = deptEmployees
                    .OrderByDescending(e => e.HireDate)
                    .Take(5)
                    .ToList();

                gvRecentEmployees.DataSource = recentDeptEmployees;
                gvRecentEmployees.DataBind();
            }
            catch (Exception ex)
            {
                // Handle error
                System.Diagnostics.Debug.WriteLine("Dashboard Load Error: " + ex.Message);
            }
        }
    }
}