using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.UIControls;
using CMS.ExtendedControls;
public partial class CMSTemplates_Controls_VMMP : TemplateMasterPage
{
    #region "Methods"

    protected override void OnInit(EventArgs e){
        base.OnInit(e);
    }

    protected override void OnPreRender(EventArgs e){
        base.OnPreRender(e);
        this.ltlTags.Text = this.HeaderTags;
    }

    protected void Page_Load(object sender, EventArgs e){
    }

    #endregion
}
