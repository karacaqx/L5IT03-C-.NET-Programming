using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using EmployeeManagement.Data;

namespace EmployeeManagement
{
    public partial class EmployeeManagement : Page
    {
        private Employee CurrentEmployee
        {
            get { return ViewState["CurrentEmployee"] as Employee; }
            set { ViewState["CurrentEmployee"] = value; }
        }

        private bool IsEditMode
        {
            get { return ViewState["IsEditMode"] != null && (bool)ViewState["IsEditMode"]; }
            set { ViewState["IsEditMode"] = value; }
        }

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
                // Check if employee ID was passed in query string
                string employeeId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(employeeId))
                {
                    txtSearchEmployeeId.Text = employeeId;
                    SearchEmployee(employeeId);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string employeeId = txtSearchEmployeeId.Text.Trim();
            if (string.IsNullOrEmpty(employeeId))
            {
                ShowSearchMessage("Please enter an Employee ID.", "warning");
                return;
            }

            SearchEmployee(employeeId);
        }

        private void SearchEmployee(string employeeId)
        {
            try
            {
                JsonDatabase db = new JsonDatabase();
                Employee employee = db.GetEmployeeById(employeeId);

                if (employee != null)
                {
                    CurrentEmployee = employee;
                    DisplayEmployee(employee);
                    pnlEmployeeDetails.Visible = true;
                    pnlSearchMessage.Visible = false;
                    pnlUpdateMessage.Visible = false;
                }
                else
                {
                    ShowSearchMessage("Employee not found. Please check the Employee ID and try again.", "danger");
                    pnlEmployeeDetails.Visible = false;
                }
            }
            catch (Exception ex)
            {
                ShowSearchMessage("An error occurred while searching. Please try again.", "danger");
                System.Diagnostics.Debug.WriteLine("Search Error: " + ex.Message);
            }
        }

        private void DisplayEmployee(Employee employee)
        {
            // Basic Information
            lblEmployeeId.Text = employee.EmployeeId;
            lblFirstName.Text = employee.FirstName;
            lblLastName.Text = employee.LastName;
            lblEmail.Text = employee.Email;
            lblPhone.Text = employee.Phone;
            lblDepartment.Text = employee.Department;
            lblPosition.Text = employee.Position;
            lblSalary.Text = employee.Salary.ToString("C");
            lblHireDate.Text = employee.HireDate.ToString("MMM dd, yyyy");

            // Address
            if (employee.Address != null)
            {
                lblStreet.Text = employee.Address.Street ?? "";
                lblCity.Text = employee.Address.City ?? "";
                lblState.Text = employee.Address.State ?? "";
                lblZipCode.Text = employee.Address.ZipCode ?? "";
            }

            // Status
            lblStatus.Text = employee.IsActive ? "Active" : "Inactive";
            lblStatus.CssClass = employee.IsActive ? "status-badge status-active" : "status-badge status-inactive";

            // Employee initials for avatar
            string initials = "";
            if (!string.IsNullOrEmpty(employee.FirstName))
                initials += employee.FirstName[0];
            if (!string.IsNullOrEmpty(employee.LastName))
                initials += employee.LastName[0];
            lblInitials.Text = initials.ToUpper();

            // Set edit form values
            SetEditFormValues(employee);

            // Reset edit mode
            SetEditMode(false);
        }

        private void SetEditFormValues(Employee employee)
        {
            txtFirstName.Text = employee.FirstName;
            txtLastName.Text = employee.LastName;
            txtEmail.Text = employee.Email;
            txtPhone.Text = employee.Phone;
            ddlDepartment.SelectedValue = employee.Department;
            txtPosition.Text = employee.Position;
            txtSalary.Text = employee.Salary.ToString();
            txtHireDate.Text = employee.HireDate.ToString("yyyy-MM-dd");
            chkIsActive.Checked = employee.IsActive;

            if (employee.Address != null)
            {
                txtStreet.Text = employee.Address.Street ?? "";
                txtCity.Text = employee.Address.City ?? "";
                txtState.Text = employee.Address.State ?? "";
                txtZipCode.Text = employee.Address.ZipCode ?? "";
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (CurrentEmployee != null)
            {
                // Check if user can edit this employee (same department or admin privileges)
                string userDept = Session["Department"].ToString();
                if (!userDept.Equals(CurrentEmployee.Department, StringComparison.OrdinalIgnoreCase))
                {
                    ShowUpdateMessage("You can only edit employees from your department.", "warning");
                    return;
                }

                SetEditMode(true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (CurrentEmployee != null && IsEditMode)
            {
                try
                {
                    // Validate input
                    if (!ValidateInput())
                        return;

                    // Update employee object
                    CurrentEmployee.FirstName = txtFirstName.Text.Trim();
                    CurrentEmployee.LastName = txtLastName.Text.Trim();
                    CurrentEmployee.Email = txtEmail.Text.Trim();
                    CurrentEmployee.Phone = txtPhone.Text.Trim();
                    CurrentEmployee.Department = ddlDepartment.SelectedValue;
                    CurrentEmployee.Position = txtPosition.Text.Trim();
                    CurrentEmployee.Salary = decimal.Parse(txtSalary.Text);
                    CurrentEmployee.HireDate = DateTime.Parse(txtHireDate.Text);
                    CurrentEmployee.IsActive = chkIsActive.Checked;

                    // Update address
                    if (CurrentEmployee.Address == null)
                        CurrentEmployee.Address = new Address();

                    CurrentEmployee.Address.Street = txtStreet.Text.Trim();
                    CurrentEmployee.Address.City = txtCity.Text.Trim();
                    CurrentEmployee.Address.State = txtState.Text.Trim();
                    CurrentEmployee.Address.ZipCode = txtZipCode.Text.Trim();

                    // Save to database
                    JsonDatabase db = new JsonDatabase();
                    if (db.UpdateEmployee(CurrentEmployee))
                    {
                        DisplayEmployee(CurrentEmployee);
                        ShowUpdateMessage("Employee information updated successfully!", "success");
                    }
                    else
                    {
                        ShowUpdateMessage("Failed to update employee information. Please try again.", "danger");
                    }
                }
                catch (Exception ex)
                {
                    ShowUpdateMessage("An error occurred while saving. Please check your input and try again.", "danger");
                    System.Diagnostics.Debug.WriteLine("Save Error: " + ex.Message);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (CurrentEmployee != null)
            {
                // Reset form values
                SetEditFormValues(CurrentEmployee);
                SetEditMode(false);
                pnlUpdateMessage.Visible = false;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearchEmployeeId.Text = "";
            pnlEmployeeDetails.Visible = false;
            pnlSearchMessage.Visible = false;
            pnlUpdateMessage.Visible = false;
            CurrentEmployee = null;
            IsEditMode = false;
        }

        private void SetEditMode(bool editMode)
        {
            IsEditMode = editMode;

            // Toggle visibility of labels and textboxes
            lblFirstName.Visible = !editMode;
            txtFirstName.Visible = editMode;
            
            lblLastName.Visible = !editMode;
            txtLastName.Visible = editMode;
            
            lblEmail.Visible = !editMode;
            txtEmail.Visible = editMode;
            
            lblPhone.Visible = !editMode;
            txtPhone.Visible = editMode;
            
            lblDepartment.Visible = !editMode;
            ddlDepartment.Visible = editMode;
            
            lblPosition.Visible = !editMode;
            txtPosition.Visible = editMode;
            
            lblSalary.Visible = !editMode;
            txtSalary.Visible = editMode;
            
            lblHireDate.Visible = !editMode;
            txtHireDate.Visible = editMode;
            
            lblStreet.Visible = !editMode;
            txtStreet.Visible = editMode;
            
            lblCity.Visible = !editMode;
            txtCity.Visible = editMode;
            
            lblState.Visible = !editMode;
            txtState.Visible = editMode;
            
            lblZipCode.Visible = !editMode;
            txtZipCode.Visible = editMode;
            
            chkIsActive.Visible = editMode;

            // Toggle buttons
            btnEdit.Visible = !editMode;
            btnSave.Visible = editMode;
            btnCancel.Visible = editMode;

            // Add edit mode CSS class
            if (editMode)
            {
                pnlEmployeeDetails.CssClass = "employee-details edit-mode";
            }
            else
            {
                pnlEmployeeDetails.CssClass = "employee-details";
            }
        }

        private bool ValidateInput()
        {
            if (string.IsNullOrEmpty(txtFirstName.Text.Trim()) ||
                string.IsNullOrEmpty(txtLastName.Text.Trim()) ||
                string.IsNullOrEmpty(txtEmail.Text.Trim()) ||
                string.IsNullOrEmpty(txtPosition.Text.Trim()))
            {
                ShowUpdateMessage("Please fill in all required fields (First Name, Last Name, Email, Position).", "warning");
                return false;
            }

            if (!decimal.TryParse(txtSalary.Text, out decimal salary) || salary < 0)
            {
                ShowUpdateMessage("Please enter a valid salary amount.", "warning");
                return false;
            }

            if (!DateTime.TryParse(txtHireDate.Text, out DateTime hireDate))
            {
                ShowUpdateMessage("Please enter a valid hire date.", "warning");
                return false;
            }

            return true;
        }

        private void ShowSearchMessage(string message, string type)
        {
            lblSearchMessage.Text = message;
            pnlSearchMessage.CssClass = $"alert alert-{type} mt-3";
            pnlSearchMessage.Visible = true;
        }

        private void ShowUpdateMessage(string message, string type)
        {
            lblUpdateMessage.Text = message;
            pnlUpdateMessage.CssClass = $"alert alert-{type}";
            pnlUpdateMessage.Visible = true;
        }
    }
}