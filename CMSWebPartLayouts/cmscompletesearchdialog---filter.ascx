<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/CMSWebPartLayouts/cmscompletesearchdialog---filter.ascx.cs" Inherits="CMSWebParts_Search_cmscompletesearchdialog_Web_Deployment" %>
<div class="SearchDialog">
    <cms:CMSSearchDialog ID="srchDialog" runat="server" />
</div>
<div class="SearchResults">
    <cms:CMSSearchResults ID="srchResults" runat="server" FilterName="SearchDialog" />
</div>