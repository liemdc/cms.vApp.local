﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><entry>
  <title><%# EvalCDATA("PressReleaseTitle") %></title>
  <link href="<%# GetAbsoluteUrl(GetDocumentUrlForFeed(), Eval("SiteName")) %>"/>
  <id>urn:uuid:<%# Eval("NodeGUID") %></id>
  <published><%# GetAtomDateTime(Eval("PressReleaseDate")) %></published>
  <updated><%# GetAtomDateTime(Eval("DocumentModifiedWhen")) %></updated>
  <author>
    <name><%# Eval("NodeOwnerFullName") %></name>
  </author>
  <summary type="html"><%# EvalCDATA("PressReleaseSummary") %></summary>
</entry>