<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register Src="~/CMSModules/Ecommerce/Controls/ProductOptions/ShoppingCartItemSelector.ascx" TagName="CartItemSelector" TagPrefix="uc1" %>
<script runat="server">
string GetOSName(object OSCodeName) {   
  if (OSCodeName != null) {     
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
<h1 style="margin-top:15px"><%# Eval("LaptopName", true) %></h1>
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
<td>Processor type:</td>
<td><%# Eval("LaptopProcessorType",true) %></td>
</tr>
<tr>
<td>Display type:</td>
<td><%# Eval("LaptopDisplayType",true) %></td>
</tr>
<tr class="alt">
<td>Resolution:</td>
<td><%# Eval("LaptopResolution",true) %></td>
</tr>
<tr>
<td>Graphics card:</td>
<td><%# Eval("LaptopGraphicsCard",true) %></td>
</tr>
<tr class="alt">
<td>Memory type:</td>
<td><%# Eval("LaptopMemoryType",true) %></td>
</tr>
<tr>
<td>Memory size:</td>
<td><%# Eval("LaptopMemorySize",true) %></td>
</tr>
<tr class="alt">
<td>Optical drive:</td>
<td><%# Eval("LaptopOpticalDrive",true) %></td>
</tr>
<tr>
<td>Hard Drive:</td>
<td><%# Eval("LaptopHardDrive",true) %></td>
</tr>
<tr class="alt">
<td>Wireless LAN:</td>
<td><%# IfCompare(Eval("LaptopWirelessLAN"), false, "yes", "no") %></td>
</tr>
<tr>
<td>Bluetooth:</td>
<td><%# IfCompare(Eval("LaptopBluetooth"), false, "yes", "no") %></td>
</tr>
<tr class="alt">
<td>Infraport:</td>
<td><%# IfCompare(Eval("LaptopInfraport"), false, "yes", "no") %></td>
</tr>
<tr>
<td>Battery type:</td>
<td><%# Eval("LaptopBatteryType",true) %></td>
</tr>
<tr class="alt">
<td>Operating system:</td>
<td><%# GetOSName(Eval("LaptopOperatingSystem")) %></td>
</tr>
<tr>
<td>Accessories:</td>
<td><%# Eval("LaptopAccessories", true) %></td>
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