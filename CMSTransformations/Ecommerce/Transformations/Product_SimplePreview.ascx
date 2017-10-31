<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="ProductPreview">
  <div class="ProductBox">
    <div class="ProductImage">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 140, Eval("SKUName"))%>
    </div>
      <div class="ProductTitle">
        <%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>
      </div>
    <table class="ProductPrice" cellpadding="0" cellspacing="0">
      <tr>
      <td class="left">Our price:&nbsp;</td>
      <td class="right"><%# GetSKUFormattedPrice(true, false) %></td>
      </tr>
    </table>
  </div>
</div>