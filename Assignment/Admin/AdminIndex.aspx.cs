using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;    

namespace Assignment.Admin
{
 
    public partial class AdminIndex : System.Web.UI.Page
    {
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime minDate = DateTime.Now;
            DateTime maxDate = DateTime.Now.AddDays(7);
            //Set data for new order charts
            string[] labels = new string[7];
            int[] data1 = new int[7];
            int max1 = 0;
            int total1 = 0;
            int index = 0;
            for (int i = -6 ; i <= 0; i++)
            {
                DateTime dt = DateTime.Now.AddDays(i);
                int n = db.OrderInfos.Count(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month && o.OrderDate.Date == dt.Date);
                labels[index] = dt.DayOfWeek.ToString();
                data1[index] = n;

                if(n > max1)
                {
                    max1 = n;
                }

                total1 += n;
                index++;
            }
            lblTodayOrder.Text = total1.ToString(); //To Show total order of 7 day
            jsStringArray("cLabels", labels);
            jsIntArray("c1Data", data1);
            jsInt("c1Max", max1); // Set the maximum range of chart

            //Set data for total sales charts
            decimal[] data2 = new decimal[7];
            decimal max2 = 0;
            decimal total2 = 0;
            index = 0;
            for (int i = -6; i <= 0; i++)
            {
                DateTime dt = DateTime.Now.AddDays(i);
                var order = db.OrderInfos.Where(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month && o.OrderDate.Date == dt.Date);
                decimal totalSales = 0;
                if (order.Any())
                {
                     totalSales = order.Sum(o => o.OrderTotal);
                }
                
                data2[index] = Math.Round(totalSales,2);

                if (totalSales > max2)
                {
                    max2 = totalSales;
                }

                total2 += totalSales;
                index++;
            }
            lblTotalSales.Text = Math.Round(total2,2).ToString(); //To Show total order of 7 day
            jsDecimalArray("c2Data", data2);
            jsDecimal("c2Max", max2); // Set the maximum range of chart



            //Set data for Daily Visitors charts
            int[] data3 = new int[7];
            int max3 = 0;
            int total3 = 0;
            index = 0;
            for (int i = -6; i <= 0; i++)
            {
                DateTime dt = DateTime.Now.AddDays(i);
                int visitor = db.Visitors.Count(v => v.Visit.Year == dt.Year && v.Visit.Month == dt.Month && v.Visit.Date == dt.Date);
                data3[index] = visitor;

                if (visitor > max3)
                {
                    max3 = visitor;
                }

                total3 += visitor;
                index++;
            }
            lblVisitors.Text = total3.ToString(); 
            jsIntArray("c3Data", data3);
            jsInt("c3Max", max3);


            //Set data for New Customers charts
            int[] data4 = new int[7];
            int max4 = 0;
            int total4 = 0;
            index = 0;
            for (int i = -6; i <= 0; i++)
            {
                DateTime dt = DateTime.Now.AddDays(i);
                int user = db.Members.Count(u => u.registerDate.Year == dt.Year && u.registerDate.Month == dt.Month && u.registerDate.Date == dt.Date);
                data4[index] = user;

                if (user > max4)
                {
                    max4 = user;
                }

                total4 += user;
                index++;
            }
            lblTotalUser.Text = total4.ToString();
            jsIntArray("c4Data", data4);
            jsInt("c4Max", max4);


            if (!Page.IsPostBack)
            {
                string searchBy = Request.QueryString["date"];
                if (searchBy != null)
                {
                    chartData(searchBy);
                }
                else
                {
                    chartData("day");
                }
            }
        }



        protected void btnDay_Command(object sender, CommandEventArgs e)
        {
            //Set data for Statictics Chart's data, according to day, month or year
            Response.Redirect("AdminIndex.aspx?date=" + (string)e.CommandArgument);
        }

        public void chartData(string str)
        {
            int min;
            string[] c5Labels;
            int[] c5Data1, c5Data3;
            decimal[] c5Data2;
            int index = 0;
            if (str == "year")
            {
                c5Labels = new string[5];
                c5Data1 = new int[5];
                c5Data2 = new decimal[5];
                c5Data3 = new int[5];
                min = -4;
                index = 0;
                for (int i = min; i <= 0; i++)
                {
                    DateTime dt = DateTime.Now.AddYears(i);
                    c5Labels[index] = dt.Year.ToString();
                    index++;
                }
            }
            else if (str == "month")
            {
                c5Labels = new string[12];
                c5Data1 = new int[12];
                c5Data2 = new decimal[12];
                c5Data3 = new int[12];
                min = -11;
                index = 0;
                for (int i = min; i <= 0; i++)
                {
                    DateTime dt = DateTime.Now.AddMonths(i);
                    c5Labels[index] = dt.Month.ToString();
                    index++;
                }
            }
            else
            {
                c5Labels = new string[31];
                c5Data1 = new int[31];
                c5Data2 = new decimal[31];
                c5Data3 = new int[31];
                min = -30;
                index = 0;
                for (int i = min; i <= 0; i++)
                {
                    DateTime dt = DateTime.Now.AddDays(i);
                    c5Labels[index] = dt.Day.ToString();
                    index++;
                }
            }
            jsStringArray("c5Labels", c5Labels);

            index = 0;
            for (int i = min; i <= 0; i++)
            {
                DateTime dt;
                int n;
                switch (str)
                {
                    case "day":
                        dt = DateTime.Now.AddDays(i);
                        n = db.OrderInfos.Count(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month && o.OrderDate.Date == dt.Date); ;
                        break;
                    case "month":
                        dt = DateTime.Now.AddMonths(i);
                        n = db.OrderInfos.Count(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month);
                        break;
                    default:
                        dt = DateTime.Now.AddYears(i);
                        n = db.OrderInfos.Count(o => o.OrderDate.Year == dt.Year);
                        break;
                }
                c5Data1[index] = n;
                index++;
            }
            jsIntArray("c5Data1", c5Data1);

            index = 0;
            for (int i = min; i <= 0; i++)
            {

                DateTime dt;
                IQueryable<Assignment.OrderInfo> order;
                switch (str)
                {
                    case "day":
                        dt = DateTime.Now.AddDays(i);
                        order = db.OrderInfos.Where(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month && o.OrderDate.Date == dt.Date);
                        break;
                    case "month":
                        dt = DateTime.Now.AddMonths(i);
                        order = db.OrderInfos.Where(o => o.OrderDate.Year == dt.Year && o.OrderDate.Month == dt.Month);
                        break;
                    default:
                        dt = DateTime.Now.AddYears(i);
                        order = db.OrderInfos.Where(o => o.OrderDate.Year == dt.Year);
                        break;
                }
                decimal totalSales = 0;
                if (order.Any())
                {
                    totalSales = order.Sum(o => o.OrderTotal);
                }
                c5Data2[index] = Math.Round(totalSales, 2);
                index++;
            }
            jsDecimalArray("c5Data2", c5Data2);


            index = 0;
            for (int i = min; i <= 0; i++)
            {
                DateTime dt;
                int user;
                switch (str)
                {
                    case "day": 
                        dt = DateTime.Now.AddDays(i);
                        user = db.Members.Count(u => u.registerDate.Year == dt.Year && u.registerDate.Month == dt.Month && u.registerDate.Date == dt.Date);
                        break;
                    case "month": 
                        dt = DateTime.Now.AddMonths(i);
                        user = db.Members.Count(u => u.registerDate.Year == dt.Year && u.registerDate.Month == dt.Month);
                        break;
                    default: 
                        dt =DateTime.Now.AddYears(i);
                        user = db.Members.Count(u => u.registerDate.Year == dt.Year);
                        break;
                }
  
                c5Data3[index] = user;
                index++;
            }
            jsIntArray("c5Data3", c5Data3);

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "callFunction", "chart5(c5Labels, 'Total Sales', 'Total Order', 'Total Customer', c5Data1, c5Data2, c5Data3)", true);

        }

        public void jsStringArray(string varName, string[] strArray)
        {
            List<string> l = new List<string>();

            foreach (string i in strArray)
            {
                l.Add(i);
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var " + varName + " = new Array;");
            foreach (string str in l)
            {
                sb.Append(varName + ".push('" + str + "');");
            }
            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), varName, sb.ToString());
        }
        public void jsIntArray(string varName, int[] intArray)
        {
            List<int> l = new List<int>();

            foreach (int i in intArray)
            {
                l.Add(i);
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var " + varName + " = new Array;");
            foreach (int x in l)
            {
                sb.Append(varName + ".push('" + x + "');");
            }
            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), varName, sb.ToString());
        }

        public void jsDecimalArray(string varName, decimal[] decimalArray)
        {
            List<decimal> l = new List<decimal>();

            foreach (decimal i in decimalArray)
            {
                l.Add(i);
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var " + varName + " = new Array;");
            foreach (int x in l)
            {
                sb.Append(varName + ".push('" + x + "');");
            }
            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), varName, sb.ToString());
        }

        public void jsInt(string varName, int value)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var " + varName + " = " + value);
            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), varName, sb.ToString());
        }

        public void jsDecimal(string varName, decimal value)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append("var " + varName + " = " + value);
            sb.Append("</script>");

            ClientScript.RegisterStartupScript(this.GetType(), varName, sb.ToString());
        }
    }
}