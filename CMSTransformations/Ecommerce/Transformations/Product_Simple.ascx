<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><h1><%# Eval("PDAName",true) %></h1>
<table cellspacing="0" cellpadding="0" class="productDetail">
<tr>
<td style="text-align:center; vertical-align:top;">
<a href="<%# Eval("SKUImagePath") %>" target="_blank">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName"))%>
</a>
</td>
<td>
<table class="productDetailInfo" cellspacing="0" cellpadding="0">
<tr>
<td class="caption"><h3>Parameters:</h3></td>
<td>&nbsp;</td>
</tr>
<tr class="alt">
<td>Battery:</td>
<td><%# Eval("PDABattery",true) %></td>
</tr>
<tr>
<td>Display type:</td>
<td><%# Eval("PDADisplayType",true) %></td>
</tr>
<tr class="alt">
<td>Resolution:</td>
<td><%# Eval("PDAResolution",true) %></td>
</tr>
<tr>
<td>RAM (MB):</td>
<td><%# Eval("PDARam",true) %></td>
</tr>
<tr class="alt">
<td>Processor (MHz):</td>
<td><%# Eval("PDAProcessor",true) %></td>
</tr>
<tr>
<td>Operating system:</td>
<td><%# Eval("PDAOperatingSystem",true) %></td>
</tr>
</table>
</td>
</tr>
</table>