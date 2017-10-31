<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<h1><%# Eval("CellName", true) %></h1>
<div class="productDetail">
<div class="productImage">
<%# IfEmpty(Eval("SKUImagePath"),
  EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")),
  "<a href=\"" + ResolveUrl((Eval("SKUImagePath")).ToString()) + "\" target=\"_blank\">" + EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")) + "</a>") %>
</div>
<div class="productDescription">
<h3>Product parameters</h3>
<div class="parameters"><%# Eval("CellDisplayType",true) %> <%# Eval("CellDisplayResolution") %>, <%# Eval("CellDisplayWidth") %>cm x <%# Eval("CellDisplayHeight") %>cm<%# IfCompare(Eval("CellBluetooth"), false, ", Bluetooth", "") %><%# IfCompare(Eval("CellIrDA"), false, ", IrDA", "") %><%# IfCompare(Eval("CellGPRS"), false, ", GPRS", "") %><%# IfCompare(Eval("CellEDGE"), false, ", EDGE", "") %><%# IfCompare(Eval("CellHSCSD"), false, ", HSCSD", "") %><%# IfCompare(Eval("Cell3G"), false, ", 3G", "") %><%# IfCompare(Eval("CellWiFi"), false, ", WiFi", "") %><%# IfCompare(Eval("CellJava"), false, ", Java", "") %><%# IfCompare(Eval("CellCamera"), false, ", Camera", "") %><%# IfCompare(Eval("CellMP3"), false, ", MP3 player", "") %></div>
<table cellspacing="0" cellpadding="0" border="0" class="parameterTable">
<tr><td class="caption">Manufacturer:</td>
<td class="parameter"><%# IfEmpty(Eval("SKUManufacturerID"), "-", HTMLEncode(EcommerceFunctions.GetManufacturer(Eval("SKUManufacturerID"),"ManufacturerDisplayName").ToString())) %></td>
</tr><tr>
<td class="caption">Availability (days):</td>
<td class="parameter"><%# IfEmpty(Eval("SKUAvailableInDays"), "-", Eval("SKUAvailableInDays")) %></td>
</tr><tr>
<td class="caption">In stock:</td>
<td class="parameter"><%# IfEmpty(Eval("SKUAvailableItems"), "no", "yes") %></td>
</tr></table>
<div class="ourPrice listBoxHead">Our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span></div>
<div class="addToCart contentBox">
<uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>
            ' SKUEnabled='
            <%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %> ' AddToCartImageButton="addtocart.gif" AddToCartLinkText="Add to shopping cart" ShowProductOptions="true" ShowDonationProperties="true" ShowUnitsTextBox="true"/>
<div class="addToWishlist">
<%# EcommerceFunctions.GetAddToWishListLink(Eval("NodeSKUID"), "~/App_Themes/CorporateSite/Images/addtowishlist.png") %>
</div>  
</div>
</div>
<div class="clear"></div>
<h3>Product description</h3>
  <div class="TextContent productDetailDescription">
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus pulvinar, orci id accumsan feugiat, purus purus molestie risus, ut volutpat urna quam quis mi. Suspendisse at nisi quis urna sodales vehicula id vitae velit. In elit augue, adipiscing ac commodo ac, tristique sed risus. Aenean eleifend, orci quis egestas condimentum, ante lacus facilisis risus, ac tristique purus erat non nisi.
    <%# Eval("SKUDescription") %>
  </div>
</div>
