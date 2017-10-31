<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div>
<img src="<%# GetAttachmentIconUrl(Eval("AttachmentExtension"), "List") %>" alt="<%# Eval("AttachmentName",true) %>" />
&nbsp;
<a target="_blank" href="<%# GetAbsoluteUrl(GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath")), EvalInteger("AttachmentSiteID")) %>">
<%# Eval("AttachmentName",true) %>
</a>
</div>