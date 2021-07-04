﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Assignment
{
    public partial class LoginDesign : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtname.Text;
                string password = txtpassword.Text;
                bool rememberMe = chkRememberMe.Checked;

                //Login the user
                //Calculate the has, and find entry from DB
                User u = db.Users.SingleOrDefault(
                    x => x.user_Name == username &&
                         x.user_Password == password
                         );

                //Recaptcha validation
                var encodedResponse = Request.Form["g-Recaptcha-Response"];
                var isCaptchaValid = Googlev2.Validate(encodedResponse);

                if (isCaptchaValid)
                {
                    CustomValidator1.IsValid = true;
                    if (u != null)
                    {
                        Session["userID"] = u.userID;
                        Security.LoginUser(u.user_Name, u.Role, rememberMe);
                        cvNotMatched.IsValid = true;

                    }
                    else
                    {
                        cvNotMatched.IsValid = false;
                    }

                }
                else
                {
                    CustomValidator1.IsValid = false;
                }


            }
        }
    }
}