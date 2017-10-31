<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table>
  <tr>
    <td>Tiêu đề:</td>
    <td><%# Eval("SupportTitle") %></td>
  </tr>
  <tr>
    <td>Nick yahoo:</td>
    <td><%# Eval("SupportYahoo") %></td>
  </tr>
  <tr>
    <td>Nick skype:</td>
    <td><%# Eval("SupportSkype") %></td>
  </tr>
  <tr>
    <td>Điện thoại:</td>
    <td><%# Eval("SupportPhone") %></td>
  </tr>
</table>
