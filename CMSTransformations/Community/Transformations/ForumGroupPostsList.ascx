<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMS.Controls.CMSAbstractTransformation" %><%@ Register TagPrefix="cms" Namespace="CMS.Controls" Assembly="CMS.Controls" %><%@ Register TagPrefix="cc1" Namespace="CMS.Controls" Assembly="CMS.Controls" %><div class="blogsHome">
<h4>
<a href="<%# ForumFunctions.GetPostURL("/Groups/{%CommunityContext.CurrentGroup.GroupName%}/Forums",Eval("PostIDPath"), Eval("PostForumID")) %>"><%# Eval("PostSubject",true) %></a>
</h4>
<div>
<%# StripTags(LimitLength(RemoveDynamicControls(RemoveDiscussionMacros(Eval("PostText"))), 300, "...")) %>
</div>
<div class="date">Posted on <strong><%# Eval("PostTime") %></strong></div>
</div>