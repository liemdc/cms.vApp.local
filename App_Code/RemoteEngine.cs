using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using CMS.LicenseProvider;
using CMS.SiteProvider;
using System.IO;
using CMS.CMSHelper;

/// <summary>
/// Summary description for RemoteEngine
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class RemoteEngine : System.Web.Services.WebService {

    public RemoteEngine () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    const string REMOTE_KEY = "fd77658c-bd6c-42aa-ac06-f11a68f5f565";

    [WebMethod]
    public void AddLicense(string siteName, string key)
    {
        if (key == REMOTE_KEY)
        {
            if (!string.IsNullOrEmpty(siteName))
            {
                // -- load license
                var l = string.Empty;
                using (var sr = new StreamReader(Server.MapPath("~/App_data/CMSCore/l.dat")))
                {
                    l = sr.ReadToEnd();
                }

                l = string.Format(l, siteName);

                // -- add new
                var lk = new LicenseKeyInfo();
                lk.LoadLicense(l.Trim(), "");
                var xxx = lk.ValidationResult.ToString();

                if (!LicenseKeyInfoProvider.IsLicenseExistForDomain(lk))
                {
                    LicenseKeyInfoProvider.SetLicenseKeyInfo(lk);
                    CMS.SiteProvider.UserInfoProvider.ClearLicenseValues();
                    Functions.ClearHashtables();
                }
            }
        }
    }

    #region Private Method

    private bool IsUserExists(string username)
    {
        if (!string.IsNullOrEmpty(username))
        {
            var u = UserInfoProvider.GetUserInfo(username);
            if (u != null)
                return true;
            else
                return false;
        }
        return true;
    }

    #endregion

    [WebMethod]
    public void CreateUser(string username, string password, string key)
    {
        if (key == REMOTE_KEY)
        {
            if (!IsUserExists(username))
            {
                UserInfo user = new UserInfo();
                user.UserName = username;
                user.FirstName = username;
                user.LastName = string.Empty;
                user.UserIsEditor = true;
                user.Email = username;
                user.Enabled = true;

                UserInfoProvider.SetUserInfo(user);
                UserInfoProvider.SetPassword(username, password);
            }
        }

    }

    [WebMethod]
    public void AddUserToSite(string username, string sitename, string key)
    {
        if (key == REMOTE_KEY)
        {
            if (!string.IsNullOrEmpty(username)
                && !string.IsNullOrEmpty(sitename))
            {
                var site = SiteInfoProvider.GetSiteInfo(sitename);
                if (site != null)
                {
                    var user = UserInfoProvider.GetUserInfo(username);
                    if (user != null)
                    {
                        UserSiteInfoProvider.AddUserToSite(user.UserID, site.SiteID);
                    }
                    // else log user not found
                }
                // else log site not found
            }
        }
    }

    [WebMethod]
    public void AddUserToRole(string username, string rolename, string key)
    {
        if (key == REMOTE_KEY)
        {
            if (!string.IsNullOrEmpty(username)
                && !string.IsNullOrEmpty(rolename))
            {
                var role = RoleInfoProvider.GetRoleInfo(rolename, CMSContext.CurrentSiteID);
                var user = UserInfoProvider.GetUserInfo(username);

                if (role != null && user != null)
                {
                    var userRole = new UserRoleInfo();
                    userRole.UserID = user.UserID;
                    userRole.RoleID = role.RoleID;

                    UserRoleInfoProvider.SetUserRoleInfo(userRole);
                }
            }
        }
    }

    [WebMethod]
    public void CreateSite(string siteName, string siteDisplayName, string siteDomain,
        string importFileName, string key)
    {
        if (key != REMOTE_KEY)
            return;

        try
        {
            string websitePath = Server.MapPath("~/");
            //string sourcePath = Server.MapPath("~/App_data/ImportTemplates/" + importFileName);
            var sourcePath = string.Empty;
            if (importFileName.Contains(":")) // full path
                sourcePath = importFileName;
            else
                sourcePath = Server.MapPath(importFileName);

            if (!System.IO.File.Exists(sourcePath))
                return;

            if (CMS.SiteProvider.SiteInfoProvider.GetSiteInfo(siteName) == null)
            {
                // -- create site
                CMS.CMSImportExport.ImportProvider.ImportSite(siteName, siteDisplayName, siteDomain,
                    sourcePath, websitePath);
            }
        }
        catch (Exception ex)
        { }
    }

    [WebMethod]
    public bool StartSite(string siteName, string key)
    {
        if (key == REMOTE_KEY)
        {
            SiteInfo site = SiteInfoProvider.GetSiteInfo(siteName);
            if (site != null)
            {
                SiteInfoProvider.RunSite(site.SiteName);
                return true;
            }
        }

        return false;
    }

    [WebMethod]
    public bool StopSite(string siteName, string key)
    {
        if (key == REMOTE_KEY)
        {
            SiteInfo site = SiteInfoProvider.GetSiteInfo(siteName);
            if (site != null)
            {
                SiteInfoProvider.StopSite(site.SiteName);
                return true;
            }
        }

        return false;
    }
    
}

