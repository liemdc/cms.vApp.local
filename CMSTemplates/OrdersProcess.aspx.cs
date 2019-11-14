using CMS.CMSHelper;
using CMS.UIControls;
using DevExpress.Web;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_OrdersProcess : TemplatePage {
    protected void Page_Load(object sender, EventArgs e) {
    }
    protected void OnCustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e) {
        if (e.Column.Caption == "Num")
            e.DisplayText = string.Format("{0:#,###}", e.VisibleRowIndex + 1);
    }
    protected void GvLevelAA_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["ProcessListId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelAA_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e) {
        Session["ProjectTaskID"] = e.EditingKeyValue;
    }
    protected void GvLevelAAA_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e) {
        Session["ProjectTaskID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelAAA_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["ProjectTaskID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelAA_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e) {        
        if ((int)e.GetValue("ProjectTaskPriorityID") == 2)
            e.Cell.ForeColor = ColorTranslator.FromHtml("#F77E0E");
        else if ((int)e.GetValue("ProjectTaskPriorityID") == 3)
            e.Cell.ForeColor = ColorTranslator.FromHtml("#0FAA15");
        if (e.GetValue("ProcessPlusBrowse") != null)
            e.Cell.ForeColor = ColorTranslator.FromHtml("#FF0000");
        if ((bool)e.GetValue("DX_XuatHang_TruocDuKien") == true)
            e.Cell.ForeColor = ColorTranslator.FromHtml("#FF0000");
    }
    protected void GvLevelAA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan" + (sender as ASPxGridView).GetMasterRowKeyValue(), "CapNhatSanPham"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelAAA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {            
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan" + Session["ProcessListId"], "CapNhatLoaiViec")) {
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
            }
        }
    }
}