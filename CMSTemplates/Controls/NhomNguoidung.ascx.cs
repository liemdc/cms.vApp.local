using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.CMSHelper;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using DevExpress.Web;

public partial class CMSTemplates_Controls_NhomNguoidung : System.Web.UI.UserControl
{
    #region "main chính"
    protected void Page_Load(object sender, EventArgs e)
    {
        gvRole.ControlStyle.BackColor = System.Drawing.Color.White;

        GridViewCommandColumn comCol = new GridViewCommandColumn();
        comCol.Width = 88;
        comCol.VisibleIndex = 0;
        comCol.ButtonType = GridViewCommandButtonType.Image;
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "ThemMoi"))
            comCol.ShowNewButtonInHeader = true;
        else
            comCol.Caption = "Thao tác";
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Sua"))
            comCol.ShowEditButton = true;
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Xoa"))
            comCol.ShowDeleteButton = true;
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "ThemMoi") || CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Sua") || CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "Xoa"))
            gvRole.Columns.Add(comCol);

        getAllRoles();
    }
    protected void getAllRoles()
    {
        DataSet dsRoles = RoleInfoProvider.GetAllRoles("RoleID > 13");
        dsRoles.Tables[0].DefaultView.Sort = "RoleID asc";
        gvRole.DataSource = dsRoles.Tables[0].DefaultView.ToTable();
        gvRole.DataBind();
    }
    protected void gvRole_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        RoleInfoProvider.DeleteRole(gvRole.GetRowValues(gvRole.FindVisibleIndexByKeyValue(e.Keys[gvRole.KeyFieldName]), "RoleName").ToString(), CMSContext.CurrentSite.SiteName);
        e.Cancel = true;
        gvRole.CancelEdit();
        getAllRoles();
    }
    protected void gvRole_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        if (e.NewValues["RoleDisplayName"] == null)
            throw new NotImplementedException("Vui lòng nhập Tên nhóm.");
        RoleInfo role = new RoleInfo();
        role.RoleName = RandomString(10);
        role.DisplayName = e.NewValues["RoleDisplayName"].ToString();
        if (e.NewValues["RoleDescription"] != null)
            role.Description = e.NewValues["RoleDescription"].ToString();
        role.SiteID = CMSContext.CurrentSite.SiteID;
        if (!CMS.SiteProvider.RoleInfoProvider.RoleExists(role.RoleName, CMSContext.CurrentSite.SiteName))
            CMS.SiteProvider.RoleInfoProvider.SetRoleInfo(role);
        else
            throw new NotImplementedException("Tên nhóm này đã tồn tại, vui lòng chọn tên nhóm khác.");
        e.Cancel = true;
        gvRole.CancelEdit();
        getAllRoles();
    }
    private string RandomString(int size)
    {
        Random random = new Random((int)DateTime.Now.Ticks);
        StringBuilder builder = new StringBuilder();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }
        return builder.ToString();
    }
    protected void gvRole_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        RoleInfo role = RoleInfoProvider.GetRoleInfo(gvRole.GetRowValues(gvRole.FindVisibleIndexByKeyValue(e.Keys[gvRole.KeyFieldName]), "RoleName").ToString(), CMSContext.CurrentSite.SiteName);
        if (role != null)
        {
            if (e.NewValues["RoleDisplayName"] == null)
                throw new NotImplementedException("Vui lòng nhập Tên nhóm.");
            role.DisplayName = e.NewValues["RoleDisplayName"].ToString();
            if (e.NewValues["RoleDescription"] != null)
                role.Description = e.NewValues["RoleDescription"].ToString();
            CMS.SiteProvider.RoleInfoProvider.SetRoleInfo(role);
        }
        e.Cancel = true;
        gvRole.CancelEdit();
        getAllRoles();
    }
    #endregion

    #region "Tab người dùng"
    protected void gvUser_BeforePerformDataSelect(object sender, EventArgs e)
    {
        Session["RoleID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        (sender as ASPxGridView).DataSource = getAllUser(Session["RoleID"]);
    }
    protected void gvUser_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        RoleInfo role = RoleInfoProvider.GetRoleInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue()));
        string userName = (sender as ASPxGridView).GetRowValues((sender as ASPxGridView).FindVisibleIndexByKeyValue(e.Keys[(sender as ASPxGridView).KeyFieldName]), "UserName").ToString();
        UserInfoProvider.RemoveUserFromRole(userName, role.RoleName, CMSContext.CurrentSite.SiteName);
        e.Cancel = true;
        (sender as ASPxGridView).DataSource = getAllUser(Session["RoleID"]);
        (sender as ASPxGridView).DataBind();
    }
    protected void cbUser_ItemRequestedByValue(object source, DevExpress.Web.ListEditItemRequestedByValueEventArgs e)
    {
        if (Session["RoleID"] != null)
        {
            InfoDataSet<UserRoleInfo> userRoles = UserRoleInfoProvider.GetUserRoles("RoleID = " + Session["RoleID"], null, -1, null);
            if (userRoles != null)
            {
                string lUserID = null;
                foreach (UserRoleInfo userRoleInfo in userRoles) { lUserID += " and UserID != " + userRoleInfo.UserID; }
                if (lUserID != null)
                    (source as ASPxComboBox).DataSource = UserInfoProvider.GetFullUsers("(" + lUserID.Substring(5) + ") and (UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", null);
                else
                    (source as ASPxComboBox).DataSource = UserInfoProvider.GetFullUsers("(UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", "");
            }
        }
        else
            (source as ASPxComboBox).DataSource = UserInfoProvider.GetFullUsers("(UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", "");
        (source as ASPxComboBox).DataBind();
    }
    protected void gvUser_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        RoleInfo role = RoleInfoProvider.GetRoleInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue()));
        ASPxComboBox cbUser = (sender as ASPxGridView).FindEditFormTemplateControl("cbUser") as ASPxComboBox;
        UserInfoProvider.AddUserToRole(cbUser.Value.ToString(), role.RoleName, CMSContext.CurrentSite.SiteName);
        e.Cancel = true;
        (sender as ASPxGridView).CancelEdit();
    }
    protected DataSet getAllUser(object RoleID)
    {
        DataSet dsUser = null;
        InfoDataSet<UserRoleInfo> userRoles = UserRoleInfoProvider.GetUserRoles("RoleID = " + RoleID, null, -1, null);
        if (userRoles != null)
        {
            string lUserID = null;
            foreach (UserRoleInfo userRoleInfo in userRoles) { lUserID += " or UserID = " + userRoleInfo.UserID; }
            if (lUserID != null)
                dsUser = UserInfoProvider.GetFullUsers("(" + lUserID.Substring(4) + ") and (UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", null);
        }
        return dsUser;
    }
    #endregion

    #region "Permissions"
    protected void gvPermissions_BeforePerformDataSelect(object sender, EventArgs e)
    {
        (sender as ASPxGridView).ControlStyle.BackColor = System.Drawing.Color.White;
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "NhomChucNang"))
            (sender as ASPxGridView).SettingsEditing.Mode = GridViewEditingMode.Batch;
        (sender as ASPxGridView).DataSource = getPermissions(ResourceInfoProvider.GetResourceInfo("Functions").ResourceId, Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue()));
    }
    protected void gvPermissions_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e)
    {
        foreach (var args in e.UpdateValues)
        {
            if (!updatePermissions(args.NewValues["PermissionToRole"],
                 PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32(args.Keys["PermissionID"])).PermissionName,
                 ResourceInfoProvider.GetResourceInfo("Functions").ResourceName,
                 RoleInfoProvider.GetRoleInfo(Convert.ToInt32(Session["RoleID"])).RoleName))
                throw new NotImplementedException("Có lỗi đang xảy ra...");
        }
        e.Handled = true;
    }
    #endregion

    #region "Permissions Child"
    protected void gvPermissionsChild_BeforePerformDataSelect(object sender, EventArgs e)
    {
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("NhomNguoiDung", "ChucNang"))
            (sender as ASPxGridView).SettingsEditing.Mode = GridViewEditingMode.Batch;
        string PermissionName = PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue())).PermissionName;
        (sender as ASPxGridView).DataSource = getPermissions(ResourceInfoProvider.GetResourceInfo(PermissionName).ResourceId, Convert.ToInt32(Session["RoleID"]));
    }
    protected void gvPermissionsChild_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e)
    {
        string PermissionName = PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32((sender as ASPxGridView).GetMasterRowKeyValue())).PermissionName;
        foreach (var args in e.UpdateValues)
        {
            if (!updatePermissions(args.NewValues["PermissionToRole"],
                 PermissionNameInfoProvider.GetPermissionNameInfo(Convert.ToInt32(args.Keys["PermissionID"])).PermissionName,
                 ResourceInfoProvider.GetResourceInfo(PermissionName).ResourceName,
                 RoleInfoProvider.GetRoleInfo(Convert.ToInt32(Session["RoleID"])).RoleName))
                throw new NotImplementedException("Có lỗi đang xảy ra...");
        }
        e.Handled = true;
    }
    #endregion

    #region "update Permissions"
    protected bool updatePermissions(object PermissionToRole, string permissionName, string ResourceName, string RoleName)
    {
        PermissionNameInfo permission = PermissionNameInfoProvider.GetPermissionNameInfo(permissionName, ResourceName, null); // Get the permission
        RoleInfo role = RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSiteID); // Get the role
        if (Convert.ToBoolean(PermissionToRole))
        {
            if ((permission != null) && (role != null))
            {
                RolePermissionInfoProvider.SetRolePermissionInfo(role.RoleID, permission.PermissionId); // Add permission to role
                return true;
            }
        }
        else
            if ((permission != null) && (role != null))
            {
                RolePermissionInfoProvider.DeleteRolePermissionInfo(role.RoleID, permission.PermissionId);
                return true;
            }
        return false;
    }
    #endregion

    #region "get Permissions"
    protected DataSet getPermissions(int ResourceId, int roleId)
    {
        DataSet permissions = null;
        permissions = PermissionNameInfoProvider.GetPermissionNames("ResourceID = " + ResourceId, "PermissionOrder asc", 0, "PermissionID,PermissionDisplayName,PermissionName");
        permissions.Tables[0].Columns.Add("PermissionToRole", typeof(bool));
        if (permissions != null)
        {
            foreach (DataRow iPermissions in permissions.Tables[0].Rows)
            {
                 RolePermissionInfo cRolePermission = RolePermissionInfoProvider.GetRolePermissionInfo(roleId, Convert.ToInt32(iPermissions["PermissionID"]));
                if (cRolePermission != null)
                    iPermissions["PermissionToRole"] = true;
                else
                    iPermissions["PermissionToRole"] = false;
            }
        }
        return permissions;
    }
    #endregion
}