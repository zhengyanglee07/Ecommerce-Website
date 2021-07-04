<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginDesign.aspx.cs" Inherits="Assignment.LoginDesign" MasterPageFile="~/Site1.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
<!DOCTYPE html>
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v10.0&appId=1498570737017394&autoLogAppEvents=1" nonce="XOlkoQN9"></script>
    <script>
        window.fbAsyncInit = function () {
            FB.init({
                appId: '1498570737017394',
                cookie: true,
                xfbml: true,
                version: 'v10.0'
            });


            FB.getLoginStatus(function (response) {
                statusChangeCallback(response);
            });

        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        function statusChangeCallback(response) {
            if (response.status === 'connected') {
                console.log('Logged in');
                testAPI();
            } else {
                console.log('Not logged in');
            }
        }


        function checkLoginState() {
            FB.getLoginStatus(function (response) {
                statusChangeCallback(response);
            });
        }

        function testAPI() {
            FB.api('/me?fields=name,email', function (response) {
                if (response && !response.error) {
                    //console.log(response);

                    buildProfile(response);
                }
            })
        }

        function buildProfile(user) {
            let txtname = `${user.name}`;


            document.getElementById("<%=txtname.ClientID %>").value = txtname;


        }

        function logout() {
            FB.logout(function (response) {
            });
        }
    </script>
        <div class="main">
        <!-- Sing in  Form -->
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img src="../images/bee-laptop-decal.jpg" alt="sing up image"></figure>
                        <a href="RegisterDesignFacebook.aspx" class="signup-image-link">Create an account</a>
                        <a href="AdminLoginDesign.aspx" class="signup-image-link">Admin Login</a>

                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">ShopBee Login</h2>
                        <form method="POST" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="your_name" style="padding-bottom:20px;"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <asp:TextBox ID="txtname" runat="server" placeholder="Your name" CssClass="input"></asp:TextBox>                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter name." ControlToValidate="txtname" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label for="your_pass" style="padding-bottom:50px;"><i class="zmdi zmdi-lock"></i></label>
                                <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" placeholder="Your Password" CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter password." ControlToValidate="txtpassword" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="cvNotMatched" runat="server" ErrorMessage="[Password] and [Username] not matched" ControlToValidate="txtPassword" ForeColor="Red"></asp:CustomValidator>
                            </div>

                            <div class="form-group form-button">
                                <asp:Button ID="btnlogin" runat="server" Text="Login" OnClick="btnlogin_Click" BackColor="Yellow" BorderColor="#FFCC00" CssClass="input"></asp:Button>
                               <asp:CheckBox ID="chkRememberMe" runat="server"/>Remember Me
                            </div>
                            <br />
                             <center>
                                <div class="g-recaptcha" data-sitekey="6LfyTnkaAAAAAG4jjEwz5ouYHPTbazKSlaZrvimM" data-theme="dark"></div>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please Make Sure You Have Tick Recaptcha" ForeColor="Red"></asp:CustomValidator>
                            </center>
                            <br />
                        </form>
                        <div class="social-login">
                            <span class="social-label">Or login with</span>
                            <ul class="socials">
                                <fb:login-button id="fb-btn" scope="public_profile,email" onlogin="checkLoginState();" CssClass="input"> </fb:login-button>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
      </div>

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>


</asp:Content>