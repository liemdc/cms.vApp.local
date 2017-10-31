<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="TextContent">
<h1><%# Eval("JobName",true) %></h1>
<p>
<%# Eval("JobDescription") %>
</p>
</div>
<table class="TextContent">
<tr valign="top">
<td style="font-weight: bold;">
Location:
</td>
<td>
<%# Eval("JobLocation") %>
</td>
</tr>
<tr valign="top">
<td style="font-weight: bold;">
Compensation:
</td>
<td>
<%# Eval("JobCompensation") %>
</td>
</tr>
<tr valign="top">
<td style="font-weight: bold;">
Contact:
</td>
<td>
<%# Eval("JobContact") %>
</td>
</tr>
<tr valign="top">
<td style="font-weight: bold;">
Attachment:
</td>
<td>
<%#IfEmpty(Eval("JobAttachment"), "N/A", "<a href='" + GetFileUrl("JobAttachment") + "' >Download document</a>")%>
</td>
</tr>
</table>