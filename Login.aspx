<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EmployeeManagement.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Employee Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="~/Styles/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-4">
                        <div class="card login-card">
                            <div class="login-header">
                                <i class="fas fa-users"></i>
                                <h3>Employee Management</h3>
                                <p class="mb-0">Department Admin Login</p>
                            </div>
                            <div class="card-body p-4">
                                <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-custom">
                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                </asp:Panel>

                                <div class="mb-3">
                                    <div class="form-floating">
                                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" 
                                                   placeholder="Username" MaxLength="50"></asp:TextBox>
                                        <label for="txtUsername">
                                            <i class="fas fa-user me-2"></i>Username
                                        </label>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                                              ControlToValidate="txtUsername" 
                                                              ErrorMessage="Username is required"
                                                              CssClass="field-validation-error" 
                                                              Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="mb-3">
                                    <div class="form-floating">
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                                   CssClass="form-control" placeholder="Password" MaxLength="50"></asp:TextBox>
                                        <label for="txtPassword">
                                            <i class="fas fa-lock me-2"></i>Password
                                        </label>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                                              ControlToValidate="txtPassword" 
                                                              ErrorMessage="Password is required"
                                                              CssClass="field-validation-error" 
                                                              Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="mb-3">
                                    <div class="form-floating">
                                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Select Department" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Human Resources" Value="HR"></asp:ListItem>
                                            <asp:ListItem Text="Information Technology" Value="IT"></asp:ListItem>
                                            <asp:ListItem Text="Finance" Value="Finance"></asp:ListItem>
                                            <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                        </asp:DropDownList>
                                        <label for="ddlDepartment">
                                            <i class="fas fa-building me-2"></i>Department
                                        </label>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" 
                                                              ControlToValidate="ddlDepartment" 
                                                              InitialValue=""
                                                              ErrorMessage="Please select a department"
                                                              CssClass="field-validation-error" 
                                                              Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="d-grid">
                                    <asp:Button ID="btnLogin" runat="server" Text="Login" 
                                              CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                                </div>

                                <div class="loading" id="loading">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                    <p class="mt-2">Authenticating...</p>
                                </div>
                            </div>
                        </div>

                        <!-- Demo Credentials -->
                        <div class="mt-4">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">
                                        <i class="fas fa-info-circle me-2"></i>Demo Credentials
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <small class="text-muted">
                                        <strong>HR:</strong> hr_admin / hr123<br>
                                        <strong>IT:</strong> it_admin / it123<br>
                                        <strong>Finance:</strong> finance_admin / finance123<br>
                                        <strong>Marketing:</strong> marketing_admin / marketing123
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
        function showLoading() {
            document.getElementById('loading').classList.add('show');
            document.getElementById('<%= btnLogin.ClientID %>').disabled = true;
        }

        function hideLoading() {
            document.getElementById('loading').classList.remove('show');
            document.getElementById('<%= btnLogin.ClientID %>').disabled = false;
        }

        // Auto-fill demo credentials
        function fillDemo(username, password, department) {
            document.getElementById('<%= txtUsername.ClientID %>').value = username;
            document.getElementById('<%= txtPassword.ClientID %>').value = password;
            document.getElementById('<%= ddlDepartment.ClientID %>').value = department;
        }

        // Add click events to demo credentials
        document.addEventListener('DOMContentLoaded', function() {
            const demoCard = document.querySelector('.card-body small');
            if (demoCard) {
                demoCard.innerHTML = demoCard.innerHTML
                    .replace(/hr_admin \/ hr123/, '<a href="#" onclick="fillDemo(\'hr_admin\', \'hr123\', \'HR\'); return false;" class="text-decoration-none">hr_admin / hr123</a>')
                    .replace(/it_admin \/ it123/, '<a href="#" onclick="fillDemo(\'it_admin\', \'it123\', \'IT\'); return false;" class="text-decoration-none">it_admin / it123</a>')
                    .replace(/finance_admin \/ finance123/, '<a href="#" onclick="fillDemo(\'finance_admin\', \'finance123\', \'Finance\'); return false;" class="text-decoration-none">finance_admin / finance123</a>')
                    .replace(/marketing_admin \/ marketing123/, '<a href="#" onclick="fillDemo(\'marketing_admin\', \'marketing123\', \'Marketing\'); return false;" class="text-decoration-none">marketing_admin / marketing123</a>');
            }
        });
    </script>
</body>
</html>