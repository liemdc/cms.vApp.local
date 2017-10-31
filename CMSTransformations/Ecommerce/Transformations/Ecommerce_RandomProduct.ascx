<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="randomProduct">
<a href="<%# GetDocumentUrl() %>">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath", true), 125, Eval("SKUName", true))%>
</a>
<br />
<a href="<%# GetDocumentUrl() %>" title="<%# Eval("SKUName", true) %>"><%# Eval("SKUName", true) %></a>
</div>