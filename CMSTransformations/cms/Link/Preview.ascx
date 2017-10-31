<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table>
  <tr>
    <td>Tiêu đề:</td>
    <td><%# Eval("LinkTitle") %></td>
  </tr>
  <tr>
    <td>Link:</td>
    <td><%# Eval("LinkURL") %></td>
  </tr>
</table>
