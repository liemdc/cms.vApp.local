<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %>  <div style="font-weight:bold; padding-top: 3px; padding-bottom: 3px;">
    <span style="color:black"><%# HTMLHelper.HTMLEncode(Convert.ToString(Eval("MenuItemName"))) %>
    </span>
  </div>
