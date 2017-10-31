using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.CMSHelper;
using CMS.SiteProvider;
using CMS.UIControls;
public partial class CMSTemplates_login : TemplatePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CMSContext.IsAuthenticated())
            Response.Redirect("~/");
    }
    protected void btnDangNhap_Click(object sender, EventArgs e)
    {
        UserInfo user = CMS.SiteProvider.UserInfoProvider.AuthenticateUser(txtUser.Text.Trim(), txtPass.Text.Trim(), CMSContext.CurrentSiteName);
        if (user != null)
        {
            System.Web.Security.FormsAuthentication.SetAuthCookie(user.UserName, true);
            CMSContext.SetCurrentUser(new CMS.CMSHelper.CurrentUserInfo(user, true));
            CMS.SiteProvider.UserInfoProvider.SetPreferredCultures(user);
            Response.Redirect(CMSUtils.GetRequestNodeAlias, true);
            Response.Redirect("~/");
        }
    }
}