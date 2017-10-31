<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<div class="ProductPreview">
  <div class="ProductBox"> 
    <div class="ProductImage">
      <a href="<%# GetDocumentUrl() %>" style="display:block;" title="<%# ResHelper.LocalizeString(Convert.ToString(Eval("SKUName", true))) %>">
  <%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 140, Eval("SKUName", true))%>
  </a>
    </div>
    <a href="<%# GetDocumentUrl() %>" title="<%# ResHelper.LocalizeString(Convert.ToString(Eval("SKUName", true))) %>">
      <span class="ProductTitle">
        <%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>
      </span>
    </a>
    <div class="ProductPrice">
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td class="left">
        <%# GetSKUFormattedPrice(true, false) %>
        </td>
      <td class="right">
<uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>' SKUEnabled='<%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %>' AddToCartImageButton="button_add04.gif" ShowProductOptions="false" />
</td>
      </tr>
    </table>
    </div>
    <div class="ProductFooter">
    </div>
  </div>
</div>