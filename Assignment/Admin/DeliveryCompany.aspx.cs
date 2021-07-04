using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Assignment.Admin
{
    public partial class DeliveryCompany1 : System.Web.UI.Page
    {
        AssignmentDBDataContext db = new AssignmentDBDataContext();
        AssignmentDBBackupDataContext dbBackup = new AssignmentDBBackupDataContext();
        public static string successMessage, errorMessage, itemShown;
        public static string logoStr;
        public int editIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                alertSuccess.Visible = false;
                alertFail.Visible = false;
                successMessage = "";
                errorMessage = "";
                ValidationSummary1.Enabled = false;

                logoStr = "";
                //FileUpload fl1 = (FileUpload)e.Row[rowindex].Cells<cellindex>.FindControl("File1")
            statusButton();
            }

        }

        //Add Delivery Company
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string path = Server.MapPath("../images/Delivery_Company/");
                string cLogo = "";
                //check if user has selected a file
                if (fulCompanyLogo.HasFile)
                {
                    try
                    {
                        cLogo = "../images/Delivery_Company/" + fulCompanyLogo.FileName;
                        fulCompanyLogo.SaveAs(path + fulCompanyLogo.FileName);
                    }
                    catch
                    {
                        errorMessage = "Failed to save the file to specify location!";
                        alertFail.Visible = true;
                    }
                }

                int companyID = 1;
                if (db.DeliveryCompanies.Any())
                {
                    var result = db.DeliveryCompanies.OrderByDescending(dc => dc.CompanyID).First();
                    companyID = result.CompanyID + 1;
                }
                
                Assignment.DeliveryCompany DCompany = new Assignment.DeliveryCompany
                {
                    CompanyID = companyID,
                    CompanyName = txtCompanyName.Text,
                    CompanyLogo = cLogo,
                    PricePerKG = Convert.ToDecimal(txtPricePerKG.Text),
                    Status = chkStatus.Checked
                };
                db.DeliveryCompanies.InsertOnSubmit(DCompany);
                if (SubmitChanges())
                {
                    successMessage = "Delivery Company: <b>" + DCompany.CompanyName + "</b>, successful added!";
                    alertSuccess.Visible = true;
                }
                else
                {
                    errorMessage = "Delivery Company: <b>" + DCompany.CompanyName + "</b>, failed to add! Please try again.";
                    alertFail.Visible = true;
                }
                gvDelivery.DataBind();
                Response.Redirect("DeliveryCompany.aspx");
            }
        }
        
        protected void gvDelivery_RowCreated(object sender, GridViewRowEventArgs e)
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
       
        protected void gvDelivery_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            statusButton();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblItemIndex = e.Row.FindControl("lblItemIndex") as Label;
                itemShown = "<b>Showing: " +
                            (1 + (gvDelivery.PageSize * gvDelivery.PageIndex)).ToString() +
                            " to " +
                            (Convert.ToInt32(lblItemIndex.Text) + (gvDelivery.PageSize * gvDelivery.PageIndex)).ToString() +
                            " of " +
                            (from od in db.DeliveryCompanies select od).Count().ToString() +
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

        protected void gvDelivery_RowEditing(object sender, GridViewEditEventArgs e)
        {
            RequiredFieldValidator1.Enabled = false;
            RequiredFieldValidator2.Enabled = false;
            RequiredFieldValidator3.Enabled = false;
            RegularExpressionValidator1.Enabled = false;
            ValidationSummary1.Enabled = true;
            editIndex = e.NewEditIndex;
        }

        protected void gvDelivery_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvDelivery.Rows[e.RowIndex];
            System.Web.UI.WebControls.FileUpload ful = (System.Web.UI.WebControls.FileUpload)row.Cells[2].FindControl("fulLogo");
            HiddenField fh = gvDelivery.Rows[e.RowIndex].FindControl("hfCompanyID") as HiddenField;
            string path = Server.MapPath("../images/Delivery_Company/");
            string imgName = ful.FileName;

            if (fh != null)
            {
                Assignment.DeliveryCompany company = db.DeliveryCompanies.SingleOrDefault(dc => dc.CompanyID == Convert.ToInt32(fh.Value));
                string oldLogo = company.CompanyLogo;
                company.CompanyLogo = "../images/Delivery_Company/" + imgName;
                TextBox tb = gvDelivery.Rows[e.RowIndex].FindControl("TextBox2") as TextBox;
                if(tb != null)
                {
                    company.PricePerKG = Convert.ToDecimal(tb.Text);
                }
                FileInfo file = new FileInfo(path + oldLogo);

                company.CompanyLogo = oldLogo;
                if (ful.HasFile)
                {
                    company.CompanyLogo = "../images/Delivery_Company/" + imgName;
                    ful.SaveAs(path + imgName);

                    if (file.Exists)//check old file exsit or not  
                    {

                        file.Delete();
                        successMessage = oldLogo + "file deleted successfully";
                        alertSuccess.Visible = true;
                    }
                    else
                    {
                        errorMessage = oldLogo + "file is not exists";
                        alertFail.Visible = false;
                    }
                }
                db.SubmitChanges();
            }
        }
        
        protected void gvDelivery_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            Response.Redirect("DeliveryCompany.aspx");
        }
        
        protected void gvDelivery_Sorting(object sender, GridViewSortEventArgs e)
        {
            statusButton();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string name = args.Value;
            HiddenField hf = gvDelivery.Rows[editIndex].FindControl("hfCompanyID") as HiddenField;
            if (hf != null) 
            {
                if (db.DeliveryCompanies.Any(x => x.CompanyName == name && x.CompanyID != Convert.ToInt32(hf.Value)))
                {
                    args.IsValid = false;
                }
            }
        }

        protected void gvDelivery_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cid = Convert.ToInt32(gvDelivery.DataKeys[e.RowIndex].Values[0]);
            DeliveryCompany dc = db.DeliveryCompanies.Single(x => x.CompanyID == cid);
            if (db.OrderDetails.Count(x => x.CompanyName == dc.CompanyName) > 0)
            {
                int count = db.OrderDetails.Count(x => x.CompanyName == dc.CompanyName);
                errorMessage = "Unable to delete <b>" + dc.CompanyName + "</b>! There are <b>" + count + "</b> order under this delivery company.";
                alertFail.Visible = true;
            }
            else
            {
                try
                {
                    db.DeliveryCompanies.DeleteOnSubmit(dc);
                    db.SubmitChanges();
                    gvDelivery.DataBind();
                }
                catch
                {

                }
            }
        }

        protected void dsDelivery_Deleting(object sender, LinqDataSourceDeleteEventArgs e)
        {
            var delivery = (DeliveryCompany)e.OriginalObject;

            if (db.OrderDetails.Count(x => x.CompanyName == delivery.CompanyName) > 0)
            {
                e.Cancel = true;
                int count = db.OrderDetails.Count(x => x.CompanyName == delivery.CompanyName);
                errorMessage = "Unable to delete <b>" + delivery.CompanyName + "</b>! There are <b>" + count + "</b> order under this delivery company.";
                alertFail.Visible = true;
            }
            else
            {
                var toDlt = db.DeliveryCompanies.SingleOrDefault(x => x.CompanyID == delivery.CompanyID);
                db.DeliveryCompanies.DeleteOnSubmit(toDlt);
                 db.SubmitChanges();
            }
        }

        protected void btnBackUp_Click(object sender, EventArgs e)
        {
            int toInsert = 0; // The number of data should be backup
            int isInsert = 0; // The number of data successful backup
            foreach (var dc in db.DeliveryCompanies)
            {
                if (!dbBackup.DeliveryCompany_backups.Any(x => x.CompanyName == dc.CompanyName))
                {
                    toInsert++;

                    int cid;
                    if (dbBackup.DeliveryCompany_backups.Count() > 0)
                    {
                        var result = dbBackup.DeliveryCompany_backups.OrderByDescending(x => x.CompanyID).First();
                        cid = result.CompanyID + 1;
                    }
                    else
                    {
                        cid = 1;
                    }

                    Assignment.DeliveryCompany_backup dc_bak = new Assignment.DeliveryCompany_backup
                    {
                        CompanyID = cid,
                        CompanyName = dc.CompanyName,
                        CompanyLogo = dc.CompanyLogo,
                        PricePerKG = dc.PricePerKG,
                        Status = false
                    };

                    dbBackup.DeliveryCompany_backups.InsertOnSubmit(dc_bak);
                    if (BackupSubmitChange())
                    {
                        isInsert++;
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
                    errorMessage = "Failed to backup " + (toInsert - isInsert) + " row of data";
                    alertFail.Visible = true;
                }
                else
                {
                    errorMessage = "Failed to backup the data! Please try again.";
                    alertFail.Visible = true;
                }
            }
        }
        
        protected void btnRestore_Click(object sender, EventArgs e)
        {
            int toInsert = 0; // The number of data should be restore
            int isInsert = 0; // The number of data successful restore
            foreach (var dc_bak in dbBackup.DeliveryCompany_backups)
            {
                if (!db.DeliveryCompanies.Any(x => x.CompanyName == dc_bak.CompanyName))
                {
                    toInsert++;

                    int cid;
                    if (db.DeliveryCompanies.Count() > 0)
                    {
                        var result = db.DeliveryCompanies.OrderByDescending(x => x.CompanyID).First();
                        cid = result.CompanyID + 1;
                    }
                    else
                    {
                        cid = 1;
                    }

                    Assignment.DeliveryCompany dc = new Assignment.DeliveryCompany
                    {
                        CompanyID = cid,
                        CompanyName = dc_bak.CompanyName,
                        CompanyLogo = dc_bak.CompanyLogo,
                        PricePerKG = dc_bak.PricePerKG,
                        Status = false
                    };

                    db.DeliveryCompanies.InsertOnSubmit(dc);
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
            gvDelivery.DataSourceID = "";
            gvDelivery.DataSource = db.DeliveryCompanies;
            gvDelivery.DataBind();
        }

        public void statusButton()
        {
            foreach (GridViewRow row in gvDelivery.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (row.FindControl("btnStatus") != null)
                    {
                        Button btnStatus = row.FindControl("btnStatus") as Button;
                        string isActive = (string)btnStatus.CommandArgument;

                        if (isActive == "True")
                        {
                            btnStatus.Text = "Active";
                            btnStatus.CssClass = "btn btn-success";
                        }
                        else
                        {
                            btnStatus.Text = "Inactive";
                            btnStatus.CssClass = "btn btn-danger";
                        }
                    }
                }
            }
        }

        protected void btnStatus_Command(object sender, CommandEventArgs e)
        {
            string cid = e.CommandName.ToString();
            string status = e.CommandArgument.ToString();
            Assignment.DeliveryCompany dc = db.DeliveryCompanies.Single(x => x.CompanyID == Convert.ToInt32(cid));
            if (dc.Status)
            {
                dc.Status = false;
            }
            else
            {
                dc.Status = true;
            }
            db.SubmitChanges();
            Response.Redirect("DeliveryCompany.aspx");
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
    }
}