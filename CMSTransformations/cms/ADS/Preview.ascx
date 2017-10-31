<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table>
  <tr>
    <td>Tiêu đề:</td>
    <td><%# Eval("ADSTitle") %></td>
  </tr>
  <tr>
    <td>Chọn type:</td>
    <td><%# Eval("ADSKind") %></td>
  </tr>
  <tr>
    <td>Link liên kết:</td>
    <td><%# Eval("ADSLink") %></td>
  </tr>
  <tr>
    <td>File:</td>
    <td><%# Eval("ADSFile") %></td>
  </tr>
</table>
