using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Assignment
{
    public class Global : System.Web.HttpApplication
    {
        public const string connectingString = @"
            Data Source = (LocalDB)\mssqllocaldb;
            AttachDbFilename=|DataDirectory|\AssignmentDB.mdf;
            Integrated Security=True
        ";

        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            Security.ProcessRoles();
        }

        protected void Application_Start(object sender, EventArgs e)
        {
            Application["Visitors"] = 0;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Application["Visitors"] = (int)Application["Visitors"] + 1;
            Application["VisitDateTime"] = DateTime.Now;

            AssignmentDBDataContext db = new AssignmentDBDataContext();
            Visitor v = new Visitor
            {
                Visit = Convert.ToDateTime(DateTime.Now),
            };
            db.Visitors.InsertOnSubmit(v);
            db.SubmitChanges();
            Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Headers.Add("X-Frame-Options", "DENY");
            HttpContext.Current.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
            HttpContext.Current.Response.Headers.Add("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload");
            HttpContext.Current.Response.Headers.Add("X-Content-Type-Options", "nosniff");
            HttpContext.Current.Response.Headers.Add("Content-Security-Policy",
                "default-src 'self' 'unsafe-inline' 'unsafe-eval' https://localhost:* wss: https://unpkg.com/ https://www.facebook.com/; " +
                "style-src-elem 'self' 'unsafe-inline' https://unpkg.com/ https://rawgit.com/;" +
                "style-src 'self' 'unsafe-inline' https://unpkg.com/;" +
                "script-src-elem 'self' 'unsafe-inline' 'unsafe-eval' https://localhost:* https://unpkg.com/ https://code.jquery.com/ https://rawgit.com/ https://www.google.com/recaptcha/api.js https://connect.facebook.net/ https://www.gstatic.com/recaptcha/releases/ https://platform.twitter.com/widgets.js https://platform.twitter.com; " +
                "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com/ https://platform.twitter.com; " +
                "img-src 'self' data: https://localhost:* https://unpkg.com/ http://www.w3.org/200 https://www.facebook.com/ https://web.facebook.com/; " +
                "frame-src 'self' https://unpkg.com/ https://web.facebook.com/ https://www.google.com/ https://www.facebook.com https://platform.twitter.com/; " +
                "object-src 'self' 'unsafe-eval';" +
                "connect-src 'self' wss: https://localhost:* https://dc.services.visualstudio.com/v2/track https://www.facebook.com/x/oauth/ https://z-p3-graph.facebook.com/ https://graph.facebook.com;"
                );
            /*HttpContext.Current.Response.Headers.Remove("Server");
            HttpContext.Current.Response.Headers.Remove("X-AspNetWebPages-Version");
            HttpContext.Current.Response.Headers.Remove("X-AspNet-Version");
            HttpContext.Current.Response.Headers.Remove("X-Powered-By");
            HttpContext.Current.Response.Headers.Remove("X-AspNetMvc-Version");*/
        }

            protected void Application_AuthenticateRequest(object sender, EventArgs e)
            {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
           
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}