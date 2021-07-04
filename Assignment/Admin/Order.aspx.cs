using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Admin
{
    public partial class Order1 : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        public static string successMessage, errorMessage, itemShown;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            }

        }

        protected void gvOrder_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Get the orderID from Gridview 
                int oid = Convert.ToInt32(gvOrder.DataKeys[e.Row.RowIndex].Values[0]);
                Response.Write(oid);
                var orderDetail = db.OrderDetails.First(d => d.OrderInfoID == oid);
                DropDownList ddl = e.Row.FindControl("ddlOrderStatus") as DropDownList;
                ddl.SelectedValue = orderDetail.OrderStatus;

                Label lblItemIndex = e.Row.FindControl("lblItemIndex") as Label;
                itemShown = "<b>Showing: " +
                                (1 + (gvOrder.PageSize * gvOrder.PageIndex)).ToString() +
                                " to " +
                                (Convert.ToInt32(lblItemIndex.Text) + (gvOrder.PageSize * gvOrder.PageIndex)).ToString() +
                                " of " +
                                (from od in db.ProductDetails select od).Count().ToString() +
                                " entries</b>";
            }

            if (itemShown != null)
            {
                if (e.Row.RowType == DataControlRowType.Pager)
                {
                    Label lbl = e.Row.FindControl("itemShown") as Label;
                    lbl.Attributes["style"] = "width: 1000px; background-color: #e8f0e8; color: black";
                    lbl.Text = itemShown;
                }
            }
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("OrderEdit.aspx?oid=" + e.CommandArgument);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string query = "%%";
            var search = txtSearch.Text;
            if (search != String.Empty)
            {
                query = "%" + search + "%";
            }
            gvOrder.DataSourceID = "";

            IQueryable order;
            if (txtMinDate.Text != String.Empty)
            {
                if (txtMaxDate.Text == String.Empty)
                {
                    txtMaxDate.Text = DateTime.Now.Date.ToString();
                }
                if (txtSearch.Text == String.Empty)
                {
                    order = from o in db.OrderDetails
                            where
                           (o.OrderDate >= Convert.ToDateTime(txtMinDate.Text) && o.OrderDate <= Convert.ToDateTime(txtMaxDate.Text)) &&
                           (o.LastModified >= Convert.ToDateTime(txtMinDate.Text) && o.LastModified <= Convert.ToDateTime(txtMaxDate.Text))
                            select o;
                }
                else
                {
                    order = from o in db.OrderDetails
                            where
                            (SqlMethods.Like(o.user_Name, query) ||
                            SqlMethods.Like(o.OrderTotal.ToString(), query)) &&
                            (o.OrderDate >= Convert.ToDateTime(txtMinDate.Text) && o.OrderDate <= Convert.ToDateTime(txtMaxDate.Text)) &&
                            (o.LastModified >= Convert.ToDateTime(txtMinDate.Text) && o.LastModified <= Convert.ToDateTime(txtMaxDate.Text))
                            select o;

                }
            }
            else
            {
                order = from o in db.OrderDetails
                        where
                        SqlMethods.Like(o.user_Name, query) ||
                        SqlMethods.Like(o.OrderTotal.ToString(), query)
                        select o;
            }
            gvOrder.DataSource = order;
            gvOrder.DataBind();

        }

        protected void ddlOrderStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvOrder.Rows)
            {

                if (row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlStatus = row.FindControl("ddlOrderStatus") as DropDownList;
                    int oid = Convert.ToInt32(gvOrder.DataKeys[row.RowIndex].Values[0]);
                    var od = db.OrderInfos.SingleOrDefault(o => o.OrderInfoID == oid);
                    od.OrderStatus = ddlStatus.SelectedValue;
                    od.LastModified = DateTime.Now;
                    try
                    {
                        db.SubmitChanges();
                    }
                    catch
                    {
                    }
                }
            }
            Response.Redirect("Order.aspx");
        }

        protected void gvOrder_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                //Create the label in gridview to show the total item shown
                TableCell sortCell = new TableCell();
                Table tbl = (Table)e.Row.Cells[0].Controls[0];
                tbl.Attributes["style"] = "width: 100%";
                tbl.Rows[0].Cells.AddAt(0, sortCell);
                Label lblItemShown = new Label();
                lblItemShown.ID = "itemShown";
                sortCell.Controls.Add(lblItemShown);
            }
        }
    }
}