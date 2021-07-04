using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvProduct.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    int cId = Convert.ToInt32(Session["CartID"]);
                    int productid = Convert.ToInt32(gvProduct.Rows[row.RowIndex].Cells[5].Text);
                    CheckBox chk = (CheckBox)row.FindControl("CheckOut");
                    CartItem c = db.CartItems.Single(cc => cc.CartID == 3 && cc.ProductID == productid);
                    if (chk.Checked)
                    {
                        c.CheckOut = true;
                        db.SubmitChanges();
                        Response.Write("Succeful");
                    }
                    else
                    {
                        c.CheckOut = false;
                        db.SubmitChanges();
                        Response.Write("Unsuccessful");
                    }


                    Response.Write("Product ID");
                }
            }

        }
    }
}