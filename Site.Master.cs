using System;
using System.Web;
using System.Web.UI;

namespace EmployeeManagement
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] != null)
            {
                lblUserName.Text = Session["UserName"].ToString();
            }
            
            // Apply department theme if available
            if (Session["Department"] != null)
            {
                ApplyDepartmentTheme(Session["Department"].ToString());
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void ApplyDepartmentTheme(string department)
        {
            // Check if user has selected a custom theme
            string selectedTheme = Session["CurrentTheme"]?.ToString();
            
            if (!string.IsNullOrEmpty(selectedTheme))
            {
                Page.Theme = selectedTheme;
                return;
            }

            // Otherwise use department default theme
            switch (department.ToLower())
            {
                case "hr":
                    Page.Theme = "HR";
                    break;
                case "it":
                    Page.Theme = "IT";
                    break;
                case "finance":
                    Page.Theme = "Finance";
                    break;
                case "marketing":
                    Page.Theme = "Marketing";
                    break;
                default:
                    Page.Theme = "Default";
                    break;
            }
        }
    }
}