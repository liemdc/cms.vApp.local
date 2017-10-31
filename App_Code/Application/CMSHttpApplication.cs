using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using CMS.CMSHelper;
using System.Data;

public class CMSHttpApplication : HttpApplication
{
    #region "Variables"

    /// <summary>
    /// True if handlers were already initialized
    /// </summary>
    private static bool mHandlersInitialized = false;

    /// <summary>
    /// Lock object
    /// </summary>
    private static object mLock = new object();

    #endregion


    #region "Application events"

    /// <summary>
    /// Application start event handler.
    /// </summary>
    public void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        //Application["HomNay"] = 0;
        //Application["HomQua"] = 0;
        //Application["TuanNay"] = 0;
        //Application["TuanTruoc"] = 0;
        //Application["ThangNay"] = 0;
        //Application["ThangTruoc"] = 0;
        //Application["TatCa"] = 0;
        //Application["visitors_online"] = 0;
        // Azure Application start init
        AzureInit.Current.ApplicationStartInit();

        CMSAppBase.CMSApplicationStart();
    }


    /// <summary>
    /// Application error event handler.
    /// </summary>
    public void Application_Error(object sender, EventArgs e)
    {
        CMSAppBase.CMSApplicationError(sender, e);
    }


    /// <summary>
    /// Application end event handler.
    /// </summary>
    public void Application_End(object sender, EventArgs e)
    {
        //Application.Lock();
        //Application["visitors_online"] = Convert.ToUInt32(Application["visitors_online"]) - 1;
        //Application.UnLock();
        CMSAppBase.CMSApplicationEnd(sender, e);
    }

    #endregion


    #region "Session events"

    /// <summary>
    /// Session start event handler.
    /// </summary>
    public void Session_Start(object sender, EventArgs e)
    {
        //Session.Timeout = 150;
        //Application.Lock();
        //Application["visitors_online"] = Convert.ToInt32(Application["visitors_online"]) + 1;        
        //try
        //{
        //    DataTable dtb = MBMSqlHelper.ExecuteDataTable("spThongKe_Edit");
        //    if (dtb.Rows.Count > 0)
        //    {
        //        Application["HomNay"] = long.Parse("0" + dtb.Rows[0]["HomNay"]).ToString("#,###");
        //        Application["HomQua"] = long.Parse("0" + dtb.Rows[0]["HomQua"]).ToString("#,###");
        //        Application["TuanNay"] = long.Parse("0" + dtb.Rows[0]["TuanNay"]).ToString("#,###");
        //        Application["TuanTruoc"] = long.Parse("0" + dtb.Rows[0]["TuanTruoc"]).ToString("#,###");
        //        Application["ThangNay"] = long.Parse("0" + dtb.Rows[0]["ThangNay"]).ToString("#,###");
        //        Application["ThangTruoc"] = long.Parse("0" + dtb.Rows[0]["ThangTruoc"]).ToString("#,###");
        //        Application["TatCa"] = long.Parse("0" + dtb.Rows[0]["TatCa"]).ToString("#,###");
        //    }
        //    dtb.Dispose();
        //}
        //catch { }
        //Application.UnLock();
        CMSAppBase.CMSSessionStart(sender, e);
    }


    /// <summary>
    /// Session end event handler.
    /// </summary>
    public void Session_End(object sender, EventArgs e)
    {
        CMSAppBase.CMSSessionEnd(sender, e);
    }

    #endregion


    #region "Request events"

    /// <summary>
    /// Constructor
    /// </summary>
    public CMSHttpApplication()
    {
        InitHandlers();
    }


    /// <summary>
    /// Initializes the handlers
    /// </summary>
    private void InitHandlers()
    {
        if (mHandlersInitialized)
        {
            return;
        }

        lock (mLock)
        {
            if (mHandlersInitialized)
            {
                return;
            }

            // Map the request handlers
            CMSApplicationModule.BeginRequest += CMSAppBase.CMSBeginRequest;
            CMSApplicationModule.AuthenticateRequest += CMSAppBase.CMSAuthenticateRequest;
            CMSApplicationModule.AuthorizeRequest += CMSAppBase.CMSAuthorizeRequest;
            CMSApplicationModule.MapRequestHandler += CMSAppBase.CMSMapRequestHandler;
            CMSApplicationModule.AcquireRequestState += CMSAppBase.CMSAcquireRequestState;
            CMSApplicationModule.EndRequest += CMSAppBase.CMSEndRequest;

            mHandlersInitialized = true;
        }
    }

    #endregion


    #region "Overriden methods"

    /// <summary>
    /// Custom cache parameters processing.
    /// </summary>
    public override string GetVaryByCustomString(HttpContext context, string custom)
    {
        return CMSAppBase.CMSGetVaryByCustomString(context, custom);
    }

    #endregion
}

