<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="ProductDetail">
<div class="ProductData">
  <table>
    <tr>
      <td class="ProductImage" valign="top" >
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 80, Eval("SKUName"))%>
      </td>
      <td class="ProductSummary" style="vertical-align: top; padding-left: 5px;">
        <h2><a href="<%# EcommerceFunctions.GetProductUrl(Eval("SKUGUID"), Eval("SKUName")) %>" title="<%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>"><%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></a></h2>
  <%# Eval("SKUDescription") %>
  our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span>
      </td>
    </tr>
  </table>
  </div>
</div>
<br />