using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.UIControls;
public partial class CMSTemplates_changepassword : TemplatePage
{
    protected void Page_Load(object sender, EventArgs e){
        if (!Request.IsAuthenticated)
            cpw.Visible = false;
    }
}