<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div style="margin-bottom: 30px;">
  <%-- Search result image --%>
        <div style="margin-right: 5px;" class="LeftAlign">
           <img src="<%# UIHelper.GetDocumentTypeIconUrl(this.Page, ValidationHelper.GetString(DataBinder.Eval(((System.Web.UI.WebControls.RepeaterItem)(Container)).DataItem, "ClassName"), "")) %>" alt="" />
        </div>
        <div class="LeftAlign" style="width:95%;">
            <%-- Search result title --%>
            <div>
        <a style="font-weight: bold" href="<%# "javascript:SelectItem(" + Eval("NodeID") + ", \'" + Eval("DocumentCulture") + "\')" %>"><%# IfEmpty(Eval("NodeName"), "/", HTMLHelper.HTMLEncode(ValidationHelper.GetString(Eval("NodeName"), null))) %> (<%# Eval("DocumentCulture") %>)</a>
            </div>
</div>
<div class="LeftAlign">
  <div style="margin-top: 5px;">
<%-- URL --%>
                <span style="color: #008000">
                    <%#  GetAbsoluteUrl(GetDocumentUrl()) %>
                </span>
                <%-- Creation --%>
                <span style="padding-left:5px;;color: #888888; font-size: 9pt">
                    <%# GetDateTimeString(ValidationHelper.GetDateTime(Eval("DocumentCreatedWhen"), DateTimeHelper.ZERO_TIME), true) %>
                </span>
        </div>
  </div>
<div style="clear: both"></div>
</div>