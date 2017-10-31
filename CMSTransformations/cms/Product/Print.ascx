<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><h1><%# Eval("ProductName", true) %></h1>
<div class="productDetail">
<div class="productImage">
<%# IfEmpty(Eval("SKUImagePath"),
  EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")),
  "<a href=\"" + ResolveUrl((Eval("SKUImagePath")).ToString()) + "\" target=\"_blank\">" + EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 200, Eval("SKUName")) + "</a>") %>
</div>
<div class="productDescription">
<h3>Product description</h3>
<div class="TextContent productDetailDescription">
<%# Eval("SKUDescription") %>
</div>
<div class="ourPrice">Our price: <span class="ProductPrice"><%# GetSKUFormattedPrice(true, false) %></span></div>
</div>
<div class="clear"></div>
</div>
