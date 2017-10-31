<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table>
  <tr>
    <td>Công ty:</td>
    <td><%# Eval("ConfigName") %></td>
  </tr>
  <tr>
    <td>Địa chỉ:</td>
    <td><%# Eval("ConfigAdress") %></td>
  </tr>
  <tr>
    <td>Điện thoại:</td>
    <td><%# Eval("ConfigPhone") %></td>
  </tr>
  <tr>
    <td>Số fax:</td>
    <td><%# Eval("ConfigFax") %></td>
  </tr>
  <tr>
    <td>Email:</td>
    <td><%# Eval("Email") %></td>
  </tr>
  <tr>
    <td>Website:</td>
    <td><%# Eval("ConfigURL") %></td>
  </tr>
</table>
