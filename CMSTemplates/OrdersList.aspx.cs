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
    protected void Page_Load(object sender, EventArgs e) {
        int Year = DateTime.Now.Year;
        if (!IsPostBack) {
            CbExportMode.Items.AddRange(Enum.GetNames(typeof(GridViewDetailExportMode)));
            CbExportMode.Text = GridViewDetailExportMode.Expanded.ToString();
            DeStartB.Date = Convert.ToDateTime(string.Format("01/01/{0} 00:00", Year - 5));
            DeEndB.Date = Convert.ToDateTime(string.Format("01/01/{0} 00:00", Year + 5));
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
            //if (!CMSContext.CurrentUser.IsAuthorizedPerResource("LoaiKhuon", "Xoa"))
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
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("DonHang", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
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
        //DataUtils.WriteLog(e.Item.Name);
        //if (e.Item.Name.Equals("CloneProduct")) {
        //    copiedValues = new Hashtable();
        //    foreach (string fieldName in copiedFields)
        //        copiedValues[fieldName] = GvLevelA.GetRowValues(e.ElementIndex, fieldName);
        //    GvLevelA.AddNewRow();
        //} else if (e.Item.Name.Equals("CloneProduct")) {
        //    string KeyValue = (string)GvLevelA.GetRowValues(e.ElementIndex, "ProjectTaskID");
        //    string KeyMaDH = (string)GvLevelA.GetRowValues(e.ElementIndex, "DX_MaDonHang");
        //    DataUtils.WriteLog(KeyValue + KeyMaDH);
        //}
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

    protected void On_DateChangedB(object sender, EventArgs e) {
        GvLevelB.DataBind();
    }

    private string[] GTitle = new string[]{"Dự kiến GC: ", "Dự kiến HT: ", "Thực tế HT: "};
    private string[] GField = new string[]{"DX_DuKienHT_EDM", "DX_ThucTeHT_EDM", "DX_DuKienHT_Mai", "DX_ThucTeHT_Mai", "DX_DuKienHT_MaiSNK", "DX_ThucTeHT_MaiSNK", "DX_DuKienHT_MC", "DX_ThucTeHT_MC", "DX_DuKienHT_NC", "DX_ThucTeHT_NC", "DX_DuKienHT_Nhiet", "DX_ThucTeHT_Nhiet", "DX_DuKienHT_PhayTay", "DX_ThucTeHT_PhayTay", "DX_DuKienHT_QA", "DX_ThucTeHT_QA", "DX_DuKienHT_WEDM", "DX_ThucTeHT_WEDM", "DX_DuKienHT_LapRap", "DX_ThucTeHT_LapRap"};
    private void SetColumns(ASPxGridView dataGrid, Boolean valid) {
        for (int i = 0; i < GField.Length; i++) {
            GridViewDataDateColumn dataColumns = (dataGrid.Columns[GField[i]] as GridViewDataDateColumn);
            dataColumns.Settings.AllowHeaderFilter = DevExpress.Utils.DefaultBoolean.False;
            if(i % 2 == 0 && valid)
                dataColumns.EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.True;
            else
                dataColumns.EditFormSettings.Visible = DevExpress.Utils.DefaultBoolean.False;
            dataColumns.Width = Unit.Pixel(178);
            dataColumns.PropertiesDateEdit.EditFormatString = "dd/MM/yyyy HH:mm";
            dataColumns.PropertiesDateEdit.DisplayFormatString = "dd/MM/yyyy HH:mm";
            dataColumns.PropertiesDateEdit.EditFormat = EditFormat.DateTime;
            dataColumns.PropertiesDateEdit.TimeSectionProperties.Visible = true;
            dataColumns.PropertiesDateEdit.TimeSectionProperties.TimeEditProperties.EditFormatString = "HH:mm";
        }
    }
    protected void GvLevelA_Init(object sender, EventArgs e) {
        ASPxGridView dataGrid = (sender as ASPxGridView);
        SetColumns(dataGrid, true);
    }
    protected void GvLevelB_Init(object sender, EventArgs e) {
        ASPxGridView dataGrid = (sender as ASPxGridView);
        SetColumns(dataGrid, false);
    }
}