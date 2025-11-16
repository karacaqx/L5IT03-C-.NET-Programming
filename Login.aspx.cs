using System;
using System.Web;
using System.Web.UI;
using EmployeeManagement.Data;

namespace EmployeeManagement
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["UserName"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    JsonDatabase db = new JsonDatabase();
                    Admin admin = db.ValidateAdmin(txtUsername.Text.Trim(), txtPassword.Text.Trim());

                    if (admin != null && admin.Department.Equals(ddlDepartment.SelectedValue, StringComparison.OrdinalIgnoreCase))
                    {
                        // Successful login
                        Session["UserName"] = admin.FullName;
                        Session["Department"] = admin.Department;
                        Session["AdminId"] = admin.Id;
                        Session["Username"] = admin.Username;

                        // Client-side redirect with theme application
                        string script = $@"
                            showLoading();
                            setTimeout(function() {{
                                window.location.href = 'Default.aspx';
                            }}, 1000);
                        ";
                        ClientScript.RegisterStartupScript(this.GetType(), "LoginSuccess", script, true);
                    }
                    else
                    {
                        ShowMessage("Invalid username, password, or department. Please try again.", "danger");
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("An error occurred during login. Please try again later.", "danger");
                    // Log error in production
                    System.Diagnostics.Debug.WriteLine("Login Error: " + ex.Message);
                }
            }
        }

        private void ShowMessage(string message, string type = "info")
        {
            lblMessage.Text = message;
            pnlMessage.CssClass = $"alert alert-{type} alert-custom";
            pnlMessage.Visible = true;
        }
    }
}