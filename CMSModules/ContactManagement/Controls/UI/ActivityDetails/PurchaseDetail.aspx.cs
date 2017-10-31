using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.SettingsProvider;
using CMS.OnlineMarketing;
using CMS.CMSHelper;

[Security(Resource = "CMS.ContactManagement", Permission = "ReadActivities")]
public partial class CMSModules_ContactManagement_Controls_UI_ActivityDetails_PurchaseDetail : CMSModalPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ActivityHelper.AuthorizedReadActivity(CMSContext.CurrentSiteID, true))
        {
            if (!QueryHelper.ValidateHash("hash"))
            {
                return;
            }

            if (!ModuleEntry.IsModuleLoaded(ModuleEntry.ECOMMERCE))
            {
                return;
            }

            int orderid = QueryHelper.GetInteger("orderid", 0);

            // Get order object
            GeneralizedInfo infoObj = CMSObjectHelper.GetReadOnlyObject(PredefinedObjectType.ORDER);
            if (infoObj != null)
            {
                BaseInfo order = infoObj.GetObject(orderid);
                if (order != null)
                {
                    ltl.Text = order.GetStringValue("OrderInvoice", "");
                }
            }

            CurrentMaster.Title.TitleText = GetString("om.activitydetails.viewinvoicedetail");
            CurrentMaster.Title.TitleImage = GetImagePath("Objects/OM_Activity/object.png");
        }
    }
}
