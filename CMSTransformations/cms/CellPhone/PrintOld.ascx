<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><h1 style="margin-top:15px"><%# Eval("CellName", true) %></h1>
<table cellspacing="0" cellpadding="0" class="productDetail">
<tr>
<td style="text-align:center; vertical-align:top;">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName"))%>
</td>
<td>
<table class="productDetailInfo" cellspacing="0" cellpadding="0">
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
<td>Display type:</td>
<td><%# Eval("CellDisplayType",true) %></td>
</tr>
<tr>
<td>Display width:</td>
<td><%# Eval("CellDisplayWidth") %></td>
</tr>
<tr class="alt">
<td>Display height:</td>
<td><%# Eval("CellDisplayHeight") %></td>
</tr>
<tr>
<td>Display resolution:</td>
<td><%# Eval("CellDisplayResolution") %></td>
</tr>
<tr class="alt">
<td>Bluetooth:</td>
<td><%# IfCompare(Eval("CellBluetooth"), false, "yes", "no") %></td>
</tr>
<tr>
<td>IrDA:</td>
<td><%# IfCompare(Eval("CellIrDA"), false, "yes", "no") %></td>
</tr>
<tr class="alt">
<td>GPRS:</td>
<td><%# IfCompare(Eval("CellGPRS"), false, "yes", "no") %></td>
</tr>
<tr>
<td>EDGE:</td>
<td><%# IfCompare(Eval("CellEDGE"), false, "yes", "no") %></td>
</tr>
<tr class="alt">
<td>HSCSD:</td>
<td><%# IfCompare(Eval("CellHSCSD"), false, "yes", "no") %></td>
</tr>
<tr>
<td>3G:</td>
<td><%# IfCompare(Eval("Cell3G"), false, "yes", "no") %></td>
</tr>
<tr class="alt">
<td>Wi-Fi:</td>
<td><%# IfCompare(Eval("CellWiFi"), false, "yes", "no") %></td>
</tr>
<tr>
<td>Java:</td>
<td><%# IfCompare(Eval("CellJava"), false, "yes", "no") %></td>
</tr>
<tr class="alt">
<td>Built-in camera:</td>
<td><%# IfCompare(Eval("CellCamera"), false, "yes", "no") %></td>
</tr>
<tr>
<td>MP3 player:</td>
<td><%# IfCompare(Eval("CellDisplayMP3"), false, "yes", "no") %></td>
</tr>
</table>
</td>
</tr>
<tr><td colspan="2">
<div class="productDetailLinks">
<br />
<br />
      <strong>Our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span></strong>
<br />
<br />
</div>
</td></tr>
<tr><td colspan="2">
  <h3>Description:</h3>
  <div>
    <%# Eval("SKUDescription") %>
  </div>
</td></tr>
</table>
