using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Home : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            lbElectronicGoods.Text = db.Product_Categories.Count(x => x.CategoryID == 9).ToString();
            lbHealth.Text = db.Product_Categories.Count(x => x.CategoryID == 5).ToString();
            lbSport.Text = db.Product_Categories.Count(x => x.CategoryID == 4).ToString();

            lbP1.Text = db.Products.Single(x => x.ProductID == 6).ProductName;
            lbP2.Text = db.Products.Single(x => x.ProductID == 7).ProductName;
            lbP3.Text = db.Products.Single(x => x.ProductID == 2).ProductName;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Member/ShoppingCart.aspx");
        }
    }
}