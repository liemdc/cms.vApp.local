<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table class="OfficeDetail" >
<tr>
<td rowspan="2" style="vertical-align: top;width:110px"><%# IfEmpty(Eval("OfficePhoto"), "", "<img src=\"" + GetFileUrl("OfficePhoto") + "?height=90\" alt=\"" + Eval("OfficeName", true) + "\" />") %>
</td>
<td style="vertical-align: top;width:210px">
<h3><%# Eval("OfficeName", true) %></h3>
</td>
</tr>
<tr valign="top">
<td class="Address">
<%# IfEmpty(Eval("OfficeCompanyName"),"",Eval("OfficeCompanyName", true) + "<br />") %>
<%# IfEmpty(Eval("OfficeAddress1"),"",Eval("OfficeAddress1", true) + "<br />") %>
<%# IfEmpty(Eval("OfficeAddress2"),"",Eval("OfficeAddress2", true) + "<br />") %>
<%# Eval("OfficeCity", true) %>, <%# Eval("OfficeState", true) %> <%# Eval("OfficeZIP", true) %><br />
<%# IfEmpty(Eval("OfficeCountry"),"",Eval("OfficeCountry", true) + "<br />") %>
</td>
</tr>
<tr>
<td>
<strong>Phone:</strong>
</td>
<td>
<%# Eval("OfficePhone", true) %>
</td>
</tr>
<tr>
<td>
<strong>E-mail:</strong>
</td>
<td>
<a href="mailto:<%# Eval("OfficeEmail") %>"><%# Eval("OfficeEmail", true) %></a>
</td>
</tr>
</table>
<%# IfEmpty(Eval("OfficeDirections"),"",Eval("OfficeDirections") + "<br />") %>
<%# IfEmpty(Eval("OfficeDescription"),"",Eval("OfficeDescription") + "<br />") %>
