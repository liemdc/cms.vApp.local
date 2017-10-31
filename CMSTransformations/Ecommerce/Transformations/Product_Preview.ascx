<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<div class="ProductPreview">
  <div class="ProductBox">
    <div class="ProductImage">
      <a href="<%# GetDocumentUrl() %>" style="display:block;"> 
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 140, Eval("SKUName"))%>
      </a>
    </div>
    <a href="<%# GetDocumentUrl() %>">
      <span class="ProductTitle">
        <%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>
      </span>
    </a>
    <div class="ProductPrice">
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr>
      <td class="left">Our price:&nbsp;</td>
      <td class="right"><%# GetSKUFormattedPrice(true, false) %></td>
      </tr>
    </table>
    </div>
    <div class="ProductFooter">
      <uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>
            ' SKUEnabled='
            <%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %> ' AddToCartLinkText="Add to shopping cart" />
    </div>
  </div>
</div>