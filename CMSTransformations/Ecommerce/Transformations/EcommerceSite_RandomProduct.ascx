<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="randomProductWithStatus">
<a href="<%# EcommerceFunctions.GetProductUrl(Eval("SKUGUID"), Eval("SKUName")) %>"> 
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 120, Eval("SKUName"))%>
</a>
<br />
<a href="<%# EcommerceFunctions.GetProductUrl(Eval("SKUGUID"), Eval("SKUName")) %>"><%# ResHelper.LocalizeString(Convert.ToString(Eval("SKUName",true))) %></a>
</div>