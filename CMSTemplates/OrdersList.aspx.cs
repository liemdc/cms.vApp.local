using CMS.CMSHelper;
using CMS.ProjectManagement;
using CMS.UIControls;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_OrdersList : TemplatePage {
    protected void Page_Load(object sender, EventArgs e){
        if (!IsPostBack) {
            CbExportMode.Items.AddRange(Enum.GetNames(typeof(GridViewDetailExportMode)));
            CbExportMode.Text = GridViewDetailExportMode.Expanded.ToString();
        }
    }
    protected void OnCustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e) {
        if (e.Column.Caption == "Num")
            e.DisplayText = string.Format("{0:#,###}", e.VisibleRowIndex + 1);
    }
    protected void PageControl_Load(object sender, EventArgs e) {
        PageControl.TabPages.FindByName("OrdersListTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DonHang");
        PageControl.TabPages.FindByName("OrdersListNdTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DonHang");
        PageControl.TabPages.FindByName("CustomerTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "KhachHang");
        PageControl.TabPages.FindByName("MoldsTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "LoaiKhuon");
    }
    Hashtable copiedValues = null;
    protected string[] copiedFields = new string[] { "ProjectTaskMoldCode", "ProjectTaskOverlayNum", "ProjectTaskHoleNum", "ProjectTaskDiameterOut", "ProjectTaskMaterialsRequire", "ProjectTaskMaterialsCode", "ProjectTaskMaterialsCode", "ProjectTaskMoldsId", "ProjectTaskThickness", "ProjectTaskThicknessTotal", "ProjectTaskQuantities", "ProjectTaskContainHead", "ProjectTaskQuantities", "ProjectTaskContainHead", "ProjectTaskBottoHob", "ProjectTaskChildNote", "ProjectTaskHorikomi", "ProjectTaskHardness", "ProjectTaskCustomerId", "ProjectTaskTransmit", "ProjectTaskDeadline", "ProjectTaskDescription" };
    protected void GvLevelA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "ThemMoi"))
                e.Items.Add("Clone Product", "CloneProduct", "/App_Themes/images/NewIcon.png");
        }
    }
    protected void GvLevelB_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelC_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("KhachHang", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("KhachHang", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("KhachHang", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelD_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelDA_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {            
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelBA_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {            
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelDA_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["MoldsId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelBA_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["ProjectTaskID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void OdsLevelA_Inserted(object sender, ObjectDataSourceStatusEventArgs e) {
        ASPxCheckBox CkMethod = GvLevelA.FindEditFormTemplateControl("CkMethod") as ASPxCheckBox;
        if (CkMethod.Checked)
            throw new Exception("<p style='color:#000000 !important;margin:0;font-weight:bold;font-family:Arial'>Đang nhập ở chế độ nhập liên tiếp.</p>");
    }
    protected void GvLevelA_ContextMenuItemClick(object sender, ASPxGridViewContextMenuItemClickEventArgs e) {
        switch (e.Item.Name) {
            case "CloneProduct":
                copiedValues = new Hashtable();
                foreach (string fieldName in copiedFields)
                    copiedValues[fieldName] = GvLevelA.GetRowValues(e.ElementIndex, fieldName);
                GvLevelA.AddNewRow();
                break;
            default:
                break;
        }

    }
    protected void GvLevelA_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e) {
        if (copiedValues == null) return;
        foreach (string fieldName in copiedFields)
            e.NewValues[fieldName] = copiedValues[fieldName];
    }
    protected void CbTaskData_TextChanged(object sender, EventArgs e) {
        GvLevelB.DataBind();
    }

    protected void UpdateExportMode() {
        GvLevelB.SettingsDetail.ExportMode = (GridViewDetailExportMode)Enum.Parse(typeof(GridViewDetailExportMode), CbExportMode.Text);
    }
    protected void btnXlsExport_Click(object sender, EventArgs e) {
        UpdateExportMode();
        GvExport.WriteXlsToResponse(string.Format("ExportXls {0}", DateTime.Now.Date.ToShortDateString()), new XlsExportOptionsEx() { ExportType = ExportType.WYSIWYG });
    }
    protected void btnXlsxExport_Click(object sender, EventArgs e) {
        UpdateExportMode();
        GvExport.WriteXlsxToResponse(string.Format("ExportXlsx {0}", DateTime.Now.Date.ToShortDateString()), new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
    }
}