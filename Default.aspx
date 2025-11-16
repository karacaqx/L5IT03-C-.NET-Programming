<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EmployeeManagement.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .welcome-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .quick-action-card {
            transition: all 0.3s ease;
            border: none;
            border-radius: 15px;
        }
        
        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="fade-in">
        <!-- Welcome Section -->
        <div class="welcome-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="fas fa-tachometer-alt me-3"></i>Dashboard
                    </h1>
                    <p class="lead mb-2">Welcome back, <asp:Label ID="lblWelcomeName" runat="server"></asp:Label>!</p>
                    <p class="mb-0">
                        <i class="fas fa-building me-2"></i>
                        <span class="department-badge">
                            <asp:Label ID="lblDepartment" runat="server"></asp:Label> Department
                        </span>
                    </p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-chart-line" style="font-size: 4rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>

        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-primary me-3">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <h3 class="mb-1">
                            <asp:Label ID="lblTotalEmployees" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="text-muted mb-0">Total Employees</p>
                    </div>
                </div>
            </div>

            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-success me-3">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div>
                        <h3 class="mb-1">
                            <asp:Label ID="lblDeptEmployees" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="text-muted mb-0">Department Employees</p>
                    </div>
                </div>
            </div>

            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-warning me-3">
                        <i class="fas fa-calendar-plus"></i>
                    </div>
                    <div>
                        <h3 class="mb-1">
                            <asp:Label ID="lblNewHires" runat="server" Text="0"></asp:Label>
                        </h3>
                        <p class="text-muted mb-0">Recent Hires (30 days)</p>
                    </div>
                </div>
            </div>

            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-info me-3">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div>
                        <h3 class="mb-1">
                            <asp:Label ID="lblAvgSalary" runat="server" Text="$0"></asp:Label>
                        </h3>
                        <p class="text-muted mb-0">Average Salary</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row">
            <div class="col-12">
                <h3 class="mb-4">
                    <i class="fas fa-bolt me-2"></i>Quick Actions
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card quick-action-card h-100">
                    <div class="card-body text-center">
                        <div class="stats-icon bg-primary mx-auto mb-3">
                            <i class="fas fa-search"></i>
                        </div>
                        <h5 class="card-title">Find Employee</h5>
                        <p class="card-text">Search and view employee information by ID or name.</p>
                        <asp:Button ID="btnSearchEmployee" runat="server" Text="Search Employees" 
                                  CssClass="btn btn-primary" PostBackUrl="~/EmployeeManagement.aspx" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card quick-action-card h-100">
                    <div class="card-body text-center">
                        <div class="stats-icon bg-success mx-auto mb-3">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <h5 class="card-title">Add Employee</h5>
                        <p class="card-text">Add new employee to the system with complete details.</p>
                        <asp:Button ID="btnAddEmployee" runat="server" Text="Add New Employee" 
                                  CssClass="btn btn-success" PostBackUrl="~/EmployeeManagement.aspx?action=add" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card quick-action-card h-100">
                    <div class="card-body text-center">
                        <div class="stats-icon bg-info mx-auto mb-3">
                            <i class="fas fa-list"></i>
                        </div>
                        <h5 class="card-title">View All</h5>
                        <p class="card-text">View and manage all employees in your department.</p>
                        <asp:Button ID="btnViewAll" runat="server" Text="View All Employees" 
                                  CssClass="btn btn-info" PostBackUrl="~/EmployeeManagement.aspx?view=all" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-clock me-2"></i>Recent Department Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvRecentEmployees" runat="server" CssClass="table table-striped table-hover" 
                                    AutoGenerateColumns="false" EmptyDataText="No recent employees found.">
                            <Columns>
                                <asp:BoundField DataField="EmployeeId" HeaderText="Employee ID" />
                                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                                <asp:BoundField DataField="Position" HeaderText="Position" />
                                <asp:BoundField DataField="HireDate" HeaderText="Hire Date" DataFormatString="{0:MMM dd, yyyy}" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:HyperLink runat="server" 
                                                     NavigateUrl='<%# "~/EmployeeManagement.aspx?id=" + Eval("EmployeeId") %>'
                                                     CssClass="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-eye me-1"></i>View
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="text-center text-muted" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        // Add fade-in animation
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('.fade-in').style.animation = 'fadeIn 0.8s ease-in-out';
        });
    </script>
</asp:Content>