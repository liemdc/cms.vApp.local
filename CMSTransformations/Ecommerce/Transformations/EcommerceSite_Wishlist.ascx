﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<div class="ProductDetail">
<div class="ProductData">
  <table style="width: 100%;">
    <tr>
      <td class="ProductImageWishlist">
<a href="<%# EcommerceFunctions.GetProductUrl(Eval("SKUGUID"), Eval("SKUName")) %>" > 
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 80, Eval("SKUName"))%>
</a>
      </td>
      <td class="ProductSummary" style="vertical-align: top; padding-left: 5px;">
        <h2><a href="<%# EcommerceFunctions.GetProductUrl(Eval("SKUGUID"), Eval("SKUName")) %>"><%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %></a></h2>
  <%# Eval("SKUDescription") %>
  <span class="ProductPrice">Our price: <%# GetSKUFormattedPrice(true, false) %></span>
<div class="wishlistAdd">
  <uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>' SKUEnabled='<%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %>' AddToCartImageButton="button_add09.gif"
ShowProductOptions="false" />
<div class="removeFromWishlist">  
<%# EcommerceFunctions.GetRemoveFromWishListLink(Eval("SKUID")) %>
</div>
</div>
      </td>
    </tr>
  </table>
  </div>
</div>