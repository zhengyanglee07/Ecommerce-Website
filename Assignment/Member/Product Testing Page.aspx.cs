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
    public partial class Product_Testing_Page : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int data = Convert.ToInt32(ddlCategory.SelectedValue);
            var table = db.ProductDetails.Where(x => x.CategoryID == data);

            lvProduct.DataSourceID = "";

            lvProduct.DataSource = table;
            lvProduct.DataBind();
        }


        protected void lvProduct_ItemDataBound1(object sender, ListViewItemEventArgs e)
        {
            int pid = Convert.ToInt32((e.Item.FindControl("HiddenField1") as HiddenField).Value);
            var product = db.ProductDetails.SingleOrDefault(p => p.ProductID == pid);
            if (product != null)
            {
                product = db.ProductDetails.SingleOrDefault(p => p.ProductID == pid);
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
                (e.Item.FindControl("imgProduct") as Image).ImageUrl = "../images/Product_Images/" + pimg;
            }
        }
    }
}