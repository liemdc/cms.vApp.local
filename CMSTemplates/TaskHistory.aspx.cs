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

public partial class CMSTemplates_TaskHistory : TemplatePage {
    protected void Page_Load(object sender, EventArgs e){
        if (!IsPostBack) {
            CbExportMode.Items.AddRange(Enum.GetNames(typeof(GridViewDetailExportMode)));
            CbExportMode.Text = GridViewDetailExportMode.Expanded.ToString();
            DeStart.Date = DateTime.Now.AddMonths(-1);
            DeEnd.Date = DateTime.Now;
        }
    }
    protected void UpdateExportMode() {
        GvLevelC.SettingsDetail.ExportMode = (GridViewDetailExportMode)Enum.Parse(typeof(GridViewDetailExportMode), CbExportMode.Text);
    }
    protected void btnXlsExport_Click(object sender, EventArgs e) {
        UpdateExportMode();
        GvExport.WriteXlsToResponse(string.Format("ReportTime {0} - {1}", DeStart.Date.ToShortDateString(), DeEnd.Date.ToShortDateString()), new XlsExportOptionsEx() { ExportType = ExportType.WYSIWYG });
    }
    protected void btnXlsxExport_Click(object sender, EventArgs e) {
        UpdateExportMode();
        GvExport.WriteXlsxToResponse(string.Format("ReportTime {0} - {1}", DeStart.Date.ToShortDateString(), DeEnd.Date.ToShortDateString()), new XlsxExportOptionsEx() { ExportType = ExportType.WYSIWYG });
    }
    protected void OnCustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e) {
        if (e.Column.Caption == "Num")
            e.DisplayText = string.Format("{0:#,###}", e.VisibleRowIndex + 1);
    }
    protected void GvLevelC_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelCA_BeforePerformDataSelect(object sender, EventArgs e) {
        ASPxGridView GridForm = sender as ASPxGridView;
        Session["EmployeeId"] = GridForm.GetMasterRowKeyValue();
        Session["PRDateBegin"] = DateTool.Min(Convert.ToDateTime(GridForm.GetMasterRowFieldValues("DateBegin")), Convert.ToDateTime(GridForm.GetMasterRowFieldValues("OrDateBegin")));
        Session["PRDateEnd"] = DateTool.Max(Convert.ToDateTime(GridForm.GetMasterRowFieldValues("DateEnd")), Convert.ToDateTime(GridForm.GetMasterRowFieldValues("OrDateEnd")));
    }
    
    protected void On_DateChanged(object sender, EventArgs e) {
        GvLevelC.DataBind();
    }
    protected void GvLevelA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelB_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("TaskHistory", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
}