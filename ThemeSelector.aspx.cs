using System;
using System.Web;
using System.Web.UI;

namespace EmployeeManagement
{
    public partial class ThemeSelector : Page
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
                // Display current theme
                string currentTheme = Session["CurrentTheme"]?.ToString() ?? Session["Department"]?.ToString() ?? "Default";
                lblCurrentTheme.Text = currentTheme;
            }
        }

        protected void btnSelectTheme_Click(object sender, EventArgs e)
        {
            try
            {
                var button = sender as System.Web.UI.WebControls.Button;
                string selectedTheme = button.CommandArgument;

                // Save selected theme to session
                Session["CurrentTheme"] = selectedTheme;
                
                // Update current theme display
                lblCurrentTheme.Text = selectedTheme;

                // Show success message
                ShowMessage($"Theme changed to {selectedTheme} successfully! The new theme will be applied on your next page load.", "success");

                // Redirect to apply theme immediately
                string script = @"
                    setTimeout(function() {
                        window.location.href = 'Default.aspx';
                    }, 2000);
                ";
                ClientScript.RegisterStartupScript(this.GetType(), "ApplyTheme", script, true);
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred while changing the theme. Please try again.", "danger");
                System.Diagnostics.Debug.WriteLine("Theme Change Error: " + ex.Message);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessage.CssClass = $"alert alert-{type}";
            pnlMessage.Visible = true;
        }
    }
}