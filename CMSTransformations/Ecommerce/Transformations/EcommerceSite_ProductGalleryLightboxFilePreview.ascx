<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="galleryPreview">
<div class="galleryImage">
<a style="text-decoration:none;" href="<%# GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath")) %>" rel="lightbox[products]" rev="<%# Eval("AttachmentID")  %>" title="<%# IfEmpty(Eval("AttachmentTitle"), HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))), Eval("AttachmentTitle", true)) %>">
<img border="0" src="<%# IfCompare(ImageHelper.IsImage((string)Eval("AttachmentExtension")), true, GetAttachmentIconUrl(Eval("AttachmentExtension"), null), GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath"))) %>?maxsidesize=120" alt="<%# IfEmpty(Eval("AttachmentTitle"), HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))), Eval("AttachmentTitle", true)) %>" /> 
</a>
</div>
</div>