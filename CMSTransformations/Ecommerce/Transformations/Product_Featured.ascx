<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="FeaturedProduct">
 <table>
  <tr><td>
  <a href="<%# GetDocumentUrl() %>">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 100, Eval("SKUName"))%>
</a>
  </td></tr><tr><td>
  Price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %>
</span>
  </td></tr>
  </table>
</div>