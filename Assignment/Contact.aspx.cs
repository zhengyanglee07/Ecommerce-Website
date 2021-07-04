using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnregister_Click(object sender, EventArgs e)
        {
            String firstname = txtfirstname.Text;
            String lastname = txtlastname.Text;
            String email = txtemail.Text;
            String message = txtmessage.Text;
        }

        protected void btnreset_Click(object sender, EventArgs e)
        {
            txtfirstname.Text = "";
            txtlastname.Text = "";
            txtemail.Text = "";
            txtmessage.Text = "";

            Server.Transfer("Contact.aspx");
        }
    }
}