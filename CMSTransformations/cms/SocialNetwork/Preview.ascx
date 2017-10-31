<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table>
  <tr>
    <td>Tiêu đề:</td>
    <td><%# Eval("SocialNetworkTitlte") %></td>
  </tr>
  <tr>
    <td>Link mạng xã hội:</td>
    <td><%# Eval("SocialNetworkLink") %></td>
  </tr>
  <tr>
    <td>Hình icon:</td>
    <td><%# Eval("SocialNetworkIcon") %></td>
  </tr>
</table>
