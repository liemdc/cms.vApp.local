<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="NewsLatest">
  <div class="NewsTitle">
    <%# Eval("Title") %>
  </div>
  <hr size="1" />
  <div class="NewsSummary">
    <%# Eval("Description") %>
  </div>
  <a href="<%# Eval("Link") %>" class="LinkMore">more</a>
</div>
