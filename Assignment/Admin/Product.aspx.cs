using Assignment;
using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Admin
{
    public partial class Product : System.Web.UI.Page
    {
    
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        Assignment.AssignmentDBBackupDataContext dbBackup = new Assignment.AssignmentDBBackupDataContext();
        public static string successMessage, errorMessage;
        public string itemShown;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                alertSuccess.Visible = false;
                alertFail.Visible = false;
                ddlCategory.DataSource = db.Categories;
                ddlCategory.DataBind();

                var publish = Request.QueryString["publish"];
                if(publish != null)
                {
                    gvProducts.DataSource = db.ProductDetails.Where(x => x.Publish == Convert.ToBoolean(publish));
                    gvProducts.DataBind();
                }
                else
                {
                    gvProducts.DataSource = db.ProductDetails;
                    gvProducts.DataBind();
                }

                var cid = Request.QueryString["cid"];
                if(cid != null)
                {
                    gvProducts.DataSourceID = "";
                    gvProducts.DataSource = db.ProductDetails.Where(pd => pd.CategoryID == Convert.ToInt32(cid));
                    gvProducts.DataBind(); 
                }
            }

            
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvProducts.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkPublish");
                Assignment.Product p = db.Products.Single(pp => pp.ProductID == Convert.ToInt32((row.Cells[0].FindControl("hfProductID") as HiddenField).Value));
                if (chk.Checked)
                {
                    p.Publish = true;
                    db.SubmitChanges();
                }
                else
                {
                    p.Publish = false;
                    db.SubmitChanges();
                }
                gvProducts.DataBind();
            }
            Response.Redirect("Product.aspx");
        }
        
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductAction.aspx");
        }

        protected void gvProducts_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                TableCell sortCell = new TableCell();
                Table tbl = (Table)e.Row.Cells[0].Controls[0];
                tbl.Attributes["style"] = "width: 100%";
                tbl.Rows[0].Cells.AddAt(0, sortCell);
                Label lblItemShown = new Label();
                lblItemShown.ID = "itemShown";
                sortCell.Controls.Add(lblItemShown);
            }
        }
        
        protected void gvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblItemIndex = e.Row.FindControl("lblItemIndex") as Label;
                itemShown = "<b>Showing: " +
                            (1 + (gvProducts.PageSize * gvProducts.PageIndex)).ToString() +
                            " to " +
                            (Convert.ToInt32(lblItemIndex.Text) + (gvProducts.PageSize * gvProducts.PageIndex)).ToString() +
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
            //Show product image in gridview
            foreach (GridViewRow row in gvProducts.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    //Get Product iD from Gridview( first cell of row )
                    int pid = Convert.ToInt32((row.Cells[0].FindControl("hfProductID") as HiddenField).Value);
                    var product = db.ProductDetails.SingleOrDefault(p => p.ProductID == pid);
                    if (product != null)
                    {
                        //Check and get the Product Image name(string) from array that is not null as first product image
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
                        //Get and Set Image control at Gridview
                        Image image = row.FindControl("imgProductImage") as Image;
                        image.ImageUrl = "~/Images/Product_Images/" + pimg;
                    }

                }
            }
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            bool toDelete = true;
            int isDelete = 0;
            int productID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Values[0]);
            //SCheck whether product is exists in order
            foreach (var o in db.OrderDetails)
            {
                var order = db.Orders.Single(x => x.OrderID == o.OrderID);
                if (db.CartItems.Any(x => x.CartID == order.CartID && x.ProductID == productID))
                {
                    errorMessage = "Unable to delete this product, have some order include this product are under producessing";
                    alertFail.Visible = true;
                    toDelete = false;
                }
            }

            //Check whether product is added to cart by customer
            foreach (Assignment.Carts c in db.Carts1)
            {
                if (db.Carts1.Any(x => x.ProductID == productID))
                {
                    errorMessage = "This product has been added to cart by customer! Click <a href='Product.aspx?dltCart=1'><b>here</b></a> to delete product in cart!";
                    alertFail.Visible = true;
                    toDelete = false;
                }
            }

            if (toDelete)
            {
                Product_Category p_c = db.Product_Categories.Single(pp => pp.ProductID == productID);
                Assignment.Product p = db.Products.Single(pp => pp.ProductID == productID);
                db.Product_Categories.DeleteOnSubmit(p_c);
                db.Products.DeleteOnSubmit(p);
                db.SubmitChanges();
                this.gvProducts.DataBind();
                Response.Redirect("Product.aspx");
            }
            var clearCart = Request.QueryString["dltCart"];
            if (clearCart != null)
            {
                if (Convert.ToInt32(clearCart) == 1)
                {
                    var ClearCart = db.CartItems.Where(x => x.ProductID == productID);
                    foreach (var ci in ClearCart)
                    {
                        db.CartItems.DeleteOnSubmit(ci);
                        if (SubmitChanges())
                        {
                            isDelete++;
                        }
                    }

                    if (isDelete > 0)
                    {
                        successMessage = "Successful remove " + isDelete + " items from cart added by customer";
                        alertSuccess.Visible = true;
                    }
                    else
                    {
                        errorMessage = "Failed to remove item from cart! Please try agian.";
                        alertFail.Visible = true;
                    }
                }
            }
            gvProducts.DataSource = db.ProductDetails;
            gvProducts.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //Response.Redirect("Product.aspx?cid=" + ddlCategory.SelectedValue);
            String query = "%%";

            if (txtSearch.Text != String.Empty)
            {
                query = "%" + txtSearch.Text + "%";
            }
            gvProducts.DataSourceID = "";

            IQueryable pd;
            int category = Convert.ToInt32(ddlCategory.SelectedValue);
            if (category == 0)
            {
                pd = from p in db.ProductDetails
                     where
                     SqlMethods.Like(p.ProductName, query)
                     select p;
            }
            else
            {
                pd = from p in db.ProductDetails
                         where 
                         p.CategoryID == category &&
                         SqlMethods.Like(p.ProductName, query)
                         select p;
            }
            gvProducts.DataSource = pd;
            gvProducts.DataBind();
        }

        protected void btnBackUp_Click(object sender, EventArgs e)
        {
            int toInsert = 0; // The number of data should be backup
            int isInsert = 0; // The number of data successful backup
            foreach (var p in db.ProductDetails)
            {
                if (!dbBackup.Product_backups.Any(x => x.ProductName == p.ProductName))
                {
                    toInsert++;
                    int pid;
                    if (dbBackup.Product_backups.Count() > 0)
                    {
                        var result = dbBackup.Product_backups.OrderByDescending(x => x.ProductID).First();
                        pid = result.ProductID + 1;
                    }
                    else
                    {
                        pid = 1;
                    }
                    Product_backup p_bak = new Product_backup
                    {
                        ProductID = pid,
                        ProductName = p.ProductName,
                        ProductImage = p.ProductImage,
                        ProductDescription = p.ProductDescription,
                        ProductQuantity = p.ProductQuantity,
                        ProductPrice = p.ProductPrice,
                        Publish = false
                    };
                    dbBackup.Product_backups.InsertOnSubmit(p_bak);
                    if (BackupSubmitChange())
                    {
                        var categ = dbBackup.Category_backups.Single(x => x.CategoryName == p.CategoryName);
                        Product_Category_backup pc_bak = new Product_Category_backup
                        {
                            CategoryID = categ.CategoryID,
                            ProductID = pid
                        };
                        dbBackup.Product_Category_backups.InsertOnSubmit(pc_bak);
                        if (BackupSubmitChange())
                        {
                            isInsert++;
                        }
                    }
                }
            }
            if (toInsert == 0)
            {
                successMessage = "All data has been backed up";
                alertSuccess.Visible = true;
            }
            else if (toInsert == isInsert && toInsert != 0)
            {
                successMessage = "Successful backup " + isInsert + " row of data";
                alertSuccess.Visible = true;
            }
            else if (toInsert > isInsert)
            {
                errorMessage = "Failed to backup " + (toInsert - isInsert) + " row of data! Categories for those product might not exists.";
                alertFail.Visible = true;
            }
            else
            {
                errorMessage = "Failed to backup the data! Please try again.";
                alertFail.Visible = true;
            }
        }

        protected void btnRestore_Click(object sender, EventArgs e)
        {
            int toInsert = 0; // The number of data should be restore
            int isInsert = 0; // The number of data successful restore
            foreach (var p_bak in dbBackup.Product_backups)
            {
                if (!db.Products.Any(x => x.ProductName == p_bak.ProductName))
                {
                    toInsert++;
                    int pid;
                    if (db.Products.Count() > 0)
                    {
                        var result = db.Products.OrderByDescending(x => x.ProductID).First();
                        pid = result.ProductID + 1;
                    }
                    else
                    {
                        pid = 1;
                    }
                    Assignment.Product p = new Assignment.Product
                    {
                        ProductID = pid,
                        ProductName = p_bak.ProductName,
                        ProductImage = p_bak.ProductImage,
                        ProductDescription = p_bak.ProductDescription,
                        ProductQuantity = p_bak.ProductQuantity,
                        ProductPrice = p_bak.ProductPrice,
                        Publish = false
                    };
                    db.Products.InsertOnSubmit(p);
                    if (SubmitChanges())
                    {
                        var bak = from ppcc in dbBackup.Product_Category_backups
                                  from cc in dbBackup.Category_backups
                                  where ppcc.ProductID == p_bak.ProductID && ppcc.CategoryID == cc.CategoryID
                                  select new { cc.CategoryName};
                        var c_bak = bak.Single();
                        var categ = db.Categories.Single(x => x.CategoryName == c_bak.CategoryName);
                        Product_Category pc = new Product_Category
                        {
                            CategoryID = categ.CategoryID,
                            ProductID = pid
                        };
                        db.Product_Categories.InsertOnSubmit(pc);
                        if (SubmitChanges())
                        {
                            isInsert++;
                        }
                    }
                }
            }

            if (toInsert == 0)
            {
                successMessage = "All data has been restored";
                alertSuccess.Visible = true;
            }
            else if (toInsert == isInsert && toInsert != 0)
            {
                successMessage = "Successful restore " + isInsert + " row of data";
                alertSuccess.Visible = true;
            }
            else if (toInsert > isInsert)
            {
                errorMessage = "Failed to restore " + (toInsert - isInsert) + " row of data!";
                alertFail.Visible = true;
            }
            else
            {
                errorMessage = "Failed to restore the data! Please try again.";
                alertFail.Visible = true;
            }
            gvProducts.DataSource = db.ProductDetails;
            gvProducts.DataBind();
        }

        public bool SubmitChanges()
        {
            try
            {
                db.SubmitChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            gvProducts.DataSource = db.ProductDetails;
            gvProducts.DataBind();
        }

        public bool BackupSubmitChange()
        {
            try
            {
                dbBackup.SubmitChanges();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }

}


