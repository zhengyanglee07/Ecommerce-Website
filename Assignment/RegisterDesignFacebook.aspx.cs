using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class RegisterDesignFacebook : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            if (db.Users.Any(s => s.user_Name == username))
            {
                args.IsValid = false;
            }
        }

        protected void btnregister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String userName = txtUsername.Text;
                String password = txtpassword.Text;
                String email = txtemail.Text;

                Member m = new Member
                {
                    user_Name = userName,
                    user_Email = email,
                    user_Password = password,
                    registerDate = DateTime.Now
                    
                };

                db.Members.InsertOnSubmit(m);
                db.SubmitChanges();

                Response.Redirect("LoginDesign.aspx");
            }
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string useremail = args.Value;

            if (db.Users.Any(s => s.user_Email == useremail))
            {
                args.IsValid = false;
            }
        }
    }
}