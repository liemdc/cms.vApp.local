﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="blogRightList">
<a href="<%# GetDocumentUrl() %>" title="<%# Eval("BlogName") %>"><%# Eval("BlogName") %></a>
</div>