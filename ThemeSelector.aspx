<%@ Page Title="Theme Selector" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThemeSelector.aspx.cs" Inherits="EmployeeManagement.ThemeSelector" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .theme-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
            margin-bottom: 1.5rem;
        }
        
        .theme-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }
        
        .theme-card.selected {
            border: 3px solid #007bff;
            transform: translateY(-3px);
        }
        
        .theme-preview {
            height: 100px;
            border-radius: 15px 15px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .theme-default { background: linear-gradient(135deg, #0d6efd 0%, #0b5ed7 100%); }
        .theme-hr { background: linear-gradient(135deg, #198754 0%, #157347 100%); }
        .theme-it { background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%); }
        .theme-finance { background: linear-gradient(135deg, #fd7e14 0%, #e8590c 100%); }
        .theme-marketing { background: linear-gradient(135deg, #d63384 0%, #b02a5b 100%); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>
                <i class="fas fa-palette me-2"></i>Choose Your Theme
            </h2>
            <asp:Button ID="btnBack" runat="server" Text="Back" 
                      CssClass="btn btn-outline-secondary" OnClick="btnBack_Click" />
        </div>

        <div class="row">
            <div class="col-12">
                <p class="lead mb-4">Select a theme that matches your department or personal preference.</p>
            </div>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </asp:Panel>

        <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card theme-card" onclick="selectTheme('Default')">
                    <div class="theme-preview theme-default">
                        <i class="fas fa-desktop me-2"></i>Default
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">Default Blue</h5>
                        <p class="card-text text-muted">Classic professional blue theme</p>
                        <asp:Button ID="btnSelectDefault" runat="server" Text="Select" 
                                  CssClass="btn btn-outline-primary btn-sm" 
                                  OnClick="btnSelectTheme_Click" CommandArgument="Default" />
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card theme-card" onclick="selectTheme('HR')">
                    <div class="theme-preview theme-hr">
                        <i class="fas fa-users me-2"></i>HR
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">HR Green</h5>
                        <p class="card-text text-muted">Fresh green theme for Human Resources</p>
                        <asp:Button ID="btnSelectHR" runat="server" Text="Select" 
                                  CssClass="btn btn-outline-success btn-sm" 
                                  OnClick="btnSelectTheme_Click" CommandArgument="HR" />
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card theme-card" onclick="selectTheme('IT')">
                    <div class="theme-preview theme-it">
                        <i class="fas fa-code me-2"></i>IT
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">IT Purple</h5>
                        <p class="card-text text-muted">Tech-inspired purple theme for IT</p>
                        <asp:Button ID="btnSelectIT" runat="server" Text="Select" 
                                  CssClass="btn btn-outline-dark btn-sm" 
                                  OnClick="btnSelectTheme_Click" CommandArgument="IT" />
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card theme-card" onclick="selectTheme('Finance')">
                    <div class="theme-preview theme-finance">
                        <i class="fas fa-chart-line me-2"></i>Finance
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">Finance Orange</h5>
                        <p class="card-text text-muted">Warm orange theme for Finance</p>
                        <asp:Button ID="btnSelectFinance" runat="server" Text="Select" 
                                  CssClass="btn btn-outline-warning btn-sm" 
                                  OnClick="btnSelectTheme_Click" CommandArgument="Finance" />
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="card theme-card" onclick="selectTheme('Marketing')">
                    <div class="theme-preview theme-marketing">
                        <i class="fas fa-bullhorn me-2"></i>Marketing
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">Marketing Pink</h5>
                        <p class="card-text text-muted">Creative pink theme for Marketing</p>
                        <asp:Button ID="btnSelectMarketing" runat="server" Text="Select" 
                                  CssClass="btn btn-outline-danger btn-sm" 
                                  OnClick="btnSelectTheme_Click" CommandArgument="Marketing" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h5>
                            <i class="fas fa-info-circle me-2"></i>Current Theme
                        </h5>
                        <p class="mb-2">
                            You are currently using the <strong><asp:Label ID="lblCurrentTheme" runat="server"></asp:Label></strong> theme.
                        </p>
                        <p class="text-muted mb-0">
                            <i class="fas fa-lightbulb me-1"></i>
                            Tip: Choose a theme that matches your department for a personalized experience!
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function selectTheme(themeName) {
            // Remove selected class from all cards
            document.querySelectorAll('.theme-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            event.currentTarget.classList.add('selected');
        }

        // Highlight current theme on page load
        document.addEventListener('DOMContentLoaded', function() {
            const currentTheme = '<%= Session["CurrentTheme"] ?? Session["Department"] ?? "Default" %>';
            const themeCards = document.querySelectorAll('.theme-card');
            
            themeCards.forEach(card => {
                const themeName = card.querySelector('button').getAttribute('commandargument');
                if (themeName === currentTheme) {
                    card.classList.add('selected');
                }
            });
        });

        // Add fade-in animation
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('.fade-in').style.animation = 'fadeIn 0.8s ease-in-out';
        });
    </script>
</asp:Content>