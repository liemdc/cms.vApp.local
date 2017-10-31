<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div style="background-color: #dddddd; border:solid 1px #000000; padding-bottom: 100px;">
<div style="margin-top: 25px; font-size: 14pt; color: #184D6B;">
<%# HTMLEncode(ResHelper.LocalizeString(Convert.ToString(Eval("SKUName")))) %>
</div>
<div style="margin-top: 20px;font-size: 14pt; color: #333333;">
<%# EcommerceFunctions.GetProductImage(Eval("SKUImagePath"), 380, Eval("SKUName"))%>
</div>
</div>