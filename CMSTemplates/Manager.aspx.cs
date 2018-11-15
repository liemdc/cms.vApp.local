using CMS.CMSHelper;
using CMS.UIControls;
using DevExpress.Web;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_Manager : TemplatePage {
    protected void Page_Load(object sender, EventArgs e) {

    }
    protected void PageControl_Load(object sender, EventArgs e) {
        PageControl.TabPages.FindByName("ProcessTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongDoan");
        PageControl.TabPages.FindByName("EmployeeTab").Visible = CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhanVien");
    }
    protected void OnCustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e) {
        if (e.Column.Caption == "Num")
            e.DisplayText = string.Format("{0:#,###}", e.VisibleRowIndex + 1);
    }
    protected void GvLevelA_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            //if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelB_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhanVien", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhanVien", "Sua"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            //if (!CMSContext.CurrentUser.IsAuthorizedPerResource("NhanVien", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelNd_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["SubProcessListID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
    protected void GvLevelAC_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan", "ThemMoi"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.NewRow));
            e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.EditRow));
            if (!CMSContext.CurrentUser.IsAuthorizedPerResource("CongDoan", "Xoa"))
                e.Items.Remove(e.Items.FindByCommand(GridViewContextMenuCommand.DeleteRow));
        }
    }
    protected void GvLevelA_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        ASPxGridView GridForm = sender as ASPxGridView;
        string[] parameters = e.Parameters.Split('|');
        string command = parameters[0];
        if (command == "DRAGROW") {
            int draggingIndex = int.Parse(parameters[1]);
            int targetIndex = int.Parse(parameters[2]);
            int draggingRowKey = (int)GridForm.GetRowValues(draggingIndex, GridForm.KeyFieldName);
            List<PM_ProjectProcessList> ProcessList = LINQData.db.PM_ProjectProcessLists.ToList();
            if (targetIndex < draggingIndex) {
                ProcessList.Where(w => w.ProcessListId == draggingRowKey).FirstOrDefault().ProcessListOrder = targetIndex;
                for (int rowIndex = targetIndex; rowIndex < draggingIndex; rowIndex++) {
                    int rowKey = (int)GridForm.GetRowValues(rowIndex, GridForm.KeyFieldName);
                    ProcessList.Where(w => w.ProcessListId == rowKey).FirstOrDefault().ProcessListOrder = rowIndex + 1;
                }
            }
            if (targetIndex > draggingIndex) {
                ProcessList.Where(w => w.ProcessListId == draggingRowKey).FirstOrDefault().ProcessListOrder = targetIndex;
                for (int rowIndex = targetIndex; rowIndex > draggingIndex; rowIndex--) {
                    int rowKey = (int)GridForm.GetRowValues(rowIndex, GridForm.KeyFieldName);
                    ProcessList.Where(w => w.ProcessListId == rowKey).FirstOrDefault().ProcessListOrder = rowIndex - 1;
                }
            }
            LINQData.db.SubmitChanges();
        }
        GvLevelA.DataBind();
    }
    protected void GvLevelA_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e) {
        if (e.RowType == GridViewRowType.Data) {
            object rowOrder = e.VisibleIndex;
            if (rowOrder != null)
                e.Row.Attributes.Add("sortOrder", rowOrder.ToString());
        }
    }
    protected void GvLevelABA_BeforePerformDataSelect(object sender, EventArgs e) {
        Session["MachineryId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
    }
}