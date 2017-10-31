using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using CMS.Ecommerce;
using CMS.CMSHelper;
using System.IO;
using System.Web.Caching;
using System.Text;
using System.Web.Security;
using CMS.SiteProvider;
using CMS.TreeEngine;
using CMS.WorkflowEngine;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Net;
using CMS.GlobalHelper;

/// <summary>
/// Summary description for CMSUtils
/// </summary>
public class CMSUtils
{
	public CMSUtils()
	{
		//
		// TODO: Add constructor logic here
		//
    }
   
    public static DataTable GetDocumentAttachment(string top, string nodeAliasPath)
    {
        string path = string.Empty;
        if (string.IsNullOrEmpty(nodeAliasPath))
            path = GetRequestNodeAlias;
        else
            path = nodeAliasPath;

        string docId = string.Empty;
        object d = CMSUtils.GetDocuments("CMS_Tree", "DocumentID", "NodeAliasPath=N'" + path + "'", "");

        if (d != null)
            docId = d.ToString();

        if (!string.IsNullOrEmpty(docId))
        {
            if (!string.IsNullOrEmpty(top))
                top = " TOP(" + top + ") ";
            return VTSqlHelper.ExecuteDataTable("SELECT  " + top + " AttachmentGUID, AttachmentExtension FROM CMS_Attachment WHERE AttachmentDocumentID='" + docId
                    + "' AND AttachmentGroupGUID IS NOT NULL ORDER BY AttachmentOrder");
        }
        return null;
    }
    
    public static string Highlight(string StrContent, string StrKeyword)
    {
        string returnValue = StrContent;
        if (returnValue != "" && StrKeyword != "")
        {
            MatchCollection mc = new Regex(StrKeyword, RegexOptions.IgnoreCase).Matches(StrContent);
            for (int i = 0; i < mc.Count && mc[i].Success; i++)
            {
                ///Return value, break
                returnValue = returnValue.Replace(mc[i].Value, "<@@@@@@@>" + mc[i].Value + "</@@@@@@@>");
            }
            returnValue = returnValue.Replace("<@@@@@@@>", "<font class=\"highlight\">");
            returnValue = returnValue.Replace("</@@@@@@@>", "</font>");
        }

        return returnValue;
    }
    public static string GetResString(string resCode)
    {
        if (!string.IsNullOrEmpty(resCode))
            return CMS.GlobalHelper.ResHelper.GetString(resCode);

        return string.Empty;
    }

    public static string GetCultureCode()
    {
        return CMS.CMSHelper.CMSContext.PreferredCultureCode;
    }

    /// <summary>
    /// Get node alias from url
    /// </summary>
    public static string GetRequestNodeAlias
    {
        get
        {
            string alias = HttpContext.Current.Request.QueryString["aliasPath"];
            if (string.IsNullOrEmpty(alias))
                return string.Empty;
            else
                return alias.Replace("'","");
        }
    }

    /// <summary>
    /// Get node alias level
    /// </summary>
    public static int GetNodeAliasLevel
    {
        get
        {
            string n = GetRequestNodeAlias;
            if (!string.IsNullOrEmpty(n))
            {
                string[] ns = n.Split('/');
                if (ns != null)
                {
                    if (ns.Length > 0)
                        return ns.Length - 1;
                }
            }
            return 0;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="level"></param>
    /// <returns></returns>
    public static string GetRequestNodeAliasByLevel(int level)
    {
        string alias = GetRequestNodeAlias;
        if (!string.IsNullOrEmpty(alias))
        {
            string[] ns = alias.Split('/');
            if (level < 0 && level > ns.Length)
                return string.Empty;
            else
            {
                string reval = string.Empty;
                int i = 0;
                foreach (string n in ns)
                {
                    if (i <= level)
                    {
                        reval += n + "/";
                        i++;
                    }
                }

                return reval;
            }
        }

        return string.Empty;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="top"></param>
    /// <param name="tableName"></param>
    /// <param name="columns"></param>
    /// <param name="where"></param>
    /// <param name="orderBy"></param>
    /// <returns></returns>
    public static DataTable GetDocuments(string top,string tableName, string columns, string where, string orderBy)
    {
        string sampleQuery = "SELECT ##TOPN## ##COLUMNS## FROM View_##TABLE##_Joined ##WHERE## ##ORDERBY## ";

        if (!string.IsNullOrEmpty(top.ToString()))
            sampleQuery = sampleQuery.Replace("##TOPN##","TOP("+ top +")");
        else
            sampleQuery = sampleQuery.Replace("##TOPN##","");

        if (!string.IsNullOrEmpty(columns))
            sampleQuery = sampleQuery.Replace("##COLUMNS##", columns);
        else
            sampleQuery = sampleQuery.Replace("##COLUMNS##", "");

        sampleQuery = sampleQuery.Replace("##TABLE##", tableName);

        if (!string.IsNullOrEmpty(where))
            sampleQuery = sampleQuery.Replace("##WHERE##", " WHERE " + where + " AND DocumentCulture='"+ GetCultureCode() +"'");
        else
            sampleQuery = sampleQuery.Replace("##WHERE##", "WHERE DocumentCulture='"+ GetCultureCode() +"' ");

        if (!string.IsNullOrEmpty(orderBy))
            sampleQuery = sampleQuery.Replace("##ORDERBY##", "ORDER BY " + orderBy);
        else
            sampleQuery = sampleQuery.Replace("##ORDERBY##", "");

        return VTSqlHelper.ExecuteDataTable(sampleQuery);

    }

    public static object GetDocuments(string tableName, string columns, string where, string orderBy)
    {
        string sampleQuery = "SELECT TOP(1) ##COLUMNS## FROM View_##TABLE##_Joined ##WHERE## ##ORDERBY## ";

        if (!string.IsNullOrEmpty(columns))
            sampleQuery = sampleQuery.Replace("##COLUMNS##", columns);
        else
            sampleQuery = sampleQuery.Replace("##COLUMNS##", "");

        sampleQuery = sampleQuery.Replace("##TABLE##", tableName);

        if (!string.IsNullOrEmpty(where))
            sampleQuery = sampleQuery.Replace("##WHERE##", " WHERE " + where + " AND DocumentCulture='" + GetCultureCode() + "'");
        else
            sampleQuery = sampleQuery.Replace("##WHERE##", "WHERE DocumentCulture='" + GetCultureCode() + "' ");

        if (!string.IsNullOrEmpty(orderBy))
            sampleQuery = sampleQuery.Replace("##ORDERBY##", "ORDER BY " + orderBy);
        else
            sampleQuery = sampleQuery.Replace("##ORDERBY##", "");

        return VTSqlHelper.ExecuteScalar(sampleQuery);

    }

    /// <summary>
    /// Get attach image
    /// </summary>
    /// <param name="imgageGuid"></param>
    /// <param name="nodeAlias"></param>
    /// <param name="width"></param>
    /// <param name="height"></param>
    /// <returns></returns>
    public static string GetAttachImage(string imageGuid, string nodeAlias, string width, string height, bool showDefaultImage)
    {
        if (!string.IsNullOrEmpty(imageGuid))
        {
            return "/getattachment/" + imageGuid + "/" + nodeAlias + ".aspx?width=" + ((string.IsNullOrEmpty(width)) ? "" : width)
                + "&height=" + ((string.IsNullOrEmpty(height)) ? "" : height);
        }
        else
        {
            if (!showDefaultImage)
                return string.Empty;
            else
                return "/App_Themes/no-img.gif";
        }
    }

    public static string GetAttachImage(string imageGuid, string nodeAlias, string width, string height)
    {
        return GetAttachImage(imageGuid, nodeAlias, width, height, false);
    }

    public static string GetAttachImage(object imageGuid, object nodeAlias, string width, string height)
    {
        return GetAttachImage(imageGuid.ToString(), nodeAlias.ToString(), width, height);
    }

    /// <summary>
    /// Return <img></img>
    /// </summary>
    /// <param name="imageGuid"></param>
    /// <param name="nodeAlias"></param>
    /// <param name="width"></param>
    /// <param name="height"></param>
    /// <param name="imageClassName"></param>
    /// <returns></returns>
    public static string GetRenderedImage(object imageGuid, object nodeAlias, string width, string height, string imageClassName)
    {
        string attachImage = GetAttachImage(imageGuid, nodeAlias, width, height);
        if (!string.IsNullOrEmpty(attachImage))
        {
            string imgWidth = string.Empty;
            if (!string.IsNullOrEmpty(width))
                imgWidth = "style=\"width:'"+ width +"'\"";

            return "<img src=\""+ attachImage +"\" class=\""+ imageClassName +"\" "+ imgWidth +" border=\"0\" />";
        }

        return string.Empty;
    }

    /// <summary>
    /// Get CMS Node
    /// </summary>
    /// <param name="parentNodeId"></param>
    /// <returns></returns>
    public static DataRow GetTreeNode(string nodeId)
    {
        if (string.IsNullOrEmpty(nodeId))
            return null;
        else
        {
            DataTable tb = VTSqlHelper.ExecuteDataTable("SELECT * FROM CMS_Tree WHERE NodeId='" + nodeId + "'");
            if (tb.Rows.Count > 0)
                return tb.Rows[0];
            else
                return null;

        }
    }

    public static string GetCurrentPageName()
    {
        string nodeAlias = GetRequestNodeAlias;
        if (!string.IsNullOrEmpty(nodeAlias))
        {
            return GetDocuments("CMS_Tree", "DocumentName", "NodeAliasPath=N'" + nodeAlias + "'", "").ToString();
        }
        else
            return string.Empty;
    }

    public static string GetLastLoginTime()
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            string user = HttpContext.Current.User.Identity.Name;
            object oDate = VTSqlHelper.ExecuteScalar("SELECT LastLogon FROM CMS_User WHERE Email='"+ user +"'");
            if (oDate != null && !string.IsNullOrEmpty(oDate.ToString()))
                return DateTime.Parse(oDate.ToString()).ToString("dd-MM-yyyy hh:mm");
        }
        return
            string.Empty;
    }

    public static string GetUserFullName()
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            string user = HttpContext.Current.User.Identity.Name;
            object o = VTSqlHelper.ExecuteScalar("SELECT FullName FROM CMS_User WHERE Email='" + user + "'");
            if (o != null && !string.IsNullOrEmpty(o.ToString()))
                return o.ToString();
        }
        return string.Empty;
    }

    public static string GetLocalAttachmentExtensions(string siteName, string attachGuId)
    {
        if (!string.IsNullOrEmpty(siteName) && !string.IsNullOrEmpty(attachGuId))
        {
            string path = HttpContext.Current.Server.MapPath("~/" + siteName + "/files/" + attachGuId.Substring(0,2) + "/");
            if (Directory.Exists(path))
            {
                string[] files = Directory.GetFiles(path, attachGuId +  ".*");
                if (files.Length > 0)
                {
                    return Path.GetExtension(files[0].ToString());
                }
            }
        }

        return string.Empty;
    }

    public enum DateTimeMode
    {
        StartBySeconds,
        StartByDays
    }

    public static string RemoveExtraSpace(string text)
    {
        text = text.Trim();
        text = Regex.Replace(text, "\x20+", " ");
        return text;
    }
    public static string GetSafeString(string value)
    {
        if (!string.IsNullOrEmpty(value))
            return value.Replace("'", "")
                .Replace(";", "")
                .Replace("/", "")
                .Replace("\"", "")
                .Replace("%", "")
                .Replace("#", "")
                .Replace("?", "")
                .Replace("%", "")
                .Replace("$", "");
        else
            return "";
    }
    public static string GetPlainText(string s)
    {
        s = s.Replace("&nbsp;", " ");
        s = s.Replace("&lt;", "<");
        s = s.Replace("&gt;", ">");
        s = s.Replace("&amp;", "&");
        s = s.Replace("&quot;", "\"");
        s = Regex.Replace(s, @"\x20{2,}", " ");
        s = Regex.Replace(s, "<[^>]*>", "");
        return s.Trim();
    }
    public static MatchCollection GetImageSrc(string htmlInput)
    {
        RegexOptions rxOpt = RegexOptions.Multiline | RegexOptions.IgnoreCase;
        Regex r_imgsrc = new Regex("<img[^>].* S*src=[\"¦\'](.*?)[\"¦\'].*[\\/>¦\\>]", rxOpt);
        MatchCollection m_imsrc = r_imgsrc.Matches(htmlInput);
        return m_imsrc;
    }
    public static bool IsNumber(object input)
    {
        if (input == null)
            return false;
        else if (string.IsNullOrEmpty(input.ToString()))
            return false;
        else
        {
            Match M = Regex.Match(input.ToString(), @"^\d+$");
            return M.Success;
        }
    }
    public static string GetDateTimesAgo(DateTime? d, DateTimeMode mode)
    {
        DateTime date;
        if (d.HasValue)
            date = d.Value;
        else
            return string.Empty;

        TimeSpan ts = DateTime.Now - date;

        if (mode == DateTimeMode.StartBySeconds)
        {
            // -- case second
            if (ts.TotalSeconds <= 60)
                return ts.Seconds.ToString() + "  giây";
            else if (ts.TotalMinutes >= 1 && ts.TotalMinutes < 60)
                return ts.Minutes.ToString() + " phút";
            else if (ts.TotalHours >= 1 && ts.TotalHours < 24)
                return ts.Hours.ToString() + " giờ";
            else if (ts.TotalDays >= 1 && ts.TotalDays < 7)
                return ts.Days.ToString() + " ngày";
            else if (ts.TotalDays >= 7 && ts.TotalDays <= 28)
                return Math.Round(decimal.Parse((ts.TotalDays / 7).ToString())).ToString() + " tuần";
            else if (ts.TotalDays <= 365)
                return Math.Round(decimal.Parse((ts.TotalDays / 12).ToString())).ToString() + " tháng";
            else if (ts.TotalDays > 365)
                return Math.Round(decimal.Parse((ts.TotalDays / 365).ToString())).ToString() + " năm";
            else
                return date.ToString("dd/MM/yyyy hh:mm");
        }
        else if (mode == DateTimeMode.StartByDays)
        {
            if (date.ToShortDateString() == DateTime.Now.ToShortDateString())
                return "Hôm nay";
            else if (ts.TotalDays <= 30)
                return ts.Days == 0 ? "1 ngày" : ts.Days.ToString() + " ngày";
            else if (ts.TotalDays <= 365)
                return Math.Round(decimal.Parse((ts.TotalDays / 12).ToString())).ToString() + " tháng";
            else if (ts.TotalDays > 365)
                return Math.Round(decimal.Parse((ts.TotalDays / 365).ToString())).ToString() + " năm";
            else
                return date.ToString("dd/MM/yyyy hh:mm");
        }
        else
            return string.Empty;
    }

    public static DateTime ParseDateTime(string sDT)
    {
        while (sDT.IndexOf("  ") != -1)
        {
            sDT = sDT.Replace("  ", " ");
        }
        sDT = sDT.Trim();
        try
        {
            string[] dt = sDT.Split(' ');
            string datepart = dt[0];
            string timepart = ""; if (dt.Length > 1) timepart = dt[1];
            dt = datepart.Split('/');
            int day, month, year, hour = 0, min = 0, sec = 0;
            day = int.Parse(dt[0]);
            month = int.Parse(dt[1]);
            if (dt.Length > 2) year = int.Parse(dt[2]); else year = DateTime.Today.Year;
            if (year < 30) year += 2000;
            if (year > 29 && year < 100) year += 1900;

            if (timepart != "")
            {
                dt = timepart.Split(':');
                hour = int.Parse(dt[0]);
                min = int.Parse(dt[1]);
                if (dt.Length > 2) sec = int.Parse(dt[2]);
            }

            DateTime datetime = new DateTime(year, month, day, hour, min, sec);
            if (datetime < (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue.Value)
                return (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue.Value;
            else if (datetime > (DateTime)System.Data.SqlTypes.SqlDateTime.MaxValue.Value)
                return (DateTime)System.Data.SqlTypes.SqlDateTime.MaxValue.Value;

            return datetime;
        }
        catch
        {
            return DateTime.MinValue;
        }
    }
    
    public static string UpdateQueryString(string QueryStringKey, string QueryStringValue, string Url)
    {
        string NewUrl = Url;
        if (string.IsNullOrEmpty(Url))
        {
            //NewUrl = HttpContext.Current.Request.Url.PathAndQuery;
            NewUrl = HttpContext.Current.Request.RawUrl;
        }
        string PageUrl = NewUrl;
        if (NewUrl.IndexOf("?", 0) >= 0)
            PageUrl = NewUrl.Substring(0, NewUrl.IndexOf("?", 0));

        string NewKey = QueryStringKey + "=" + QueryStringValue;
        string NewQueryString = "";

        string OldQueryString = "";
        if (NewUrl.IndexOf("?", 0) >= 0)
            OldQueryString = NewUrl.Substring(NewUrl.IndexOf("?", 0) + 1);

        if (OldQueryString != "" && QueryStringKey != "")
        {
            string[] ArrayQuery = OldQueryString.Split('&');
            for (int i = 0; i < ArrayQuery.Length; i++)
            {
                if (string.Compare(QueryStringKey, ArrayQuery[i].Substring(0, ArrayQuery[i].LastIndexOf("=")), true) == 0)
                {
                    //NewQueryString += NewKey;
                }
                else
                {
                    if (NewQueryString != "")
                        NewQueryString += "&";

                    NewQueryString += ArrayQuery[i];
                }
            }


            if (QueryStringValue != "")
            {
                if (NewQueryString != "")
                    NewQueryString += "&";

                NewQueryString += NewKey;
            }


            if (NewQueryString != "")
                NewUrl = PageUrl + "?" + NewQueryString;
            else
                NewUrl = PageUrl;

        }
        else
        {
            if (QueryStringKey != "" && QueryStringValue != "")
            {
                NewUrl = PageUrl + "?" + NewKey;
            }
        }
        return NewUrl;
    }

    public static string SubString(string title, int length)
    {
        if (string.IsNullOrEmpty(title))
            return "";

        if (!title.Contains(" "))
        {
            if (title.Length > length)
                title = title.Substring(0, length - 1) + "...";
        }
        else if (title.Length >= length)
        {
            int i = length - 1;
            while (title.Substring(i--, 1) != " " && i > 0) ;
            if (i == 0)
                return title.Substring(0, length - 4) + " ...";
            else
                return title.Substring(0, i + 1) + " ...";
        }

        return title;
    }
    
    public static string ShotFormatDateTimeVN(string datetime)
    {
        return System.DateTime.Parse(datetime).ToString("dd'/'MM'/'yyyy");

    }
    public static string CutDateTimeVN2(System.DateTime datetime)
    {
        string strCurDT = ShotFormatDateTimeVN(System.DateTime.Now.ToString());
        string mydt = datetime.DayOfWeek.ToString().Substring(0, 3);
        string Output = "";
        switch (mydt)
        {
            case "Mon":
                Output = "Thứ hai, " + strCurDT;
                break;
            case "Tue":
                Output = "Thứ ba, " + strCurDT;
                break;
            case "Wed":
                Output = "Thứ tư, " + strCurDT;
                break;
            case "Thu":
                Output = "Thứ năm, " + strCurDT;
                break;
            case "Fri":
                Output = "Thứ sáu, " + strCurDT;
                break;
            case "Sat":
                Output = "Thứ bảy, " + strCurDT;
                break;
            case "Sun":
                Output = "Chủ nhật, " + strCurDT;
                break;

        }
        return Output;
    }
    public static string GetIMG(object imageGuid)
    {
        return GetAttachImage(imageGuid.ToString(), "NodeAlias", "", "", true);
    }
    public static string GetIMG(object imageGuid,string width,string height)
    {
        return GetAttachImage(imageGuid.ToString(), "NodeAlias", width, height, true);
    }  

    public static string CreateStringMD5(string strText)
    {
        return FormsAuthentication.HashPasswordForStoringInConfigFile(strText, "MD5");
    }
    public static string GetRandomString()
    {
        Random random = new Random();
        int number = random.Next(100, 100000);
        string strText = FormsAuthentication.HashPasswordForStoringInConfigFile(number.ToString(), "MD5");
        return strText;
    }    
    
    public static string GetParentName(object nodeParentID)
    {
        var _name = GetDocuments("Content_MenuItem", "MenuItemName", "NodeID = "+nodeParentID+"", "");
        if(_name!=null)
            return _name.ToString();
        return string.Empty;
    }

    public static string GetPathParent(object nodeParentID)
    {
        var _name = GetDocuments("Content_MenuItem", "NodeAliasPath", "NodeID = " + nodeParentID + "", "");
        if (_name != null)
            return _name.ToString();
        return string.Empty;
    }   
        
    public static void RejectDocument(string nodeAliasPath)
    {
        UserInfo ui = UserInfoProvider.GetUserInfo(CMSContext.CurrentUser.UserID);
        TreeProvider tree = new TreeProvider(ui);
        CMS.TreeEngine.TreeNode node = tree.SelectSingleNode(CMSContext.CurrentSiteName,
            nodeAliasPath, CMSContext.CurrentUser.PreferredCultureCode, false, null, false);

        if (node != null)
        {
            node = DocumentHelper.GetDocument(node, tree);
            WorkflowManager wm = new WorkflowManager(tree);
            wm.MoveToPreviousStep(node, "");
        }

    }

    public static void ApproveDocument(string nodeAliasPath)
    {
        UserInfo ui = UserInfoProvider.GetUserInfo(CMSContext.CurrentUser.UserID);
        TreeProvider tree = new TreeProvider(ui);
        CMS.TreeEngine.TreeNode node = tree.SelectSingleNode(CMSContext.CurrentSiteName,
            nodeAliasPath, CMSContext.CurrentUser.PreferredCultureCode, false, null, false);

        if (node != null)
        {
            node = DocumentHelper.GetDocument(node, tree);
            WorkflowManager wm = new WorkflowManager(tree);
            wm.MoveToNextStep(node, "");
        }
    }

    public static void DeleteDocument(string nodeAliasPath)
    {
        UserInfo ui = UserInfoProvider.GetUserInfo(CMSContext.CurrentUser.UserID);
        TreeProvider tree = new TreeProvider(ui);
        CMS.TreeEngine.TreeNode node = tree.SelectSingleNode(CMSContext.CurrentSiteName,
            nodeAliasPath, CMSContext.CurrentUser.PreferredCultureCode, false, null, false);
        if (node != null)
        {
            DocumentHelper.DeleteDocument(node, tree, true, false, true);
        }
    }

    public static void CreateDocument(object nodeAliasPath, object documentPageTemplateID, object documentType, string[] parameterName, object[] parameterValue, object documentName)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        CMS.TreeEngine.TreeNode parent = provider.SelectSingleNode(CMS.CMSHelper.CMSContext.CurrentSiteName, nodeAliasPath.ToString(), cultureCode);
        CMS.TreeEngine.TreeNode node = new CMS.TreeEngine.TreeNode(documentType.ToString(), provider);
        if (parent != null)
        {
            node.SetValue("DocumentName", documentName);
            node.SetValue("DocumentCulture", cultureCode);
            for (int i = 0; i < parameterName.Length; i++)
            {
                node.SetValue(parameterName[i], parameterValue[i]);
            }
            node.DocumentPageTemplateID = (int)documentPageTemplateID;
            node.Insert(parent.NodeID);
        }
    }

    /// <summary>
    /// Hàm tạo document có upload file
    /// </summary>
    /// <param name="nodeAliasPath"></param>
    /// <param name="documentPageTemplateID"></param>
    /// <param name="documentType"></param>
    /// <param name="parameterName"></param>
    /// <param name="parameterValue"></param>
    /// <param name="documentName"></param>
    public static void CreateDocument(object nodeAliasPath, object documentPageTemplateID, object documentType, string[] parameterName, object[] parameterValue, object documentName, string fieldUploadName, FileUpload fupload)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        CMS.TreeEngine.TreeNode parent = provider.SelectSingleNode(CMS.CMSHelper.CMSContext.CurrentSiteName, nodeAliasPath.ToString(), cultureCode);
        CMS.TreeEngine.TreeNode node = new CMS.TreeEngine.TreeNode(documentType.ToString(), provider);
        if (parent != null)
        {
            node.SetValue("DocumentName", documentName);
            node.SetValue("DocumentCulture", cultureCode);
            for (int i = 0; i < parameterName.Length; i++)
            {
                node.SetValue(parameterName[i], parameterValue[i]);
            }
            node.DocumentPageTemplateID = (int)documentPageTemplateID;
            node.Insert(parent.NodeID);
            if (fupload.PostedFile != null && fupload.FileContent.Length != 0)
            {
                DocumentHelper.AddAttachment(node, fieldUploadName, fupload.PostedFile, provider);
                // Update the document
                DocumentHelper.UpdateDocument(node, provider);
            }
        }
    }

    public static void UpdateDocument(object nodeAliasPath, string[] parameterName, object[] parameterValue)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        // get document with specified site, alias path and culture
        CMS.TreeEngine.TreeNode node = provider.SelectSingleNode(CMS.CMSHelper.CMSContext.CurrentSiteName, nodeAliasPath.ToString(), cultureCode);
        if (node != null)
        {
            for (int i = 0; i < parameterName.Length; i++)
            {
                node.SetValue(parameterName[i], parameterValue[i]);
            }
            node.Update();
        }
    }

    public static void UpdateDocument(int nodeID, string[] parameterName, object[] parameterValue)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        // get document with specified site, alias path and culture
        CMS.TreeEngine.TreeNode node = provider.SelectSingleNode(nodeID);
        if (node != null)
        {
            for (int i = 0; i < parameterName.Length; i++)
            {
                node.SetValue(parameterName[i], parameterValue[i]);
            }
            node.Update();
        }
    }

    public static void UpdateDocument(int nodeID, string[] parameterName, object[] parameterValue, string fieldUploadName, FileUpload fupload)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        // get document with specified site, alias path and culture
        CMS.TreeEngine.TreeNode node = provider.SelectSingleNode(nodeID);
        if (node != null)
        {
            for (int i = 0; i < parameterName.Length; i++)
            {
                node.SetValue(parameterName[i], parameterValue[i]);
            }
            node.Update();
            if (fupload.PostedFile != null && fupload.FileContent.Length != 0)
            {
                DocumentHelper.AddAttachment(node, fieldUploadName, fupload.PostedFile, provider);
                // Update the document
                DocumentHelper.UpdateDocument(node, provider);                
            }
        }
    }

    public static string GetDocumentAttachment(string nodeAliasPath)
    {
        string result = string.Empty;
        string path = string.Empty;
        if (string.IsNullOrEmpty(nodeAliasPath))
            path = GetRequestNodeAlias;
        else
            path = nodeAliasPath;
        string docId = string.Empty;
        object d = CMSUtils.GetDocuments("CMS_Tree", "DocumentID", "NodeAliasPath=N'" + path + "'", "");
        if (d != null)
            docId = d.ToString();
        if (!string.IsNullOrEmpty(docId))
        {
            var dtb = VTSqlHelper.ExecuteDataTable("SELECT AttachmentName,AttachmentGUID from CMS_Attachment where AttachmentDocumentID = " + docId + "");
            if (dtb.Rows.Count > 0)
            {
                var item = dtb.Rows[0];
                result = "/cms/getattachment/" + item["AttachmentGUID"] + "/" + item["AttachmentName"] + ".aspx";
            }
        }
        return result;
    }


    public static void MoveDocument(object nodeAliasPath)
    {
        string cultureCode = CMSUtils.GetCultureCode();
        CMS.TreeEngine.TreeProvider provider = new CMS.TreeEngine.TreeProvider(CMS.CMSHelper.CMSContext.CurrentUser);
        // get document with specified site, alias path and culture
        CMS.TreeEngine.TreeNode node = provider.SelectSingleNode(CMS.CMSHelper.CMSContext.CurrentSiteName, nodeAliasPath.ToString(), cultureCode);
        if (node != null)
        {
            // move document
            var targetNode = nodeAliasPath;
            if (targetNode != null && !string.IsNullOrEmpty(targetNode.ToString()))
            {
                var target = provider.SelectSingleNode(CMS.CMSHelper.CMSContext.CurrentSiteName, targetNode.ToString(), cultureCode);
                if ((target != null) && (node != null))
                {
                    // Move the document under the specified target
                    provider.MoveNode(node, target.NodeID);
                }
            }
        }
    }        

    /// <summary>
    /// Hàm gọi store không có tham số output
    /// </summary>
    /// <param name="parameterName"></param>
    /// <param name="parameterValue"></param>
    /// <param name="storeName"></param>
    /// <returns></returns>
    public static DataTable GetDocumentsByStore(string[] parameterName, object[] parameterValue, object storeName)
    {
        var pars = new SqlParameter[parameterName.Length];
        for (int i = 0; i < pars.Length; i++)
        {
            pars[i] = new SqlParameter(parameterName[i], parameterValue[i]);
        }
        var tb = VTSqlHelper.ExecuteDataTable(storeName.ToString(), pars);
        return tb;
    }
    /// <summary>
    /// Có tham số outout - trường hợp có phân trang dữ liệu
    /// </summary>
    /// <param name="pageIndex"></param>
    /// <param name="pageSize"></param>
    /// <param name="totalRow">Trong store biến output phải ở vị trí 3,kế pagezize</param>
    /// <param name="parameterName"></param>
    /// <param name="parameterValue"></param>
    /// <param name="storeName"></param>
    /// <returns></returns>
    public static DataTable GetDocumentsByStore(int pageIndex, int pageSize, out int totalRow, string[] parameterName, object[] parameterValue, object storeName)
    {
        totalRow = 0;
        var pars = new SqlParameter[parameterName.Length];
        pars[0] = new SqlParameter("PageIndex", (pageIndex == 0 ? 1 : pageIndex));
        pars[1] = new SqlParameter("PageSize", (pageSize == 0 ? 10 : pageSize));
        pars[2] = new SqlParameter("TotalRow", SqlDbType.Int);
        pars[2].Direction = ParameterDirection.Output;
        for (int i = 3; i < pars.Length; i++)
        {
            pars[i] = new SqlParameter(parameterName[i], parameterValue[i]);
        }
        var tb = VTSqlHelper.ExecuteDataTable(storeName.ToString(), pars);
        totalRow = int.Parse(pars[2].Value.ToString());
        return tb;

    }
    /// <summary>
    /// Lấy file attachment ở tab property
    /// </summary>
    /// <param name="nodeAliasPath"></param>
    /// <returns></returns>
    public static DataTable GetDocumentAttachment(object nodeAliasPath)
    {
        var linkDownLoad = string.Empty;
        var query = "SELECT cmsA.AttachmentName,cmsA.AttachmentGUID ";
        query += "FROM View_CMS_Tree_Joined_Attachments as cmsTA INNER JOIN CMS_Attachment AS cmsA on ";
        query += "cmsTA.DocumentID = cmsA.AttachmentDocumentID AND cmsTA.NodeAliasPath = N'" + nodeAliasPath + "'";
        return VTSqlHelper.ExecuteDataTable(query);
    }
    
    public static string GetFileAttachment(string guid)
    {
        try
        {
            if (!string.IsNullOrEmpty(guid))
            {

                var file = "~/MBMCMS/files/" + guid.Substring(0, 2) + "/";
                var searchFile = Directory.GetFiles(HttpContext.Current.Server.MapPath(file), guid + ".*");
                if (searchFile.Length > 0)
                    return file + Path.GetFileName(searchFile[0].ToString());
            }
        }
        catch { }
        return string.Empty;
    }


    public static string GetFlashByNodeGuid(object nodeGuid, int height, int width)
    {
        StringBuilder strFlash = new StringBuilder();
        strFlash.Append("<embed height='" + height + "' width='" + width + "' wmode='transparent' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' ");
        strFlash.Append("src='" + GetFileAttachment(nodeGuid.ToString()) + "' id='mymovie' name='mymovie' quality='high'>");
        return strFlash.ToString();
    }

    public static string GetFlashByNodeGuid(object nodeGuid, int width)
    {
        StringBuilder strFlash = new StringBuilder();
        strFlash.Append("<embed width='" + width + "' wmode='transparent' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' ");
        strFlash.Append("src='" + GetFileAttachment(nodeGuid.ToString()) + "' id='mymovie' name='mymovie' quality='high'>");
        return strFlash.ToString();
    }
    
    /// <summary>
    /// Get file video dạng FLV không có logo
    /// </summary>
    /// <param name="guid"></param>
    /// <param name="height"></param>
    /// <param name="width"></param>
    /// <returns></returns>
    public static string GetFLV(object guid, int height, int width)
    {
        var src = GetFileAttachment(guid.ToString());
        StringBuilder str = new StringBuilder();
        str.Append("<embed wmode='transparent' width='" + height + "' height='" + width + "' flashvars='file=" + src + "&amp;provider=video&amp;controlbar=bottom&amp;autostart=false&amp;repeat=none' allowscriptaccess='always' allowfullscreen='true' src='/App_Themes/player.swf' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' name='278d55db689944df8f5e1663224ed8c4'>");
        return str.ToString();    
    }
    /// <summary>
    /// Get file FLV có ảnh nền
    /// </summary>
    /// <param name="guid"></param>
    /// <param name="height"></param>
    /// <param name="width"></param>
    /// <param name="logo"></param>
    /// <returns></returns>
    public static string GetFLV(object guid, int height, int width, object logo)
    {
        StringBuilder str = new StringBuilder();
        str.Append("<embed width='" + width + "' height='" + height + "' type='application/x-shockwave-flash' src='/App_Themes/player.swf' style='' id='os' name='os'");
        str.Append("bgcolor='#FFFFFF' quality='high' allowfullscreen='true' allowscriptaccess='always' wmode='transparent' flashvars=");
        str.Append("'file=" + guid.ToString() + "&image=" + GetIMG(logo,"","") + "'>");
        return str.ToString();
    }    
    
    /// <summary>
    /// Gét giá sản phẩm ví dụ : 125,454 VNĐ
    /// </summary>
    /// <param name="number"></param>
    /// <param name="name"></param>
    /// <returns></returns>
    public static string GetPrice(object number,string name)
    {
        if (number != null && !string.IsNullOrEmpty(name))
        {
            double _number = ValidationHelper.GetDouble(number, 0);            
            if(_number!=0)
                return double.Parse(number.ToString()).ToString("#,###") + " " + name;
            return "Call";
        }
        return "Call";
    }
    /// <summary>
    /// Lấy ngày đăng hay dùng cho tin tức
    /// </summary>
    /// <param name="time"></param>
    /// <returns></returns>
    public static string GetTime(object time)
    {
       if(time!=null)
           return Convert.ToDateTime(time.ToString()).ToString("dd.MM.yyyy - hh:mm");
        return string.Empty;
    }

    /// <summary>
    /// Lấy thời gian hôm nay
    /// </summary>
    /// <param name="time"></param>
    /// <returns></returns>
    public static string GetTimeToday()
    {
        return CutDateTimeVN2(DateTime.Now);
    }

    /// <summary>
    /// Check email khi đăng ký thành viên
    /// </summary>
    /// <param name="email"></param>
    /// <returns></returns>
    public static bool ChekEmail(string email)
    {
        var query = "Select Email From View_CMS_User Where Email=N'" + email.Trim() + "'";
        var dtb = VTSqlHelper.ExecuteDataTable(query);
        if (dtb != null && dtb.Rows.Count > 0)
            return false;
        return true;
    }

    /// <summary>
    /// Check user khi đăng ký thành viên
    /// </summary>
    /// <param name="userName"></param>
    /// <returns></returns>
    public static bool CheckUserName(string userName)
    {
        var query = "Select UserName From View_CMS_User Where UserName=N'" + userName.Trim() + "'";
        var dtb = VTSqlHelper.ExecuteDataTable(query);
        if (dtb != null && dtb.Rows.Count > 0)
            return false;
        return true;
    }
    //Code play video youtube
    /*
     * <embed width='233' height='200' quality='high' allowscriptaccess='always' wmode='transparent' allowfullscreen='true' 
flashvars='file=http://www.youtube.com/watch?v=PwMhQEGDMCk&amp;feature=related&amp;feature=player_embedded;autostart=false' src='http://player.longtailvideo.com/player.swf'>
     */
    public static string GetVideoFromYoutube(object linkYoutube, string height, string width)
    {
        StringBuilder str = new StringBuilder();
        str.Append("<embed width='" + width + "' height='" + height + "' quality='high' allowscriptaccess='always' wmode='transparent' allowfullscreen='true' ");
        str.Append("flashvars='file=" + linkYoutube + "&amp;feature=related&amp;feature=player_embedded;autostart=false' src='/App_Themes/youtube.swf'>");
        return str.ToString();
    }
    public static string GetValue(string columsName)
    {
        var value = CMSContext.CurrentDocument.GetValue(columsName);
        if(value!=null)
            return CMSContext.CurrentDocument.GetValue(columsName).ToString();
        return string.Empty;
    }
    public static string GetFileDownload(string iguid)
    {
        if (!string.IsNullOrEmpty(iguid))
        {
            return "/getattachment/" + iguid + "/Download.aspx";
        }
        return "javascript:void(0)";
    }
    public static bool ISEmail(string inputEmail)
    {
        //inputEmail  = NulltoString(inputEmail);
        string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
            @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
            @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
        Regex re = new Regex(strRegex);
        if (re.IsMatch(inputEmail))
            return (true);
        else
            return (false);
    }
    public static string GetEmailConfig()
    {
        var dtb = GetDocuments("1","Config", "ConfigEmail", "", "NodeID DESC");
        if(dtb!=null && dtb.Rows.Count > 0)
            return dtb.Rows[0]["ConfigEmail"].ToString();
        return string.Empty;
    }
    public static string PostData(string url)//yahoo can hien
    {
        HttpWebRequest request = null;
        Uri uri = new Uri(url);
        request = (HttpWebRequest)WebRequest.Create(uri);
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        string result = "";
        using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
        {
            using (Stream responseStream = response.GetResponseStream())
            {
                using (StreamReader readStream = new StreamReader(responseStream, Encoding.UTF8))
                {
                    result = readStream.ReadToEnd();
                }
            }
        }
        return result;
    }

    public static bool ISOnline(string useName)//yahoo can hien
    {
        string isonval = PostData("http://mail.opi.yahoo.com/online?u=" + useName.Trim() + "&m=t&t=1");
        if (isonval == "00") return false;
        else if (isonval == "01") return true;
        else return false;

    }
    // skype
    public static bool Checkskype(string url)//yahoo vao
    {
        HttpWebRequest objRequest1 = (HttpWebRequest)WebRequest.Create("http://mystatus.skype.com/" + url + ".num");//bat buoc phai co .num o phia sau
        HttpWebResponse objResponse1 = (HttpWebResponse)objRequest1.GetResponse();
        StreamReader objReader1 = new StreamReader(objResponse1.GetResponseStream());
        string msgReturn1 = objReader1.ReadToEnd();
        objReader1.Close();
        objResponse1.Close();
        msgReturn1 = msgReturn1.ToLower().Trim();
        if (msgReturn1 == "2")
            return true;
        return false;
    }

    /// <summary>
    /// Hàm trả về -1 nếu không tìm thấy node cha
    /// </summary>
    /// <param name="childNodeID"></param>
    /// <returns></returns>
    public static int GetNodeParentIDByNodeID(object childNodeID)
    {
        var _nodeParentID = GetDocuments("CMS_Tree", "NodeParentID", "NodeID = " + childNodeID + "", "");
        if (_nodeParentID != null)
            return ValidationHelper.GetInteger(_nodeParentID,-1);
        return -1;
    }

    
}
