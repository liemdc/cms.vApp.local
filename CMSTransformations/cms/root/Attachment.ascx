<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.GlobalHelper" Assembly="CMS.GlobalHelper" %>
<div>
<a target="_blank" href="<%# GetAbsoluteUrl(GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath")), Eval<int>("AttachmentSiteID")) %>">
<img style="border: none;" src="<%# IfCompare(ImageHelper.IsImage((string)Eval("AttachmentExtension")), true, GetAttachmentIconUrl(Eval("AttachmentExtension"), null), GetAbsoluteUrl(GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath")), Eval<int>("AttachmentSiteID"))) %>?maxsidesize=150" alt="<%# Eval("AttachmentName", true) %>" />
</a>
<%# IfCompare(ImageHelper.IsImage((string)Eval("AttachmentExtension")), true, "<br />" + ResHelper.GetString("attach.openfile"), "") %>
<br />
<%# Eval("AttachmentName",true) %>
<br />
</div>