using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.IO;

namespace Assignment.Admin
{
    public partial class ProductAction : System.Web.UI.Page
    {
        Assignment.AssignmentDBDataContext db = new Assignment.AssignmentDBDataContext();
        public static string successMessage, errorMessage;
        public static string imgStr, imgToDelete;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                imgStr = imgToDelete = "";
                //By default, hide all div alert
                alertSuccess.Visible = false;
                alertFail.Visible = false;

                //Bind the data for dropdown list of Category
                ddlCategory.DataSource = db.Categories.Where(x => x.Publish == true);
                ddlCategory.DataBind();

                //Check action taken for Product  - If null = add product
                string action = Request.QueryString["action"];
                //If action is edit
                if (action == "edit")
                {
                    title.InnerText = "Product Edit";
                    btnProductAdd.Visible = false;
                    CustomValidator2.Enabled = false;
                    int pid = Convert.ToInt32(Request.QueryString["id"]);
                    edit(pid);
                }
                else
                {
                    title.InnerText = "Product Add";
                    btnProductEdit.Visible = false;
                }
            }

            string act = Request.QueryString["action"];
            if (act == "edit")
            {
                string[] imgs = imgStr.Split(',');
                foreach (string imgName in imgs)
                {
                    if (imgName != "")
                    {
                        previewBox(imgName);
                    }
                }
            }

        }

        protected void btnProductAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtProductName.Text;
                int category = Convert.ToInt32(ddlCategory.SelectedValue);
                string description = txtDescription.Text;
                string image = hiddenField1.Value;
                var price = Convert.ToDecimal(txtPrice.Text);
                int quantity = Convert.ToInt32(txtQuantity.Text);
                bool publish = chkPublish.Checked;

                int pid;
                if (db.Products.Count() > 0)
                {
                    var result = db.Products.OrderByDescending(pp => pp.ProductID).First();
                    pid = result.ProductID + 1;
                }
                else
                {
                    pid = 1;
                }

                Assignment.Product p = new Assignment.Product
                {
                    ProductID = pid,
                    ProductName = name,
                    ProductDescription = description,
                    ProductImage = image,
                    ProductPrice = price,
                    ProductQuantity = quantity,
                    Publish = publish
                };
                db.Products.InsertOnSubmit(p);

                //Add data to Product_Categories table after successful add to Product table
                if (SubmitChanges())
                {
                    Assignment.Product_Category pc = new Assignment.Product_Category
                    {
                        CategoryID = category,
                        ProductID = pid
                    };
                    db.Product_Categories.InsertOnSubmit(pc);
                    if (SubmitChanges())
                    {
                        //If successful added
                        //Alert to show product added
                        successMessage = "Product: <b>" + name + "</b>, successful added! Click <a href='Product.aspx'><b>here</b></a> to view all product";
                        alertSuccess.Visible = true;

                        txtProductName.Text = "";
                        ddlCategory.SelectedValue = "0";
                        txtDescription.Text = "";
                        txtPrice.Text = "";
                        txtQuantity.Text = "";

                    }
                    else
                    {
                        //Remove file from folder if failed to upload, because image will be save to folder after select to upload
                        string[] imgs = image.Split(',');
                        foreach (string delete in imgs)
                        {
                            string FileToDelete = Server.MapPath("~/Images/Product_Images/") + delete;
                            FileInfo file = new FileInfo(FileToDelete.Replace(@"\r\n", ""));
                            if (file.Exists)//check images exsit or not  
                            {
                                file.Delete();
                                Response.Write("<script>alert('Success!!');</script>");
                            }
                        }
                        //Display error message
                        errorMessage = "Product: <b>" + name + "</>, failed to added! Please try again.";
                        alertFail.Visible = true;
                    }
                }
            }
            hiddenField1.Value = "";
        }

        protected void btnProductEdit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int pid = Convert.ToInt32(Request.QueryString["id"]);
                Assignment.Product product = db.Products.SingleOrDefault(p => p.ProductID == pid);
                product.ProductName = txtProductName.Text;
                product.ProductImage = imgStr + hiddenField1.Value;
                product.ProductDescription = txtDescription.Text;
                product.ProductPrice = Convert.ToDecimal(txtPrice.Text);
                product.ProductQuantity = Convert.ToInt32(txtQuantity.Text);
                product.Publish = chkPublish.Checked;

                //Original Product Images String
                string productImg = product.ProductImage;
                string[] imgs = productImg.Split(',');

                //(String) Product Images to delete
                string[] deleteImgs = imgToDelete.Split(',');

                //Create a new Product Images String
                string newImgStr = "";
                newImgStr = string.Join(",", imgs.Where(x => !deleteImgs.Contains(x)).ToArray());
                Response.Write("<script>alert('" + newImgStr + "');</script>");
                //Set newImgStr to null if only have (,)
                if (newImgStr == ",")
                {
                    newImgStr = null;
                }

                //Remove image files from folder
                foreach (string dlt in deleteImgs)
                {
                    string FileToDelete = Server.MapPath("~/Images/Product_Images/") + dlt;
                    FileInfo file = new FileInfo(FileToDelete.Replace(@"\r\n", ""));
                    if (file.Exists)//check images exsit or not  
                    {
                        file.Delete();
                    }
                }

                //Update the new image stirng of product in database
                product.ProductImage = newImgStr;
                db.SubmitChanges();


                //Update data for the Product_Category table
                int cid = Convert.ToInt32(ddlCategory.SelectedValue);
                Assignment.Product_Category p_c = db.Product_Categories.SingleOrDefault(pc => pc.ProductID == pid);
                db.Product_Categories.DeleteOnSubmit(p_c);

                Assignment.Product_Category newPC = new Assignment.Product_Category
                {
                    ProductID = pid,
                    CategoryID = cid
                };
                db.Product_Categories.InsertOnSubmit(newPC);

                if (SubmitChanges())
                {
                    successMessage = "Product: " + product.ProductName + "successful updated!";
                    alertSuccess.Visible = true;

                }
                else
                {
                    errorMessage = "Product: " + product.ProductName + "failed to update! Please try again.";
                    alertFail.Visible = true;
                }
                hiddenField1.Value = "";
                Response.Redirect("ProductAction.aspx?action=edit&id=" + pid);
            }
        }


        //Bind the data on edit page
        public void edit(int pid)
        {
            var productEdit = from p in db.Products
                              from c in db.Categories
                              from pc in db.Product_Categories
                              where p.ProductID == pid && pc.ProductID == pid && c.CategoryID == pc.CategoryID
                              select new
                              {
                                  p.ProductName,
                                  c.CategoryID,
                                  c.CategoryName,
                                  p.ProductDescription,
                                  p.ProductImage,
                                  p.ProductPrice,
                                  p.ProductQuantity,
                                  p.Publish
                              };

            var editP = productEdit.First();
            txtProductName.Text = editP.ProductName;
            ddlCategory.SelectedValue = editP.CategoryID.ToString();
            txtDescription.Text = editP.ProductDescription;
            txtPrice.Text = (Math.Round(editP.ProductPrice, 2)).ToString();
            txtQuantity.Text = editP.ProductQuantity.ToString();
            chkPublish.Checked = editP.Publish;

            imgStr = editP.ProductImage;
        }

        //Create a HTML preview box ( preview the images of product )
        public void previewBox(string imgName)
        {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.Attributes["ID"] = imgName;
            div.Attributes["runat"] = "server";
            div.Attributes["class"] = "preview-box";

            HtmlGenericControl div_a = new HtmlGenericControl("a");

            ImageButton previewImage = new ImageButton();
            previewImage.ImageUrl = "../Images/Product_Images/" + imgName;
            previewImage.AlternateText = "Product Image";
            previewImage.ID = imgName;
            previewImage.Width = 150;
            previewImage.Height = 200;
            previewImage.Visible = true;

            ImageButton deleteBtn = new ImageButton();
            deleteBtn.ImageUrl = "~/Images/Admin/Icons/close.png";
            deleteBtn.CssClass = "preview-box-overlay";
            deleteBtn.Width = 150;
            deleteBtn.Height = 200;
            deleteBtn.Visible = true;
            //deleteBtn.OnClientClick = "return confirm('Are you sure you want to delete folder with files ?');";
            deleteBtn.CommandName = "DeleteImage";
            deleteBtn.CommandArgument = imgName;
            deleteBtn.Command += new CommandEventHandler(DeleteImage);

            divPreview.Controls.Add(div);
            div.Controls.Add(div_a);
            div_a.Controls.Add(deleteBtn);
            div_a.Controls.Add(previewImage);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            int pid = Convert.ToInt32(Request.QueryString["id"]);
            string act = Request.QueryString["action"];
            if (act == "edit")
            {
                Response.Redirect("ProductAction.aspx?action=edit&id=" + pid);
            }
            else
            {
                Response.Redirect("ProductAction.aspx");
            }

        }

        //Validation for Product Name (TO check whether product name is exists)
        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            int pid = Convert.ToInt32(Request.QueryString["id"]);
            string productName = args.Value;

            if (db.Products.Any(p => p.ProductID != pid && p.ProductName == productName))
            {

                args.IsValid = false;
            }
        }

        //Validaation for Image Upload
        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string hfText = hiddenField1.Value;

            if (hfText == String.Empty)
            {
                CustomValidator2.ErrorMessage = "Please choose an product images!";
                args.IsValid = false;
            }
            else
            {
                if (hfText == "toobig")
                {
                    CustomValidator2.ErrorMessage = "File size is too big!";
                    args.IsValid = false;
                }
                else
                {
                    if (hfText == "invalidType")
                    {
                        CustomValidator2.ErrorMessage = "File type is not valid!";
                        args.IsValid = false;
                    }
                }
            }
        }

        protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (Convert.ToInt32(ddlCategory.SelectedValue) == 0)
            {
                args.IsValid = false;
            }
        }

        //Remove image from folder and database
        protected void DeleteImage(object sender, CommandEventArgs e)
        {
            //Prevent the same image name to be added when page refresh
            string imgName = (string)e.CommandArgument;
            string[] imgDLT = imgToDelete.Split(',');
            foreach (string i in imgDLT)
            {
                if (i != imgName)
                {
                    imgToDelete = imgToDelete + "," + imgName;
                }
            }

            //Hide the preview images when click
            string[] imgs = imgStr.Split(',');
            foreach (string i in imgs)
            {
                if (i == imgName)
                {
                    var divImg = divPreview.FindControl(imgName);
                    divImg.Visible = false;
                }
            }
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
    }
}

