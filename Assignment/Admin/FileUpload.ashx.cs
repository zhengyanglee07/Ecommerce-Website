using System;
using System.Text.RegularExpressions;
using System.Web;

namespace Assignment.Admin
{
    /// <summary>
    /// Summary description for FileUpload
    /// </summary>
    /// 
    public class FileUpload : IHttpHandler
    {
        public static int index;
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string FilesPath = HttpContext.Current.Server.MapPath("~/images/Product_Images/");
                string uploadedFile = null;
                string imgName = "";
                string pimg = Regex.Replace(Guid.NewGuid() + "", " ", "");
                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    int fileSizeInBytes = file.ContentLength;
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        if (fileSizeInBytes > 1000000)
                        {
                            context.Response.Write("toobig");
                        }
                        else
                        {
                            imgName = pimg + fileName;
                            string path = FilesPath + imgName;
                            file.SaveAs(path);
                            if (uploadedFile == null)
                            {
                                uploadedFile = imgName;
                            }
                            else
                            {
                                uploadedFile = uploadedFile + "," + imgName;
                            }
                            context.Response.Write(uploadedFile);
                            /*if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".gif" || fileExtension == ".jpeg")
                            {
                                imgName = pimg + fileName;
                                string path = FilesPath + imgName;
                                file.SaveAs(path);
                                if (uploadedFile == null)
                                {
                                    uploadedFile = imgName;
                                }
                                else
                                {
                                    uploadedFile = uploadedFile + "," + imgName;
                                }
                                context.Response.Write(uploadedFile);
                            }
                            else
                            {
                                context.Response.Write("invalidType");

                            }*/
                        }

                    }
                }
            }
            catch (Exception ex)
            {

                context.Response.Write("ERROR: " + ex.Message);
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}