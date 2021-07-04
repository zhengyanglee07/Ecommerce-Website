using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            string quantity = "";
            foreach (DataListItem li in DataList1.Items)
            {
                TextBox tb = li.FindControl("txtquantity") as TextBox;
                quantity = tb.Text;
            }
            if (db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString() == null)
            {
                lbCountItem.Text = "0";
            }
            else
            {
                lbCountItem.Text = db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString();
            }

            var uid = Session["userID"];

            if (uid == null)
            {
                Response.Redirect("../LoginDesign.aspx");
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string quantity = "";
            foreach (DataListItem li in DataList1.Items)
            {
                TextBox tb = li.FindControl("txtquantity") as TextBox;
                quantity = tb.Text;
            }
            int userid = 1;
            int productId = Convert.ToInt32(Request.QueryString["ProductID"]);
            var product = db.Products.SingleOrDefault(p => p.ProductID == productId);
            Cart cc = db.Carts.SingleOrDefault(c => c.UserID == userid);
            //  int q = Convert.ToInt32(txtquantity.Text);
            int qy;
            int.TryParse(quantity, out qy);

            bool cart = db.Carts.Any(c => c.UserID == userid);
            if (cart == false)
            {
                Cart c = new Cart
                {
                    UserID = userid
                };
                db.Carts.InsertOnSubmit(c);
                db.SubmitChanges();
            }
            bool cartitem = db.CartItems.Any(c => c.CartID == cc.CartID && c.ProductID == productId);
            if (!cartitem)
            {
                CartItem cartI = new CartItem
                {
                    CartID = cc.CartID,
                    ProductID = productId,
                    Quantity = qy,
                    TotalPrice = product.ProductPrice * qy
                };
                db.CartItems.InsertOnSubmit(cartI);
                db.SubmitChanges();
            }
            else
            {
                CartItem cI = db.CartItems.FirstOrDefault(c => (c.CartID == cc.CartID && c.ProductID == productId));
                cI.Quantity += qy;
                db.SubmitChanges();
            }
            Session["CartID"] = cc.CartID;
            Response.Redirect("ShoppingCart.aspx?ProductID=" + productId);
        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            //Check and get the Product Image name(string) from array that is not null as first product image
            int pid = Convert.ToInt32((e.Item.FindControl("HiddenField1") as HiddenField).Value);
            var product = db.ProductDetails.SingleOrDefault(p => p.ProductID == pid);
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
            (e.Item.FindControl("Image1") as Image).ImageUrl = "../images/Product_Images/" + pimg;
        }
    }
}