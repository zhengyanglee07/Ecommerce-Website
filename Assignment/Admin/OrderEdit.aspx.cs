using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Admin
{
    public partial class OrderEdit : System.Web.UI.Page
    {
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        public static string successMessage, errorMessage;
        public static int orderID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                alertSuccess.Visible = false;
                alertFail.Visible = false;

                orderID = Convert.ToInt32(Request.QueryString["oid"]);
                orderBind();
            }
        }

        public void orderBind()
        {
            var orderDetail = db.OrderDetails.SingleOrDefault(od => od.OrderInfoID == orderID);
            lblOrderID.Text = orderDetail.OrderInfoID.ToString();
            lblOrderDate.Text = orderDetail.OrderDate.ToString();
            ddlOrderStatus.SelectedValue = orderDetail.OrderStatus;

            lblCustomerName.Text = orderDetail.user_Name.ToString();
            lblAddress.Text = orderDetail.DelveryAddress.ToString();

            lblBank.Text = orderDetail.Bank.ToString();
            lblType.Text = "Credit Card";

            var cartItem = from od in db.OrderDetails
                           from o in db.Orders
                           from c in db.Carts1
                           where od.OrderInfoID == orderID && od.OrderID == o.OrderID && o.CartID == c.CartID && c.CheckOut == true
                           select new { od, o, c };
            gvOrderItem.DataSource = cartItem;
            gvOrderItem.DataBind();

            lblDeliveryBy.Text = orderDetail.CompanyName;
            lblShippingFees.Text = (Math.Round(orderDetail.PricePerKG,2)).ToString(); 
            lblOrderTotal.Text = (Math.Round(orderDetail.OrderTotal + orderDetail.PricePerKG, 2)).ToString();


            foreach (GridViewRow row in gvOrderItem.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    //Get Product iD from Gridview( first cell of row )
                    int pid = Convert.ToInt32(row.Cells[0].Text);
                    var product = db.ProductDetails.SingleOrDefault(p => p.ProductID == pid);

                    //Check and get the Product Image name(string) from array that is not null as first product image
                    string[] imgs = product.ProductImage.Split(',');
                    string pimg = "";
                    foreach (string img in imgs)
                    {
                        if (img != "")
                        {
                            pimg = img;
                            break;
                        }
                    }

                    //Get and Set Image control at Gridview
                    Image image = row.FindControl("imgProductImage") as Image;
                    image.ImageUrl = "~/Images/Product_Images/" + pimg;

                    Label lbl = row.FindControl("lblProductName") as Label;
                    lbl.Text = product.ProductName;
                }
            }

        }

        protected void ddlOrderStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            orderStatusUpdate(ddlOrderStatus.SelectedValue, "Order Status successful updated", "Failed to update order status! Please try agian.");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            orderStatusUpdate("cancelled", "Order have been refund successfully", "Failed to refund order! Please try again.");
        }

        protected void btnInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("Invoice.aspx?oid=" + orderID);
        }

        public void orderStatusUpdate(string status, string sMessage, string eMessage)
        {
            var od = db.OrderInfos.SingleOrDefault(o => o.OrderInfoID == orderID);
            od.OrderStatus = status;
            od.LastModified = DateTime.Now;
            try
            {
                db.SubmitChanges();
                successMessage = sMessage;
                alertSuccess.Visible = true;
            }
            catch
            {
                errorMessage = eMessage;
                alertFail.Visible = true;
            }
        }
    }
}