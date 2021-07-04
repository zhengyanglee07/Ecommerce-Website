<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLoginDesign.aspx.cs" Inherits="Assignment.AdminLoginDesign" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <!DOCTYPE html>

    <body>
            
        <div class="main">
            <!-- Sing in  Form -->
            <section class="sign-in">
                <div class="container">
                    <div class="signin-content">
                        <div class="signin-image">
                            <figure>
                                <img src="../images/adminbee.jpg" alt="sing up image"></figure>
                            <a href="LoginDesign.aspx" class="signup-image-link">Back to normal Login Page</a>
                        </div>

                        <div class="signin-form">
                            <h2 class="form-title">ShopBee Admin Login</h2>
                            <form method="POST" class="register-form" id="login-form">
                                <div class="form-group">
                                    <label for="your_name" style="padding-bottom: 20px;"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <asp:TextBox ID="txtname" runat="server" placeholder="Admin name" CssClass="input"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Admin name." ControlToValidate="txtname" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label for="your_pass" style="padding-bottom: 50px;"><i class="zmdi zmdi-lock"></i></label>
                                    <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" placeholder="Admin Password" CssClass="input"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter Admin password." ControlToValidate="txtpassword" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvNotMatched" runat="server" ErrorMessage="[Password] and [Username] not matched" ControlToValidate="txtPassword" ForeColor="Red"></asp:CustomValidator>
                                </div>

                                <div class="form-group form-button">
                                    <asp:Button ID="btnlogin" runat="server" Text="Login" OnClick="btnlogin_Click" BackColor="Yellow" BorderColor="#FFCC00" CssClass="input" ></asp:Button>
                                </div>
                                <br />
                                <center>
                                <div ID="recapthca" class="g-recaptcha" data-sitekey="6LfyTnkaAAAAAG4jjEwz5ouYHPTbazKSlaZrvimM" data-theme="dark">
                                </div>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please Make Sure You Have Tick Recaptcha" ForeColor="Red"></asp:CustomValidator>
                            </center>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>
    </body>
    </html>
</asp:Content>
