<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><table style="background-color: #fff; border:solid 1px #000000;">
<tr>
<td style="font-size: 14pt; color: #184D6B;line-height:35px;background-color:#C4DBE7;"><%# HTMLEncode(ResHelper.LocalizeString(EcommerceFunctions.GetDocumentName(Eval("NodeParentID")))) %></td>
</tr>
<tr>
<td><img src="<%# GetAttachmentUrl(Eval("AttachmentName"), Eval("NodeAliasPath")) %>?maxsidesize=380"  alt="<%# Eval("AttachmentTitle", true) %>" title="<%# Eval("AttachmentTitle", true) %>" /></td>
</tr>
<tr style="font-size: 10px;line-height: 11px;"><td>
<%# Eval("AttachmentDescription", true) %>
</td>
</tr>
</table>



