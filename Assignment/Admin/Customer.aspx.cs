using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Admin
{
    public partial class Customer : System.Web.UI.Page
    {
        public static string successMessage, errorMessage;
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string query = "%%";

            if (txtSearch.Text != String.Empty)
            {
                query = "%" + txtSearch.Text + "%";
            }
            gvCustomer.DataSourceID = "";

            IQueryable user;
            if (txtMinDate.Text != String.Empty)
            {
                if (txtMaxDate.Text == String.Empty)
                {
                    txtMaxDate.Text = DateTime.Now.Date.ToString();
                }
                if (txtSearch.Text == String.Empty)
                {
                    user = from u in db.Members
                           where
                           (u.registerDate >= Convert.ToDateTime(txtMinDate.Text) && u.registerDate <= Convert.ToDateTime(txtMaxDate.Text))
                           select u;
                }
                else
                {
                    user = from u in db.Members
                           where
                           (SqlMethods.Like(u.user_Name, query) || SqlMethods.Like(u.user_Email, query)) &&
                           (u.registerDate >= Convert.ToDateTime(txtMinDate.Text) && u.registerDate <= Convert.ToDateTime(txtMaxDate.Text))
                           select u;
                }
            }
            else
            {
                user = from u in db.Members
                       where
                       SqlMethods.Like(u.user_Name, query) ||
                       SqlMethods.Like(u.user_Email, query)
                       select u;
            }
            gvCustomer.DataSourceID = "";
            gvCustomer.DataSource = user;
            gvCustomer.DataBind();

        }

        protected void gvCustomer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            HiddenField hf = e.Row.FindControl("HiddenField1") as HiddenField;
            HyperLink hl = e.Row.FindControl("HyperLink1") as HyperLink;
            if (hf != null)
            {
                hl.NavigateUrl = "Order.aspx?username=" + hf.Value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                alertSuccess.Visible = false;
                alertFail.Visible = false;

                var customer = from u in db.Members
                               from o in db.OrderDetails
                               where u.user_Name == o.user_Name
                               select new { u, o };
                gvCustomer.DataSourceID = "";
                gvCustomer.DataSource = db.Members;
                gvCustomer.DataBind();
            }
        }
    }
}