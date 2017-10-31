using CMS.CMSHelper;
using CMS.UIControls;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_SystemConfig : TemplatePage {
    protected void Page_Load(object sender, EventArgs e){
    }    
    protected void OnCustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e) {
        if (e.Column.Caption == "Num")
            e.DisplayText = string.Format("{0:#,###}", e.VisibleRowIndex + 1);
    } 
    protected void PageControl_Load(object sender, EventArgs e) {
        PageControl.TabPages.FindByName("UsersTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "QuanLyNguoiDung");
        PageControl.TabPages.FindByName("GroupsTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhomNguoiDung");
    }
    protected void GvLevelA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("QuanLyNguoiDung", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("QuanLyNguoiDung", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("QuanLyNguoiDung", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelB_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelBNd_BeforePerformDataSelect(object sender, EventArgs e) {
        ASPxGridView GridForm = sender as ASPxGridView;
        Session["RoleName"] = GridForm.GetMasterRowKeyValue();
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Sua"))
            GridForm.SettingsEditing.Mode = GridViewEditingMode.Batch;
    }
    protected void GvLevelBRd_BeforePerformDataSelect(object sender, EventArgs e) {
        ASPxGridView GridForm = sender as ASPxGridView;
        Session["RoleGroupId"] = GridForm.GetMasterRowKeyValue();
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Sua"))
            GridForm.SettingsEditing.Mode = GridViewEditingMode.Batch;
    }
    protected void GvLevelBC_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["RoleName"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelBC_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelBatch_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }   
}