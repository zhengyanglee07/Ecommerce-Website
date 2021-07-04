using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class Delivery : System.Web.UI.Page
    {
        String connectionString = Global.connectingString;

        int deliveryid = 100;

        AssignmentDBDataContext db = new AssignmentDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            if (!IsPostBack)
            {
                GenerateAutoID();

                rblcompanyid.DataSource = db.DeliveryCompanies;
                rblcompanyid.DataBind();
            }

            string orderid = Session["OrderID"].ToString();

            /*var orders = from o in db.Orders
                         from c in db.Carts
                         where c.CartID == o.CartID
                         select o;

            var order = db.Orders.SingleOrDefault(o => o.OrderID == orderid);
            string oid = order.OrderID;*/

            lblorderid.Text = orderid.ToString();

        }

        private void GenerateAutoID()
        {
            /* SqlConnection connection = new SqlConnection(connectionString);

             connection.Open();
             SqlCommand command = new SqlCommand("Select Count(DeliveryID) from Delivery", connection);
             int i = Convert.ToInt32(command.ExecuteScalar());
             connection.Close();
             i++;
             lbldeliveryid.Text = deliveryid + i.ToString();*/

            int dy = db.Deliveries.Count();
            lbldeliveryid.Text = deliveryid + dy.ToString();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            Delivery delivery = new Delivery
            {
                DeliveryID = Convert.ToInt32(lbldeliveryid.Text),
                OrderID = lblorderid.Text,
                CompanyID = Convert.ToInt32(rblcompanyid.SelectedValue),
                DelveryAddress = txtdeliveryaddress.Text
            };
            db.Deliveries.InsertOnSubmit(delivery);
            db.SubmitChanges();

            Session["DeliveryID"] = delivery.DeliveryID;
            Response.Redirect("GeneratingReceipt.aspx");
        }
    }
}