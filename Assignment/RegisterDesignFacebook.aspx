<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterDesignFacebook.aspx.cs" Inherits="Assignment.RegisterDesignFacebook" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
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
            let txtUsername = `${user.name}`;
            let txtemail = `${user.email}`;

            document.getElementById("<%=txtUsername.ClientID %>").value = txtUsername;
            document.getElementById("<%=txtemail.ClientID %>").value = txtemail;

        }

        function logout() {
            FB.logout(function (response) {
            });
        }


    </script>
    <div class="main">

        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">ShopBee Register</h2>
                        <form method="POST" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name" style="padding-bottom: 42px;"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <asp:TextBox ID="txtUsername" name="txtUsername" runat="server" placeholder="Your Name"  CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Name." ControlToValidate="txtUsername" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtUsername" CssClass="error" ErrorMessage="Username already exist" OnServerValidate="CustomValidator1_ServerValidate" ForeColor="Red"></asp:CustomValidator>
                            </div>
                            <div class="form-group">
                                <label for="email" style="padding-bottom: 25px;"><i class="zmdi zmdi-email"></i></label>
                                <asp:TextBox ID="txtemail" runat="server" placeholder="Your email"  CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter email." ControlToValidate="txtemail" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="Please enter valid email." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red"></asp:RegularExpressionValidator>
                                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtemail" CssClass="error" ErrorMessage="Email already exist" OnServerValidate="CustomValidator2_ServerValidate" ForeColor="Red"></asp:CustomValidator>
                            </div>
                            <div class="form-group">
                                <label for="pass" style="padding-bottom: 25px;"><i class="zmdi zmdi-lock"></i></label>
                                <asp:TextBox ID="txtpassword" runat="server" placeholder="Your password" TextMode="Password"  CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter password." ControlToValidate="txtpassword" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label for="re-pass" style="padding-bottom: 42px;"><i class="zmdi zmdi-lock-outline"></i></label>
                                <asp:TextBox ID="txtConfPassword" TextMode="Password" runat="server" placeholder="Confirm password"  CssClass="input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtConfPassword" Display="Static" ErrorMessage="Please confirm your password" ForeColor="Red"></asp:RequiredFieldValidator>
                                </br>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfPassword" Display="Static" ErrorMessage="Password mismatch" ForeColor="Red"></asp:CompareValidator>
                            </div>
                            <div class="form-group form-button">
                                <asp:Button ID="btnregister" runat="server" class="button button1" Text="Register" OnClick="btnregister_Click" BorderColor="#FF9900" BackColor="Yellow"  CssClass="input"/>
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure>
                            <img src="../images/hive-lookups-udf.png" alt="sing up image"></figure>
                        <a href="LoginDesign.aspx" class="signup-image-link">I am already member</a>
                        <div class="social-login">
                            <span class="social-label">or Register with</span>
                            <ul class="socials">
                                <fb:login-button id="fb-btn" scope="public_profile,email" onlogin="checkLoginState();"  CssClass="input"> </fb:login-button>
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
