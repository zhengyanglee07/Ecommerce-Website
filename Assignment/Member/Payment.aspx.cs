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
    public partial class Payment : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        String connectionString = Global.connectingString;
        //string PayMethodid = "PayMethod";
        int PayMethodid = 100;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GenerateAutoID();

                int cId = Convert.ToInt32(Session["CartID"]);

                var checkOutItem = from c in db.Carts
                                   from ci in db.CartItems
                                   from p in db.ProductDetails
                                   where c.CartID == ci.CartID && c.CartID == cId && ci.ProductID == p.ProductID && ci.CheckOut == true
                                   select new { c, ci, p };
                gvCheckOut.DataSource = checkOutItem;
                gvCheckOut.DataBind();
            }
        }

        private void GenerateAutoID()
        {
            /*SqlConnection connection = new SqlConnection(connectionString);
            
            connection.Open();
            SqlCommand command = new SqlCommand("Select Count(PayMethodID) from PaymentMethod", connection);
            int i = Convert.ToInt32(command.ExecuteScalar());
            connection.Close();
            i++;
            lblpaymethodid.Text = PayMethodid + i.ToString();*/

            int pm = db.PaymentMethods.Count();
            lblpaymethodid.Text = PayMethodid + pm.ToString();
        }

        protected void btnreset_Click(object sender, EventArgs e)
        {         
            ddlbank.ClearSelection();
            txtnameoncard.Text = "";
            txtcardnumber.Text = "";
            rblcardtype.ClearSelection();
            txtexepirydate.Text = "";
            txtcvv.Text = "";

            Server.Transfer("Payment.aspx");
        }

        protected void btnpay_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int paymethodid = Convert.ToInt32(lblpaymethodid.Text);
                string bank = ddlbank.SelectedItem.Text + "(" + ddlbank.SelectedValue + ")";
                string nameoncard = txtnameoncard.Text;
                string cardnumber = txtcardnumber.Text;
                string cardtype = rblcardtype.SelectedItem.Text + "(" + rblcardtype.SelectedValue + ")";
                string expirydate = txtexepirydate.Text;
                int cvv = Convert.ToInt32(txtcvv.Text);

                /*string SqlpayStatement = @"INSERT INTO PaymentMethod (PayMethodID, Bank, NameOnCard, CardNumber, CardType, ExpiryDate, CVV)VALUES(@paymethodid, @bank, @nameoncard, @cardnumber, @cardtype, @expirydate, @cvv)";

                SqlConnection connection = new SqlConnection(connectionString);

                SqlCommand command = new SqlCommand(SqlpayStatement, connection);

                command.Parameters.AddWithValue("@PayMethodID", paymethodid);
                command.Parameters.AddWithValue("@Bank", bank);
                command.Parameters.AddWithValue("@NameOnCard", nameoncard);
                command.Parameters.AddWithValue("@CardNumber", cardnumber);
                command.Parameters.AddWithValue("@CardType", cardtype);
                command.Parameters.AddWithValue("@ExpiryDate", expirydate);
                command.Parameters.AddWithValue("@CVV", cvv);

                //Start connection to DB
                connection.Open();

                // Execute statement
                command.ExecuteNonQuery();

                //close connection with DB
                connection.Close();*/

                PaymentMethod pm = new PaymentMethod
                {
                    PayMethodID= paymethodid,
                    Bank=bank,
                    NameOnCard=nameoncard,
                    CardNumber=cardnumber,
                    CardType=cardtype,
                    ExpiryDate=expirydate,
                    CVV=cvv
                };

                db.PaymentMethods.InsertOnSubmit(pm);
                db.SubmitChanges();

                Session["PayID"] = paymethodid;

                GenerateAutoID();
                Response.Redirect("Paysuccessful.aspx");

            }
        }
    }
}