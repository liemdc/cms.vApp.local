using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.UIControls;
using CMS.CMSHelper;
using System.Web.Security;

public partial class CMSTemplates_LogOut : TemplatePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CMSContext.IsAuthenticated()){
            FormsAuthentication.SignOut();
            Response.Redirect("/");
        }
    }
}