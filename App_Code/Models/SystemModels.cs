using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

public class SystemModels {
    public static List<UserInfoObject> UserList() {
        return UserInfoProvider.GetFullUsers("(UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", "", 0, "UserID,FullName,Email,UserDateOfBirth,UserCreated,LastLogon").Tables[0].AsEnumerable().Select(s => new UserInfoObject {
            UserID = s.Field<int>("UserID"), Email = s.Field<string>("Email"), FullName = s.Field<string>("FullName"), UserDateOfBirth = s.Field<DateTime?>("UserDateOfBirth"), UserCreated = s.Field<DateTime?>("UserCreated"), LastLogon = s.Field<DateTime?>("LastLogon")
        }).ToList();
    }
    public static List<UserInfoObject> UserListByRole(string RoleName) {
        int RoleId = RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName).RoleID;
        return UserInfoProvider.GetFullUsers("(UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", "", 0, "UserID,FullName,Email,UserDateOfBirth,UserCreated,LastLogon").Tables[0].AsEnumerable()
            .Join(UserRoleInfoProvider.GetUserRoles("RoleID = " + RoleId, null, 0, null).Tables[0].AsEnumerable(), fu => fu.Field<int>("UserID"), ur => ur.Field<int>("UserID"), (fu , ur) => new {fu, ur})
            .Select(s => new UserInfoObject {
                UserID = s.fu.Field<int>("UserID"), Email = s.fu.Field<string>("Email"), FullName = s.fu.Field<string>("FullName"), UserDateOfBirth = s.fu.Field<DateTime?>("UserDateOfBirth"), UserCreated = s.fu.Field<DateTime?>("UserCreated"), LastLogon = s.fu.Field<DateTime?>("LastLogon")
            }).ToList();
    }
    public static List<UserInfoObject> UserListNotInRole(string RoleName) {
        int RoleId = RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName).RoleID;
        return UserInfoProvider.GetFullUsers("(UserIsHidden = 0 or UserIsHidden is NULL) and UserEnabled = 1", "", 0, "UserID,FullName,Email,UserDateOfBirth").Tables[0].AsEnumerable()
            .Where(w => !UserRoleInfoProvider.GetUserRoles("RoleID = " + RoleId, null, 0, null).Tables[0].AsEnumerable().Select(s => s.Field<int>("UserID")).Contains(w.Field<int>("UserID")))
            .Select(s => new UserInfoObject {
                UserID = s.Field<int>("UserID"), Email = s.Field<string>("Email"), FullName = s.Field<string>("FullName"), UserDateOfBirth = s.Field<DateTime?>("UserDateOfBirth")
            }).ToList();
    }
    public static void UserCreated(string Email, string FullName, DateTime UserDateOfBirth) {
        UserInfo user = new UserInfo() {
            UserName = Email, FullName = FullName, Email = Email, Enabled = true, IsEditor = false, IsGlobalAdministrator = false, UserIsExternal = false, UserIsHidden = false, UserIsDomain = false
        };
        user.SetValue("UserDateOfBirth", UserDateOfBirth); 
        user.PreferredCultureCode = CMSContext.PreferredCultureCode;
        user.UserCreated = DateTime.Now;
        CMS.SiteProvider.UserInfoProvider.SetUserInfo(user);
        UserInfoProvider.AddUserToSite(user.UserName, CMSContext.CurrentSite.SiteName);
        UserInfoProvider.SetPassword(user.UserName, "12345678");
    }
    public static void UserRoleCreated(int UserID, string RoleName) {
        UserInfoProvider.AddUserToRole(UserInfoProvider.GetUserInfo(UserID).UserName, RoleName, CMSContext.CurrentSite.SiteName);
    }
    public static void UserUpdated(int UserID, string Email, string FullName, DateTime UserDateOfBirth) {
        UserInfo user = UserInfoProvider.GetUserInfo(UserID);
        user.Email = Email;
        user.FullName = FullName;
        user.SetValue("UserDateOfBirth", UserDateOfBirth);        
        CMS.SiteProvider.UserInfoProvider.SetUserInfo(user);
    }
    public static void UserDeleted(int UserID){
        UserInfoProvider.DeleteUser(UserID);
    }
    public static void UserRoleDeleted(int UserID, string RoleName) {
        UserInfoProvider.RemoveUserFromRole(UserInfoProvider.GetUserInfo(UserID).UserName, RoleName, CMSContext.CurrentSite.SiteName);
    }
    public static List<RoleInfoObject> RoleList(){
        return RoleInfoProvider.GetAllRoles("RoleID > 13").Tables[0].AsEnumerable().Select(s => new RoleInfoObject {
            RoleID = s.Field<int>("RoleID"), RoleName = s.Field<string>("RoleName"), RoleDisplayName = s.Field<string>("RoleDisplayName"), RoleDescription = s.Field<string>("RoleDescription")
        }).ToList();
    }
    public static void RoleCreated(string RoleDisplayName, string RoleDescription) {
        RoleInfo role = new RoleInfo();
        role.RoleName = ConvertToUnSign(RoleDisplayName);
        role.DisplayName = RoleDisplayName;
        role.Description = RoleDescription;
        role.SiteID = CMSContext.CurrentSite.SiteID;
        if (!CMS.SiteProvider.RoleInfoProvider.RoleExists(role.RoleName, CMSContext.CurrentSite.SiteName))
            CMS.SiteProvider.RoleInfoProvider.SetRoleInfo(role);
    }
    public static void RoleUpdated(string RoleName, string RoleDisplayName, string RoleDescription) {
        RoleInfo role = RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName);
        if (role != null) {
            role.RoleName = ConvertToUnSign(RoleDisplayName);
            role.DisplayName = RoleDisplayName;
            role.Description = RoleDescription;
            if (!CMS.SiteProvider.RoleInfoProvider.RoleExists(role.RoleName, CMSContext.CurrentSite.SiteName))
                CMS.SiteProvider.RoleInfoProvider.SetRoleInfo(role);
        }
    }
    public static void RoleDeleted(string RoleName){
        RoleInfoProvider.DeleteRole(RoleName, CMSContext.CurrentSite.SiteName);
    }
    public List<PermissionsObject> PermissionsList(string RoleName, string RoleGroup) {
        return PermissionNameInfoProvider.GetPermissionNames("ResourceID = " + ResourceInfoProvider.GetResourceInfo(RoleGroup).ResourceId, "", 0, "PermissionID,PermissionDisplayName,PermissionName").Tables[0].AsEnumerable().Where(w => !w.Field<string>("PermissionName").Contains("CongDoan"))
            .GroupJoin(RolePermissionInfoProvider.GetRolePermissions("RoleID = " + RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName).RoleID, "", 0, "RoleID,PermissionID").Tables[0].AsEnumerable(), pn => pn.Field<int>("PermissionID"), rp => rp.Field<int>("PermissionID"), (pn, rp) => new { pn, rp })
            .SelectMany(sm => sm.rp.DefaultIfEmpty<DataRow>(), (sm, rp) => new PermissionsObject { PermissionID = sm.pn.Field<int>("PermissionID"), PermissionDisplayName = sm.pn.Field<string>("PermissionDisplayName"), PermissionAllow = rp == null ? false : true }).ToList();
    }
    public List<PermissionsObject> PermissionsListNd(string RoleName, string RoleGroup) {
        return PermissionNameInfoProvider.GetPermissionNames("ResourceID = " + ResourceInfoProvider.GetResourceInfo(RoleGroup).ResourceId, "", 0, "PermissionID,PermissionDisplayName,PermissionName").Tables[0].AsEnumerable().Where(w => w.Field<string>("PermissionName").Contains("CongDoan"))
            .GroupJoin(RolePermissionInfoProvider.GetRolePermissions("RoleID = " + RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName).RoleID, "", 0, "RoleID,PermissionID").Tables[0].AsEnumerable(), pn => pn.Field<int>("PermissionID"), rp => rp.Field<int>("PermissionID"), (pn, rp) => new { pn, rp })
            .SelectMany(sm => sm.rp.DefaultIfEmpty<DataRow>(), (sm, rp) => new PermissionsObject { PermissionID = sm.pn.Field<int>("PermissionID"), PermissionDisplayName = sm.pn.Field<string>("PermissionDisplayName"), PermissionAllow = rp == null ? false : true }).ToList();
    }
    public List<PermissionsObject> PermissionsListRd(string RoleName, int RoleGroupId) {
        string PermissionName = PermissionNameInfoProvider.GetPermissionNameInfo(RoleGroupId).PermissionName;
        return PermissionNameInfoProvider.GetPermissionNames("ResourceID = " + ResourceInfoProvider.GetResourceInfo(PermissionName).ResourceId, "", 0, "PermissionID,PermissionDisplayName").Tables[0].AsEnumerable()
            .GroupJoin(RolePermissionInfoProvider.GetRolePermissions("RoleID = " + RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSite.SiteName).RoleID, "", 0, "RoleID,PermissionID").Tables[0].AsEnumerable(), pn => pn.Field<int>("PermissionID"), rp => rp.Field<int>("PermissionID"), (pn, rp) => new { pn, rp })
            .SelectMany(sm => sm.rp.DefaultIfEmpty<DataRow>(), (sm, rp) => new PermissionsObject { PermissionID = sm.pn.Field<int>("PermissionID"), PermissionDisplayName = sm.pn.Field<string>("PermissionDisplayName"), PermissionAllow = rp == null ? false : true }).ToList();
    }
    public static void PermissionsUpdated(int PermissionID, string RoleName, bool PermissionAllow) {
        if (PermissionAllow)
            RolePermissionInfoProvider.SetRolePermissionInfo(RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSiteID).RoleID, PermissionID);
        else
            RolePermissionInfoProvider.DeleteRolePermissionInfo(RoleInfoProvider.GetRoleInfo(RoleName, CMSContext.CurrentSiteID).RoleID, PermissionID);
    }
    public static string ConvertToUnSign(string text) {
        for (int i = 33; i < 48; i++)
            text = text.Replace(((char)i).ToString(), "");
        for (int i = 58; i < 65; i++)
            text = text.Replace(((char)i).ToString(), "");
        for (int i = 91; i < 97; i++)
            text = text.Replace(((char)i).ToString(), "");
        for (int i = 123; i < 127; i++)
            text = text.Replace(((char)i).ToString(), "");
        text = text.Replace(" ", "-");
        var regex = new Regex(@"\p{IsCombiningDiacriticalMarks}+");
        string strFormD = text.Normalize(NormalizationForm.FormD);
        return regex.Replace(strFormD, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
    }
    /// <summary>
    /// Lấy mã định danh mới
    /// </summary>
    /// <param name="dataYear">Mã theo năm</param>
    /// <param name="dataTable">Tiếp đầu ngữ của bảng</param>
    /// <param name="dataLen">Chiều dài số tự tăng</param>
    /// <param name="dataTXT">Mô tả về mã định danh</param>
    /// <returns>Mã định danh</returns>
    public static string Fn_Get_MaDinhDanh(string dataYear, string dataTable, int dataLen, string dataTXT) {
        string maDinhDanh = "19000001";
        string Code_MaLuuTru = "DX.MaLuuTru";
        string dataYY = string.IsNullOrEmpty(dataYear) ? DateTime.Now.Year.ToString().Substring(2, 2) : dataYear.Substring(2, 2);
        CustomTableItemProvider customTableProvider = new CustomTableItemProvider(CMSContext.CurrentUser);
        DataClassInfo DX_MaLuuTru = DataClassInfoProvider.GetDataClass(Code_MaLuuTru);

        if (DX_MaLuuTru != null) {
            string where = string.Format("MaTXT = '{0}{1}'", dataTable, dataYY);
            DataSet dataSet = customTableProvider.GetItems(Code_MaLuuTru, where, null, 1, "ItemID");
            if (!DataHelper.DataSourceIsEmpty(dataSet)) {
                // Get the custom table item ID
                int itemID = ValidationHelper.GetInteger(dataSet.Tables[0].Rows[0][0], 0);
                // Get the custom table item
                CustomTableItem DX_MaLuuTru_Item = customTableProvider.GetItem(itemID, Code_MaLuuTru);
                if (DX_MaLuuTru_Item != null) {
                    string maTXT = ValidationHelper.GetString(DX_MaLuuTru_Item.GetValue("MaTXT"), "");
                    int maNUM = ValidationHelper.GetInteger(DX_MaLuuTru_Item.GetValue("MaNUM"), 0) + 1;
                    int maLEN = dataLen > 0 ? dataLen : ValidationHelper.GetInteger(DX_MaLuuTru_Item.GetValue("MaLEN"), 0);
                    // Update Item
                    DX_MaLuuTru_Item.SetValue("MaNUM", maNUM);
                    DX_MaLuuTru_Item.Update();
                    // Build maDinhDanh
                    StringBuilder sb = new StringBuilder();
                    string newText = sb.Append('0', maLEN - maNUM.ToString().Length).ToString() + maNUM;
                    maDinhDanh = maTXT + newText;
                }
            } else {
                CustomTableItem newItem = new CustomTableItem(Code_MaLuuTru, customTableProvider);
                // Insert Item
                newItem.SetValue("MaTXT", dataTable + dataYY);
                newItem.SetValue("maNUM", 1);
                newItem.SetValue("maLEN", dataLen);
                newItem.SetValue("ActiveNUM", true);
                newItem.SetValue("MoTaTXT", dataTXT);
                newItem.ItemOrder = 0;                
                newItem.Insert();
                // Build maDinhDanh
                StringBuilder sb = new StringBuilder();
                string newText = dataTable + dataYY + sb.Append('0', dataLen - 0.ToString().Length).ToString() + 1;
                maDinhDanh = newText;
            }
        }        
        return maDinhDanh; // Return
    }
}