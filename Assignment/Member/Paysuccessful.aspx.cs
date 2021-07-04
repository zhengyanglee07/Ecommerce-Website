using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Paysuccessful : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            Payment p = new Payment
            {
                OrderID = Session["OrderID"].ToString(),
                PayMethod = Convert.ToInt32(Session["PayID"]),
                PaymentStatus = "paid"
            };
            Session["PayID"] = p.PaymentID;
            Response.Write(p.PaymentID);
            db.Payments.InsertOnSubmit(p);
            db.SubmitChanges();
        }
    }
}