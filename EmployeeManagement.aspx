<%@ Page Title="Employee Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeManagement.aspx.cs" Inherits="EmployeeManagement.EmployeeManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .search-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .employee-details {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .employee-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        
        .info-label {
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }
        
        .info-value {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #f8f9fa;
            border-radius: 0.375rem;
        }
        
        .edit-mode .info-value {
            background: white;
            border: 1px solid #ced4da;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }
        
        .status-active {
            background: #d1e7dd;
            color: #0a3622;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #58151c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="fade-in">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>
                <i class="fas fa-users-cog me-2"></i>Employee Management
            </h2>
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" 
                      CssClass="btn btn-outline-secondary" PostBackUrl="~/Default.aspx" />
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <h4 class="mb-4">
                <i class="fas fa-search me-2"></i>Search Employee
            </h4>
            
            <div class="row">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-id-badge"></i>
                        </span>
                        <asp:TextBox ID="txtSearchEmployeeId" runat="server" 
                                   CssClass="form-control" placeholder="Enter Employee ID (e.g., EMP001)" 
                                   MaxLength="20"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                  CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                    </div>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnClear" runat="server" Text="Clear" 
                              CssClass="btn btn-outline-secondary w-100" OnClick="btnClear_Click" />
                </div>
            </div>
            
            <asp:Panel ID="pnlSearchMessage" runat="server" Visible="false" CssClass="alert mt-3">
                <asp:Label ID="lblSearchMessage" runat="server"></asp:Label>
            </asp:Panel>
        </div>

        <!-- Employee Details Section -->
        <asp:Panel ID="pnlEmployeeDetails" runat="server" Visible="false">
            <div class="employee-details">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4>
                        <i class="fas fa-user me-2"></i>Employee Details
                    </h4>
                    <div>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                  CssClass="btn btn-warning me-2" OnClick="btnEdit_Click" />
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" 
                                  CssClass="btn btn-success me-2" OnClick="btnSave_Click" Visible="false" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                  CssClass="btn btn-secondary" OnClick="btnCancel_Click" Visible="false" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3 text-center">
                        <div class="employee-avatar mx-auto">
                            <asp:Label ID="lblInitials" runat="server"></asp:Label>
                        </div>
                        <div class="status-badge">
                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-label">Employee ID</div>
                                <div class="info-value">
                                    <asp:Label ID="lblEmployeeId" runat="server"></asp:Label>
                                </div>
                                
                                <div class="info-label">First Name</div>
                                <div class="info-value">
                                    <asp:Label ID="lblFirstName" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Last Name</div>
                                <div class="info-value">
                                    <asp:Label ID="lblLastName" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Email</div>
                                <div class="info-value">
                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Phone</div>
                                <div class="info-value">
                                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">Department</div>
                                <div class="info-value">
                                    <asp:Label ID="lblDepartment" runat="server"></asp:Label>
                                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select" Visible="false">
                                        <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                        <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                        <asp:ListItem Text="Finance" Value="Finance"></asp:ListItem>
                                        <asp:ListItem Text="Marketing" Value="Marketing"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                                <div class="info-label">Position</div>
                                <div class="info-value">
                                    <asp:Label ID="lblPosition" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Salary</div>
                                <div class="info-value">
                                    <asp:Label ID="lblSalary" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" TextMode="Number" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Hire Date</div>
                                <div class="info-value">
                                    <asp:Label ID="lblHireDate" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" TextMode="Date" Visible="false"></asp:TextBox>
                                </div>
                                
                                <div class="info-label">Status</div>
                                <div class="info-value">
                                    <asp:CheckBox ID="chkIsActive" runat="server" Text="Active" CssClass="form-check" Visible="false" />
                                </div>
                            </div>
                        </div>
                        
                        <!-- Address Section -->
                        <div class="mt-4">
                            <h5>
                                <i class="fas fa-map-marker-alt me-2"></i>Address
                            </h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-label">Street</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblStreet" runat="server"></asp:Label>
                                        <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                    </div>
                                    
                                    <div class="info-label">City</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblCity" runat="server"></asp:Label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-label">State</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblState" runat="server"></asp:Label>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                    </div>
                                    
                                    <div class="info-label">Zip Code</div>
                                    <div class="info-value">
                                        <asp:Label ID="lblZipCode" runat="server"></asp:Label>
                                        <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- Update Message -->
        <asp:Panel ID="pnlUpdateMessage" runat="server" Visible="false">
            <div class="alert">
                <asp:Label ID="lblUpdateMessage" runat="server"></asp:Label>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        // Auto-focus search box
        document.addEventListener('DOMContentLoaded', function() {
            const searchBox = document.getElementById('<%= txtSearchEmployeeId.ClientID %>');
            if (searchBox && !searchBox.value) {
                searchBox.focus();
            }
        });

        // Validate salary input
        function validateSalary() {
            const salaryInput = document.getElementById('<%= txtSalary.ClientID %>');
            if (salaryInput && salaryInput.style.display !== 'none') {
                const value = parseFloat(salaryInput.value);
                if (isNaN(value) || value < 0) {
                    alert('Please enter a valid salary amount.');
                    salaryInput.focus();
                    return false;
                }
            }
            return true;
        }

        // Add client-side validation
        document.addEventListener('DOMContentLoaded', function() {
            const saveButton = document.getElementById('<%= btnSave.ClientID %>');
            if (saveButton) {
                saveButton.onclick = function() {
                    return validateSalary();
                };
            }
        });
    </script>
</asp:Content>