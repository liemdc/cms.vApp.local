using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using CMS.UIControls;

public partial class _Default : TemplatePage
{
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        this.lblText.Text = "Hiện tại website chưa có nội dung. Click vào đường dẫn <a href=\"" + ResolveUrl("~/AdminPages/") + "\">quản trị</a> để chỉnh sửa nội dung của website.";
        this.ltlTags.Text = this.HeaderTags;
    }
}
