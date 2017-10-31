<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<h1 style="margin-top:15px"><%# Eval("SmartphoneName", true) %></h1>
<table cellspacing="0" cellpadding="0" class="productDetail">
<tr>
<td style="text-align:center; vertical-align:top;">
<%# IfEmpty(Eval("SKUImagePath"),
  EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")),
  "<a href=\"" + ResolveUrl((Eval("SKUImagePath")).ToString()) + "\" target=\"_blank\">" + EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")) + "</a>") %>
</td>
<td>
<table class="productDetailInfo TextContent" cellspacing="0" cellpadding="0">
<tr>
<td class="caption">Manufacturer:</td>
<td><%# HTMLEncode(EcommerceFunctions.GetManufacturer(Eval("SKUManufacturerID"),"ManufacturerDisplayName").ToString()) %></td>
</tr>
<tr>
<td class="caption">Availability (days):</td>
<td><%# IfEmpty(Eval("SKUAvailableInDays"), "-", Eval("SKUAvailableInDays")) %></td>
</tr>
<tr>
<td class="caption">In stock:</td>
<td><%# IfEmpty(Eval("SKUAvailableItems"), "no", "yes") %></td>
</tr>
<tr>
<td class="caption"><h3>Parameters:</h3></td>
<td>&nbsp;</td>
</tr>
<tr class="alt">
<td>Operating system:</td>
<td><%# Eval("SmartphoneOS",true) %></td>
</tr>
<tr>
<td>Dimensions:</td>
<td><%# Eval("SmartphoneDimensions",true) %></td>
</tr>
<tr class="alt">
<td>Weight:</td>
<td><%# Eval("SmartphoneWeight",true) %></td>
</tr>
<tr>
<td>Display type:</td>
<td><%# Eval("SmartphoneDisplayType",true) %></td>
</tr>
<tr class="alt">
<td>Display size:</td>
<td><%# Eval("SmartphoneDisplaySize",true) %></td>
</tr>
<tr>
<td>Display resolution:</td>
<td><%# Eval("SmartphoneDisplayResolution",true) %></td>
</tr>
<tr class="alt">
<td>CPU:</td>
<td><%# Eval("SmartphoneCPU",true) %></td>
</tr>
<tr>
<td>RAM:</td>
<td><%# Eval("SmartphoneRAM",true) %></td>
</tr>
<tr class="alt">
<td>Internal storage:</td>
<td><%# Eval("SmartphoneInternalStorage",true) %></td>
</tr>
<tr>
<td>Removable storage:</td>
<td><%# Eval("SmartphoneRemovableStorage",true) %></td>
</tr>
<tr class="alt">
<td>Battery type:</td>
<td><%# Eval("SmartphoneInternalStorage",true) %></td>
</tr>
<tr>
<td>Camera:</td>
<td><%# Eval("SmartphoneRemovableStorage",true) %></td>
</tr>
<tr class="alt">
<td>GPS module:</td>
<td><%# IfCompare(Eval("SmartphoneGPS"), false, "yes", "no") %></td>
</tr>
</table>
</td>
</tr>
<tr><td colspan="2">
<div class="productDetailLinks">
<table width="100%">
  <tr>
    <td align="left">
      <strong>Our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span></strong>
    </td>
    <td>
      <uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>
            ' SKUEnabled='
            <%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %> ' AddToCartImageButton="addtocart.gif" AddToCartLinkText="Add to shopping cart" ShowProductOptions="true" ShowUnitsTextBox="true"/>
    </td>
    <td style="vertical-align:bottom;width:15%;">
       <%# EcommerceFunctions.GetAddToWishListLink(Eval("NodeSKUID")) %>    
    </td>
  </tr>
</table>
</div>
</td></tr>
<tr><td colspan="2">
  <h3>Description:</h3>
  <div class="TextContent">
    <%# Eval("SKUDescription") %>
  </div>
</td></tr>
</table>
