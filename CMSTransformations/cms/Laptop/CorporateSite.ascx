<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<script runat="server">
string GetOSName(object OSCodeName) {   
if (OSCodeName != null)
 {     
    string osCode = OSCodeName.ToString();
    switch (osCode) {       
      case "vista_homebasic": return "Windows Vista Home Basic";break;
      case "vista_homepremium": return "Windows Vista Home Premium"; break;
      case "vista_business": return "Windows Vista Business"; break;
      case "vista_ultimate": return "Windows Vista Ultimate"; break;
      case "xp_home": return "Windows XP Home"; break;
      case "xp_pro": return "Windows XP Professional"; break;
      case "linux": return "RedHat Linux"; break;
      case "macos": return "Mac OS"; break;
      case "none": return "None"; break;
    }
  }
  return (string)OSCodeName;
}
</script>

<h1><%# Eval("SKUName", true) %></h1>
<div class="productDetail">
<div class="productImage">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")) %>
</div>
<div class="productDescription">
<h3>Product parameters</h3>
<div class="parameters"><%# IfCompare(Eval("LaptopProcessorType"), "", Eval("LaptopProcessorType", true) + " processor,", "") %>
<%# Eval("LaptopDisplayType", true) %> display with resolution of <%# Eval("LaptopResolution", true) %>, <%# Eval("LaptopGraphicsCard", true) %> graphics card,
<%# IfCompare(Eval("LaptopMemorySize"), "", Eval("LaptopMemorySize", true), "") %> <%# IfCompare(Eval("LaptopMemoryType"), "", Eval("LaptopMemoryType", true), "") %>  RAM memory, <%# IfCompare(Eval("LaptopOpticalDrive"),"", Eval("LaptopOpticalDrive", true), "no optical drive") %>, <%# IfCompare(Eval("LaptopHardDrive"), "", Eval("LaptopHardDrive", true), "no hard drive") %><%# IfCompare(Eval("LaptopBluetooth"), false, ", Bluetooth", "") %><%# IfCompare(Eval("LaptopWirelessLAN"), false, ", WiFi", "") %><%# IfCompare(Eval("LaptopInfraport"), false, ", Infra port", "") %>, <%# IfCompare(Eval("LaptopBatteryType"), "", Eval("LaptopBatteryType", true)+" battery, ", "") %><%# GetOSName(Eval("LaptopOperatingSystem")) %> operating system<%# IfCompare(Eval("LaptopAccessories"),"", "," + Eval("LaptopAccessories", true), ".") %>
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
    <%# IfEmpty(Eval("LaptopProcessorType",true), "", "<tr><td>Processor type:</td><td>"+ Eval("LaptopProcessorType",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopDisplayType",true), "", "<tr><td>Display type:</td><td>"+ Eval("LaptopDisplayType",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopResolution",true), "", "<tr><td>Display resolution:</td><td>"+ Eval("LaptopResolution",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopGraphicsCard",true), "", "<tr><td>Graphics card:</td><td>"+ Eval("LaptopGraphicsCard",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopMemorySize",true), "", "<tr><td>Memory size:</td><td>"+ Eval("LaptopMemorySize",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopMemoryType",true), "", "<tr><td>Memory type:</td><td>"+ Eval("LaptopMemoryType",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopOpticalDrive",true), "", "<tr><td>Optical drive:</td><td>"+ Eval("LaptopOpticalDrive",true) +"</td></tr>")%>
    <%# IfEmpty(Eval("LaptopHardDrive",true), "", "<tr><td>Hard drive:</td><td>"+ Eval("LaptopHardDrive",true) +"</td></tr>")%>
    <%# IfCompare(Eval("LaptopBluetooth"),true, "<tr><td>Bluetooth:</td><td>No</td></tr>", "<tr><td>Bluetooth:</td><td>Yes</td></tr>")%>
    <%# IfCompare(Eval("LaptopWirelessLAN"),true, "<tr><td>WiFi:</td><td>No</td></tr>", "<tr><td>WiFi:</td><td>Yes</td></tr>")%>
    <%# IfCompare(Eval("LaptopInfraport"),true, "<tr><td>Infraport:</td><td>No</td></tr>", "<tr><td>Infraport:</td><td>Yes</td></tr>")%>
    <%# IfEmpty(Eval("LaptopBatteryType",true), "", "<tr><td>Battery type:</td><td>"+ Eval("LaptopBatteryType",true) +"</td></tr>")%>
    <tr><td>Operating system:</td><td><%# GetOSName(Eval("LaptopOperatingSystem")) %></td></tr>
    <%# IfEmpty(Eval("LaptopAccessories",true), "", "<tr><td>Accessories:</td><td>"+ Eval("LaptopAccessories",true) +"</td></tr>")%>
  </table>
</div>
