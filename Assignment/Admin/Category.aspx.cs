using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        Assignment.AssignmentDBBackupDataContext dbBackup = new Assignment.AssignmentDBBackupDataContext();
        public static string successMessage, errorMessage;
        public string itemShown;
        public int editIndex;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                alertSuccess.Visible = false;
                alertFail.Visible = false;
                
                ValidationSummary1.Enabled = false;
                var publish = Request.QueryString["publish"];
                if (publish != null)
                {
                    gvCategory.DataSource = db.Categories.Where(c => c.Publish == Convert.ToBoolean(publish));
                    gvCategory.DataBind();
                }
                else
                {
                    gvBind();
                }
            }

        }

        public void gvBind()
        {
            gvCategory.DataSource = db.Categories;
            gvCategory.DataBind();
        }

        protected void btnCategoryAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string categName = txtCategoryName.Text;
                bool chk = chkPublish1.Checked;

                int cid;
                if (db.Categories.Count() > 0)
                {
                    var result = db.Categories.OrderByDescending(cc => cc.CategoryID).First();
                    cid = result.CategoryID + 1;
                }
                else
                {
                    cid = 1; 
                }

                Assignment.Category c = new Assignment.Category
                {
                    CategoryID = cid,
                    CategoryName = categName,
                    Publish = chk
                };
                db.Categories.InsertOnSubmit(c);
                bool isInsert = SubmitChanges();
                if (isInsert)
                {
                    successMessage = "Category: <b>" + categName + "</b>, successful added!";
                    alertSuccess.Visible = true;
                }
                else
                {
                    errorMessage = "Category: <b>" + categName + "</b>, failed to add! Please try again.";
                    alertFail.Visible = true;
                }
                gvBind();

            }
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvCategory.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkPublish");
                if (row.Cells[1].FindControl("hfCategoryID") != null)
                {
                    Assignment.Category c = db.Categories.Single(cc => cc.CategoryID == Convert.ToInt32((row.Cells[1].FindControl("hfCategoryID") as HiddenField).Value));
                    if (chk.Checked)
                    {
                        c.Publish = true;
                        db.SubmitChanges();
                    }
                    else
                    {
                        c.Publish = false;
                        db.SubmitChanges();
                    }
                }
            }
            gvBind();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string categName = args.Value;

            if (db.Categories.Any(c => c.CategoryName == categName))
            {
                args.IsValid = false;
            }
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            //Enable validation summary to show error when editing, updating
            ValidationSummary1.Enabled = true;

            //Disable validation for category add while updating row in gridview
            RequiredFieldValidator1.Enabled = false;
            CustomValidator1.Enabled = false;
            gvCategory.EditIndex = e.NewEditIndex;
            editIndex = e.NewEditIndex;
            this.gvBind();
        }
       
        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //Get the Category ID and Name and checkbox value from Gridview
            GridViewRow row = gvCategory.Rows[e.RowIndex];  
            int categoryID = Convert.ToInt32(gvCategory.DataKeys[e.RowIndex].Values[0]);
            string categName = (row.Cells[1].FindControl("TextBox1") as TextBox).Text;
            CheckBox ck = row.FindControl("chkPublish") as CheckBox;
                    
            Assignment.Category c = db.Categories.Single(cc => cc.CategoryID == categoryID);
            c.CategoryName = categName;
            c.Publish = ck.Checked;

            gvCategory.EditIndex = -1;
            db.SubmitChanges();
            this.gvBind();
        }
       
        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            gvCategory.EditIndex = -1;
            this.gvBind();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int categoryID = Convert.ToInt32(gvCategory.DataKeys[e.RowIndex].Values[0]);
            Assignment.Category c = db.Categories.Single(cc => cc.CategoryID == categoryID);
            if (db.ProductDetails.Count(pd => pd.CategoryID == categoryID) > 0)
            {
                int count = db.ProductDetails.Count(pd => pd.CategoryID == categoryID);
                errorMessage = "Unable to delete <b>" + c.CategoryName + "</b>, have <b>" + count + "</b> product under this category <br>" +
                    "Click <a href=Product.aspx?cid=" + categoryID + "><b>here</b></a> to view/change those product's categories." ;
                alertFail.Visible = true;
            }
            else
            {
                db.Categories.DeleteOnSubmit(c);
                db.SubmitChanges();
                this.gvBind();
            }
        }

        protected void gvCategory_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            Response.Redirect("Category.aspx");
        }

        protected void gvCategory_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvCategory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblItemIndex = e.Row.FindControl("lblItemIndex") as Label;
                itemShown = "<b>Showing: " +
                            (1 + (gvCategory.PageSize * gvCategory.PageIndex)).ToString() +
                            " to " +
                            Convert.ToInt32(lblItemIndex.Text).ToString() +
                            " of " +
                            (from od in db.Categories select od).Count().ToString() +
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

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string name = args.Value;
            HiddenField hf =  gvCategory.Rows[editIndex].FindControl("hfCategoryID") as HiddenField;
            if (db.Categories.Any(x => x.CategoryName == name && x.CategoryID != Convert.ToInt32(hf.Value)))
            {
                args.IsValid = false;
            }
 
        }

        protected void btnSearch_Click1(object sender, EventArgs e)
        {
            String query = "%%";
            if (txtSearch.Text != String.Empty)
            {
                query = "%" + txtSearch.Text + "%";
            }

            var categories = from x in db.Categories
                             where
                             SqlMethods.Like(x.CategoryName, query)
                             select x;
            gvCategory.DataSource = categories;
            gvCategory.DataBind();
        }

        protected void btnBackUp_Click(object sender, EventArgs e)
        {
            int toInsert = 0; // The number of data should be backup
            int isInsert = 0; // The number of data successful backup
            foreach(var c in db.Categories)
            {
                if (!dbBackup.Category_backups.Any(x => x.CategoryName == c.CategoryName))
                {
                    toInsert++;

                    int cid;
                    if (dbBackup.Category_backups.Count() > 0)
                    {
                        var result = dbBackup.Category_backups.OrderByDescending(cc => cc.CategoryID).First();
                        cid = result.CategoryID + 1;
                    }
                    else
                    {
                        cid = 1;
                    }

                    if (c.CategoryName == "None")
                    {
                        cid = 0;
                    }
                    Assignment.Category_backup c_bak = new Assignment.Category_backup
                    {
                        CategoryID = cid,
                        CategoryName = c.CategoryName,
                        Publish = false
                    };
                    dbBackup.Category_backups.InsertOnSubmit(c_bak);
                    if (BackupSubmitChange())
                    {
                        isInsert++;
                    }
                }
            }

            if (toInsert == 0) 
            {
                successMessage = "All data has been backed up";
                alertSuccess.Visible = true;
            }
            else if(toInsert == isInsert && toInsert != 0)
            {
                successMessage = "Successful backup " + isInsert + " row of data";
                alertSuccess.Visible = true;
            }
            else if(toInsert > isInsert)
            {
                errorMessage = "Failed to backup " + (toInsert - isInsert) + " row of data";
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
            foreach (var c_bak in dbBackup.Category_backups)
            {
                if (!db.Categories.Any(x => x.CategoryName == c_bak.CategoryName))
                {
                    toInsert++;

                    int cid;
                    if (db.Categories.Count() > 0)
                    {
                        var result = db.Categories.OrderByDescending(cc => cc.CategoryID).First();
                        cid = result.CategoryID + 1;
                    }
                    else
                    {
                        cid = 1;
                    }   
                    if(c_bak.CategoryName == "None")
                    {
                        cid = 0;
                    }
                    Assignment.Category c = new Assignment.Category
                    {
                        CategoryID = cid,
                        CategoryName = c_bak.CategoryName,
                        Publish = false
                    };
                    db.Categories.InsertOnSubmit(c);
                    if (SubmitChanges())
                    {
                        isInsert++;
                    }
                }
            }

            if (toInsert == 0)
            {
                successMessage = "All data has been restored";
                alertSuccess.Visible = true;
            }
            else if (toInsert == isInsert)
            {
                successMessage = "Successful restore " + isInsert + " row of data";
                alertSuccess.Visible = true;
            }
            else if (toInsert > isInsert)
            {
                errorMessage = "Failed to restore " + (toInsert - isInsert) + " row of data";
                alertFail.Visible = true;
            }
            else
            {
                errorMessage = "Failed to restore the data! Please try again.";
                alertFail.Visible = true;
            }
            gvBind();
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

        protected void gvCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategory.PageIndex = e.NewPageIndex;
            gvBind();
        }
    }
}