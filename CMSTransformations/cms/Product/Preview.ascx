<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="ProductPreview">
<div class="ProductBox">
<div class="ProductTitle">
  <a href="<%# GetDocumentUrl() %>"><%# Eval("ProductName", true) %></a>
</div>
<div class="ProductImage">
  <%#IfEmpty(Eval("ProductPhoto"), "", "<img alt='" + Eval("ProductName", true) + "' src='" + GetFileUrl("ProductPhoto") + "?height=120' />")%>
</div>
<div class="ProductFooter">
  our price: <span class="ProductPrice"> <%# GetSKUFormattedPrice(true, false) %> </span><br />
  <a href="<%# GetDocumentUrl() %>" class="LinkMore">more</a>
</div>
</div>
</div>