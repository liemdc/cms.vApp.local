﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="LatestPosts">
  <div style="float:left;" class="Thread">
    <a href="<%# ForumFunctions.GetPostURL(Eval("PostIDPath"), Eval("PostForumID")) %>">
      <%# Eval("PostSubject", true) %>
    </a>
  </div>
  <div style="float:right;" class="PostCount"><%# Eval("PostThreadPosts") %></div>
  <div style="clear:both;"></div>
</div>