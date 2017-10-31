<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="hotOffers">
<div class="hotImage">
<a href="<%# GetDocumentUrl() %>" ><%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath", true), 170, Eval("SKUName", true)) %></a>
</div>
<div class="hotPrice"><span>Our price: <%# GetSKUFormattedPrice(true, false) %></span></div>
<div class="hotLink">
<div class="hotText">
<a href="<%# GetDocumentUrl() %>" title="<%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>"><%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></a>
</div>
</div>
</div>