<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<h1><%# Eval("SmartphoneName", true) %></h1>
<div class="productDetail">
<div class="productImage">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")) %>
</div>
<div class="productDescription">
<h3>Product parameters</h3>
<div class="parameters">
    <%# IfEmpty(Eval("SmartphoneOS",true), "", Eval("SmartphoneOS",true) +" operating system, ")%>
    <%# IfEmpty(Eval("SmartphoneDimensions",true), "", "measuring " + Eval("SmartphoneDimensions",true) + ", ")%>
    <%# IfEmpty(Eval("SmartphoneWeight",true), "", Eval("SmartphoneWeight",true) + " weight, ")%>
    <%# IfEmpty(Eval("SmartphoneDisplaySize",true), "", Eval("SmartphoneDisplaySize",true) + " ")%>
    <%# IfEmpty(Eval("SmartphoneDisplayType",true), "", Eval("SmartphoneDisplayType",true) + " display")%>    
    <%# IfEmpty(Eval("SmartphoneDisplayResolution",true), "", " with resolution of " + Eval("SmartphoneDisplayResolution",true))%>, <%# IfEmpty(Eval("SmartphoneCPU",true), "", Eval("SmartphoneCPU",true) +" processor, ")%>
    <%# IfEmpty(Eval("SmartphoneRAM",true), "", Eval("SmartphoneRAM",true) +" RAM, ")%>
    <%# IfEmpty(Eval("SmartphoneInternalStorage",true), "", Eval("SmartphoneInternalStorage",true) +" of internal storage, ")%>
    <%# IfEmpty(Eval("SmartphoneRemovableStorage",true), "", Eval("SmartphoneRemovableStorage",true) +" removable storage, ")%>
    <%# IfEmpty(Eval("SmartphoneBatteryType",true), "", Eval("SmartphoneBatteryType",true) +" battery, ")%>
    <%# IfEmpty(Eval("SmartphoneCamera",true), "", Eval("SmartphoneCamera",true) +" camera")%><%# IfCompare(Eval("SmartphoneGPS"),true, "", ", integrated GPS module.")%>
</div>
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
<uc1:CartItemSelector id="cartItemSelector" runat="server" SKUID='<%# ValidationHelper.GetInteger(Eval("SKUID"), 0) %>' SKUEnabled='<%# ValidationHelper.GetBoolean(Eval("SKUEnabled"), false) %> ' AddToCartImageButton="addtocart.gif" AddToCartLinkText="Add to shopping cart" ShowProductOptions="true" ShowDonationProperties="true" ShowUnitsTextBox="true"/>
<div class="addToWishlist">
<%# EcommerceFunctions.GetAddToWishListLink(Eval("NodeSKUID"), "~/App_Themes/CorporateSite/Images/addtowishlist.png") %>
</div>  
</div>
</div>
<div class="clear"></div>
<h3>Product description</h3>
  <div class="TextContent productDetailDescription">
    <%# Eval("SKUDescription") %>
  </div>
  <table cellpadding="0" cellspacing="0" class="params">
    <%# IfEmpty(Eval("SmartphoneOS",true), "", "<tr><td>Operating system:</td><td>"+ Eval("SmartphoneOS",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneDimensions",true), "", "<tr><td>Dimensions:</td><td>"+ Eval("SmartphoneDimensions",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneWeight",true), "", "<tr><td>Weight:</td><td>"+ Eval("SmartphoneWeight",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneDisplayType",true), "", "<tr><td>Display type:</td><td>"+ Eval("SmartphoneDisplayType",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneDisplaySize",true), "", "<tr><td>Display size:</td><td>"+ Eval("SmartphoneDisplaySize",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneDisplayResolution",true), "", "<tr><td>Display resolution:</td><td>"+ Eval("SmartphoneDisplayResolution",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneCPU",true), "", "<tr><td>CPU:</td><td>"+ Eval("SmartphoneCPU",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneRAM",true), "", "<tr><td>RAM:</td><td>"+ Eval("SmartphoneRAM",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneInternalStorage",true), "", "<tr><td>Internal storage:</td><td>"+ Eval("SmartphoneInternalStorage",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneRemovableStorage",true), "", "<tr><td>Removable storage:</td><td>"+ Eval("SmartphoneRemovableStorage",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneBatteryType",true), "", "<tr><td>Battery type:</td><td>"+ Eval("SmartphoneBatteryType",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("SmartphoneCamera",true), "", "<tr><td>Camera:</td><td>"+ Eval("SmartphoneCamera",true) +"</td></tr>")%>
    <%# IfCompare(Eval("SmartphoneGPS"),true, "<tr><td>GPS module:</td><td>No</td></tr>", "<tr><td>GPS:</td><td>Yes</td></tr>")%>
  </table>
</div>