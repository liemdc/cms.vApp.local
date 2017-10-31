<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><url>
<loc><%# GetAbsoluteUrl(GetDocumentUrl()) %></loc>
<lastmod><%# GetDateTime("DocumentModifiedWhen", "yyyy-MM-dd") %></lastmod>
</url>