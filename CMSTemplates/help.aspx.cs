using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.CMSHelper;

public partial class CMSTemplates_help : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btnImageAndText_Click(object sender, EventArgs e)
    {
        if (txtTitle.Text.Length > 2)
        {
            CMS.EmailEngine.EmailMessage em = new CMS.EmailEngine.EmailMessage();
            em.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
            em.From = "noreply@ungdungtinhoc.com";
            em.Recipients = "nmhieu@ungdungtinhoc.com";
            em.Subject = txtTitle.Text;
            em.Body = editor.Value;

            CMS.EmailEngine.EmailSender.SendEmail(CMSContext.Current.SiteName, em);
        }
    }
}