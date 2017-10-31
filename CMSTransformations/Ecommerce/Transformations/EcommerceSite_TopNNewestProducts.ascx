<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="randomProductWithStatusRightBlock">
<div class="imageLink">
<div class="imageLinkContent">
<a href="<%# GetDocumentUrl() %>" > 
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 50, Eval("SKUName"))%>
</a>
</div>
</div>
<div class="randomProductRight">
<a href="<%# GetDocumentUrl() %>" title="<%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>"><%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></a><br />
<%# GetSKUFormattedPrice(true, false) %>
</div>
</div>