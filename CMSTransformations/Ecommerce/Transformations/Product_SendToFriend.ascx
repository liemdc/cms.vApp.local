<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<div class="ProductPreview">
  <div class="ProductBox">    
    <a href="<%# GetDocumentUrl() %>">
        <h1><%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></h1>
    </a>
    <br />
    <br />
    <table>
      <tr>
        <td><%# ResHelper.LocalizeString(Convert.ToString(Eval("SKUDescription"))) %></td>
      </tr>
    </table>
    <br />
    <div class="ProductPrice">
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr>
      <td class="left">Our price:</td>
      <td class="right"><%# GetSKUFormattedPrice(true, false) %></td>
      </tr>
    </table>
    </div>    
  </div>
</div>