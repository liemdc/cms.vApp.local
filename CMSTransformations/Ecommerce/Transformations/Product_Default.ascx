<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<div class="ProductDetail">
<div class="ProductData">
  <table>
    <tr>
      <td class="ProductImage">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName"))%>
      </td>
      <td class="ProductSummary">
        <h1><%# ResHelper.LocalizeString(Convert.ToString(Eval("SKUName"))) %></h1>
        <div class="ProductShortDescription"><%# Eval("ProductShortDescription") %></div>
        <%# Eval("ProductDescription") %>
      </td>
    </tr>
  </table>
  </div>
  <div class="ProductFooter">
     <table width="100%">
       <tr>
         <td align="left">
           our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span>
         </td>
         <td>
     <uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>
            ' SKUEnabled='
            <%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %> ' AddToCartImageButton="addtocart.gif" AddToCartLinkText="Add to shopping cart" />
         </td>
         <td>
     <%# EcommerceFunctions.GetAddToWishListLink(Eval("NodeSKUID")) %>    
         </td>
       </tr>
     </table>
  </div>
</div>