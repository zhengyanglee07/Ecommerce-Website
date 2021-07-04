using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;

namespace Assignment.Admin
{
    public partial class Invoice : System.Web.UI.Page
    {
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int oid = Convert.ToInt32(Request.QueryString["oid"]);
                var ckItem = from od in db.OrderDetails
                               from o in db.Orders
                               from c in db.Carts1
                               where od.OrderInfoID == oid && od.OrderID == o.OrderID && o.CartID == c.CartID && c.CheckOut == true
                               select new { od, o, c };
                gvOrderItem.DataSource = ckItem;
                gvOrderItem.DataBind();


                //Bind the data for the Invoice
                Assignment.OrderDetail orderDetail = db.OrderDetails.Single(oo => oo.OrderInfoID == oid);
                lblOrderNo.Text = orderDetail.OrderInfoID.ToString();
                lblOrderDate.Text = orderDetail.OrderDate.ToString();

                Assignment.Order order = db.Orders.Single(oo => oo.OrderID == orderDetail.OrderID);
                lblSubtotal.Text = (Math.Round(order.TotalPrice,2)).ToString();
                lblShipping.Text = (Math.Round(orderDetail.PricePerKG,2)).ToString();
                decimal total = Convert.ToDecimal(lblSubtotal.Text) + Convert.ToDecimal(lblShipping.Text);
                lblTotal.Text = Math.Round(total, 2).ToString();


                //Convert to PDF
                Response.ContentType = "application/pdf";
                //Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                this.Page.RenderControl(hw);
                StringReader sr = new StringReader(sw.ToString());
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
                // Roate page using Rotate() function, if you want in Landscape
                // pdfDocument.SetPageSize(PageSize.A4.Rotate());

                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                PdfWriter.GetInstance(pdfDoc, new FileStream(Server.MapPath("pdf/Invoice-" + oid + ".pdf"), FileMode.Create));
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();
                Response.Write(pdfDoc);
                Response.End();
            }
        }
    }
}   