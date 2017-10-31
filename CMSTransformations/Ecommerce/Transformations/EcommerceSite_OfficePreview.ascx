<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="Map">
<span class="Header"><%# Eval("OfficeName",true) %></span>
  <table>
  <tr><td rowspan="2" style="vertical-alig: top;"><%# IfEmpty(Eval("OfficePhoto"), "", "<img src=\"" + GetFileUrl("OfficePhoto") + "?height=50\" alt=\"" + Eval("OfficeName") + "\" />") %></td></tr>
  <tr><td class="Address">
    <%# IfEmpty(Eval("OfficeAddress1"),"",Eval("OfficeAddress1",true) + "<br />") %>
    <%# IfEmpty(Eval("OfficeAddress2"),"",Eval("OfficeAddress2",true) + "<br />") %>
    <%# Eval("OfficeCity",true) %><br />
    <%# Eval("OfficeZIP",true) %><br />
    <%# Eval("OfficeState",true) %><br />
  </td></tr>
  </table>
</div>
