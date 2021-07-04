using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Assignment
{
    public partial class Receipt : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {


                int cId = Convert.ToInt32(Session["CartID"]);

                var checkOutItem = from c in db.Carts
                                   from ci in db.CartItems
                                   from p in db.ProductDetails
                                   where c.CartID == ci.CartID && c.CartID == cId && ci.ProductID == p.ProductID && ci.CheckOut == true
                                   select new { c, ci, p };
                gvCheckOut.DataSource = checkOutItem;
                gvCheckOut.DataBind();

                string oid = Session["OrderID"].ToString();
              
                var order1 = db.Orders.Single(x => x.OrderID == oid);
                Payment pay = db.Payments.Single(x => x.OrderID == oid);
                OrderInfo oInfo = new OrderInfo
                {
                    DeliveryID = Convert.ToInt32(Session["DeliveryID"]),
                    PaymentID = pay.PaymentID,
                    OrderTotal = order1.TotalPrice,
                    OrderStatus = "pending",
                    OrderDate = DateTime.Now,
                    LastModified = DateTime.Now
                };
                db.OrderInfos.InsertOnSubmit(oInfo);
                db.SubmitChanges();
                var cc = db.Carts1.Where(c => c.CartID == cId && c.CheckOut == true);

                foreach (var x in cc)
                {
                    Product pp = db.Products.First(p => p.ProductID == x.ProductID);
                    pp.ProductQuantity -= x.Quantity;
                    db.SubmitChanges();
                }

                var ct = db.CartItems.Where(c => c.CartID == cId && c.CheckOut == true);

                foreach(var o in ct)
                {
                    CartItem x = db.CartItems.First(xx => xx.CartID == cId && xx.CheckOut == true);
                    db.CartItems.DeleteOnSubmit(x);
                    db.SubmitChanges();
                }


            }
        }

        protected void btnexit_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Home.aspx");
        }
    }
}