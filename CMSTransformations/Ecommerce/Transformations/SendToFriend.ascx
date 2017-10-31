<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><h1 style="margin-top:15px">
  <%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></h1>
<table cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <h3>Description</h3>
      <%# Eval("SKUDescription") %>
    </td>
  </tr>
  <tr>
    <td align="left" >
      <h3> Our price: <%# GetSKUFormattedPrice(true, false) %></h3>
      </td>    
  </tr>
  <tr>
    <td style="text-align:center; vertical-align:top;">
      <a href="<%# Eval("SKUImagePath") %>">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName"))%>
</a></td>
  </tr>
</table>