using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.CMSHelper;
using CMS.SiteProvider;
using DevExpress.Web;

public partial class CMSTemplates_Controls_DanhMucChucNang : System.Web.UI.UserControl
{
    protected ASPxGridView GridViewForm { get { return GvRoles; } }
    protected void Page_Load(object sender, EventArgs e){
        if (GridViewForm.Columns.Count == 0){
            GridViewForm.Columns.Add(DataUtils.GvDataTextColumn(index: 0, eIndex: 0, width: 200, fieldName: "PermissionDisplayName", caption: "Chức năng", fixedStyle: GridViewColumnFixedStyle.Left));
            DataTable dtRoles = ProjectDataObject.GetAllRoles();
            for (int i = 0; i < dtRoles.Rows.Count; i++){
                GridViewDataCheckColumn dcCol = new GridViewDataCheckColumn();
                dcCol.Width = 128;
                dcCol.FieldName = dtRoles.Rows[i]["RoleName"].ToString();
                dcCol.Caption = dtRoles.Rows[i]["RoleDisplayName"].ToString();
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Url = "/App_Themes/Default/Images/Design/Controls/UniMatrix/allowed.png";
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Width = 16;
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Height = 16;
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Url = "/App_Themes/Default/Images/Design/Controls/UniMatrix/denied.png";
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Width = 16;
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Height = 16;
                dcCol.VisibleIndex = i + 1;
                GridViewForm.Columns.Add(dcCol);
            }
            GridViewForm.SettingsDetail.ShowDetailRow = true;
            GridViewForm.SettingsDetail.AllowOnlyOneMasterRowExpanded = true;
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("DanhMucChucNang", "CapNhat")){
                GridViewForm.SettingsEditing.Mode = GridViewEditingMode.Batch;
                GridViewForm.SettingsEditing.BatchEditSettings.ShowConfirmOnLosingChanges = false;
            }

            GridViewForm.DataSource = GetPermissions(ResourceInfoProvider.GetResourceInfo("Functions").ResourceId);
            GridViewForm.DataBind();
        }
    }
    protected void GvRoles_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e){
        DataTable dtRoles = ProjectDataObject.GetAllRoles();
        foreach (var args in e.UpdateValues){
            foreach (DataRow drBool in dtRoles.Rows){
                if (args.NewValues[drBool["RoleName"]] != null){
                    if (!updatePermissions(args.NewValues[drBool["RoleName"]],
                        PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32(args.Keys["PermissionID"])).PermissionName,
                        ResourceInfoProvider.GetResourceInfo("Functions").ResourceName,
                        drBool["RoleName"].ToString()))
                        throw new NotImplementedException("Có lỗi đang xảy ra...");
                }
            }
        }
        e.Handled = true;
        GridViewForm.DataSource = GetPermissions(ResourceInfoProvider.GetResourceInfo("Functions").ResourceId);
    }
    protected bool updatePermissions(object PermissionToRole, string permissionName, string ResourceName, string RoleName){
        PermissionNameInfo permission = PermissionNameInfoProvider.GetPermissionNameInfo(permissionName, ResourceName, null); // Get the permission
        RoleInfo role = RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSiteID); // Get the role
        if (Convert.ToBoolean(PermissionToRole)) { 
            if ((permission != null) && (role != null)){
                RolePermissionInfoProvider.SetRolePermissionInfo(role.RoleID, permission.PermissionId); // Add permission to role
                return true;
            }
        } else { 
            if ((permission != null) && (role != null)){
                RolePermissionInfoProvider.DeleteRolePermissionInfo(role.RoleID, permission.PermissionId);
                return true;
            }
        }
        return false;
    }
    
    #region "role child"
    protected void gvRoleChild_BeforePerformDataSelect(object sender, EventArgs e){
        (sender as ASPxGridView).ControlStyle.BackColor = System.Drawing.Color.White;
        if ((sender as ASPxGridView).Columns.Count == 0){
            (sender as ASPxGridView).Columns.Add(DataUtils.GvDataTextColumn(index: 0, eIndex: 0, width: 200, fieldName: "PermissionDisplayName", caption: "Chức năng", fixedStyle: GridViewColumnFixedStyle.Left));
            
            DataTable dtRoles = ProjectDataObject.GetAllRoles();
            for (int i = 0; i < dtRoles.Rows.Count; i++){
                GridViewDataCheckColumn dcCol = new GridViewDataCheckColumn();
                dcCol.Width = 128;
                dcCol.FieldName = dtRoles.Rows[i]["RoleName"].ToString();
                dcCol.Caption = dtRoles.Rows[i]["RoleDisplayName"].ToString();
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Url = "/App_Themes/Default/Images/Design/Controls/UniMatrix/allowed.png";
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Width = 16;
                dcCol.PropertiesCheckEdit.DisplayImageChecked.Height = 16;
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Url = "/App_Themes/Default/Images/Design/Controls/UniMatrix/denied.png";
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Width = 16;
                dcCol.PropertiesCheckEdit.DisplayImageUnchecked.Height = 16;
                dcCol.VisibleIndex = i + 1;
                (sender as ASPxGridView).Columns.Add(dcCol);
            }
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("DanhMucChucNang", "CapNhat")){
                (sender as ASPxGridView).SettingsEditing.Mode = GridViewEditingMode.Batch;
                (sender as ASPxGridView).SettingsEditing.BatchEditSettings.ShowConfirmOnLosingChanges = false;
            }
        }

        string PermissionName = PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue())).PermissionName;
        (sender as ASPxGridView).DataSource = GetPermissions(ResourceInfoProvider.GetResourceInfo(PermissionName).ResourceId);
    }
    protected void gvRoleChild_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e){
        string PermissionName = PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue())).PermissionName;
        DataTable dtRoles = ProjectDataObject.GetAllRoles();
        foreach (var args in e.UpdateValues){
            foreach (DataRow drBool in dtRoles.Rows){
                if (args.NewValues[drBool["RoleName"]] != null){
                    if (!updatePermissions(args.NewValues[drBool["RoleName"]],
                        PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32(args.Keys["PermissionID"])).PermissionName,
                        ResourceInfoProvider.GetResourceInfo(PermissionName).ResourceName,
                        drBool["RoleName"].ToString()))
                        throw new NotImplementedException("Có lỗi đang xảy ra...");
                }
            }
        }
        e.Handled = true;
    }
    #endregion
    
    #region "Roles"
    protected DataSet GetPermissions(int ResourceId){
        DataTable dataTableRoles = ProjectDataObject.GetAllRoles();
        DataSet permissions = PermissionNameInfoProvider.GetPermissionNames("ResourceID = " + ResourceId, "PermissionOrder asc", 0, "PermissionID,PermissionDisplayName");
        foreach (DataRow iRoles in dataTableRoles.Rows)
            permissions.Tables[0].Columns.Add(iRoles["RoleName"].ToString(), typeof(bool));
        if (permissions != null){
            foreach (DataRow iPermission in permissions.Tables[0].Rows){
                foreach (DataRow iRoles in dataTableRoles.Rows){
                    RolePermissionInfo cRolePermission = RolePermissionInfoProvider.GetRolePermissionInfo(Convert.ToInt32(iRoles["RoleID"]), Convert.ToInt32(iPermission["PermissionID"]));
                    if (cRolePermission != null)
                        iPermission[iRoles["RoleName"].ToString()] = true;
                    else
                        iPermission[iRoles["RoleName"].ToString()] = false;
                }
            }
        }
        return permissions;
    }
    #endregion
}