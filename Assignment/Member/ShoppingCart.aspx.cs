using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString() == null)
                {
                    lbCountProductType.Text = "0";
                }
                else
                {
                    lbCountProductType.Text = db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString();
                }
                if (Session["CartID"] == null)
                {
                    var uid = Session["userID"];

                    if (uid == null)
                    {
                        Response.Redirect("../LoginDesign.aspx");
                    }
                    else
                    {
                        if (db.Carts.Any(cc => cc.UserID == Convert.ToInt32(uid)))
                        {
                            Cart c = db.Carts.Single(cc => cc.UserID == Convert.ToInt32(uid));

                            Session["CartID"] = c.CartID;
                        }
                        else
                        {
                            Cart cc = new Cart
                            {
                                UserID = Convert.ToInt32(uid)
                            };

                            db.Carts.InsertOnSubmit(cc);
                            db.SubmitChanges();
                            Session["CartID"] = cc.CartID;
                        }
                    }

                }
                /* This is check the GridView had data or not if not will take the customer back to the shopping page*/
                if (!db.Carts1.Any(x => x.CartID == Convert.ToInt32(Session["CartID"]) && x.UserID == Convert.ToInt32(Session["userID"]) && x.CheckOut == true))
                {
                   // Response.Redirect("Product Testing Page.aspx");
                }
                gvProduct.DataSource = db.Carts1.Where(x => x.CartID == Convert.ToInt32(Session["CartID"]));
                gvProduct.DataBind();
            }



            lbCountProductType.Text = db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString();
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            //int cartid = Convert.ToInt32(Session["CartID"]);

            int cId = Convert.ToInt32(Session["CartID"]);

            string currentDate = DateTime.Now.ToString("yyMMddHms");

            int uid = Convert.ToInt32(Session["userID"]);

            var orderId = Convert.ToString("SB" + currentDate + "U" + uid);

            if (db.CartItems.Any(x => x.CartID == cId && x.CheckOut == true))
            {
                var ci = db.CartItems.Where(c => c.CartID == cId && c.CheckOut == true);

                decimal total = ci.Sum(c => c.TotalPrice);

                Order o = new Order
                {
                    OrderID = orderId,
                    CartID = cId,
                    TotalPrice = total
                };

                db.Orders.InsertOnSubmit(o);
                db.SubmitChanges();

                Session["OrderID"] = orderId;
                Session["CartID"] = cId;
                Response.Redirect("Payment.aspx?CartID=" + cId);
            }
            else
            {
                lbErrorMessage.Text = "Please Check Out At Least One ITEM*";
            }
        }

        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvProduct.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    int cId = Convert.ToInt32(Session["CartID"]);
                    int productid = Convert.ToInt32((gvProduct.Rows[row.RowIndex].Cells[0].FindControl("ProductID") as HiddenField).Value);
                    CheckBox chk = (CheckBox)row.FindControl("CheckOut");
                    CartItem c = db.CartItems.Single(cc => cc.CartID == cId && cc.ProductID == productid);
                    if (chk != null)
                    {
                        if (chk.Checked)
                        {
                            c.CheckOut = true;
                            db.SubmitChanges();
                        }
                        else
                        {
                            c.CheckOut = false;
                            db.SubmitChanges();
                        }
                    }
                }
            }

        }

        protected void LinqDataSource1_Deleting(object sender, LinqDataSourceDeleteEventArgs e)
        {
            var cart = (Carts)e.OriginalObject;
            var del = db.CartItems.Single(x => x.CartID == cart.CartID && x.CartItemID == cart.CartItemID);
            db.CartItems.DeleteOnSubmit(del);
            db.SubmitChanges();
        }

        protected void gvProduct_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            HiddenField caID = gvProduct.Rows[e.RowIndex].FindControl("CartItemID") as HiddenField;
            int cartID = Convert.ToInt32(gvProduct.DataKeys[e.RowIndex].Values[0]);

            if (db.CartItems.Any(x => x.CartID == cartID && x.CartItemID == Convert.ToInt32(caID.Value)))
            {
                var del = db.CartItems.Single(x => x.CartID == cartID && x.CartItemID == Convert.ToInt32(caID.Value));
                db.CartItems.DeleteOnSubmit(del);
                db.SubmitChanges();
            }

            gvProduct.DataSource = db.Carts1.Where(x => x.CartID == Convert.ToInt32(Session["CartID"]));
            gvProduct.DataBind();
            lbCountProductType.Text = db.Carts1.Count(x => x.CartID == Convert.ToInt32(Session["CartID"])).ToString();
        }

        protected void gvProduct_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check and get the Product Image name(string) from array that is not null as first product image
            if (e.Row.FindControl("HiddenField1") != null)
            {
                int pid = Convert.ToInt32((e.Row.FindControl("HiddenField1") as HiddenField).Value);
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
                (e.Row.FindControl("Image1") as Image).ImageUrl = "../images/Product_Images/" + pimg;
            }
        }
    }
}