<%@ Control Language="C#" AutoEventWireup="true" Inherits="CMSModules_SmartSearch_Controls_SearchResults"
    CodeFile="SearchResults.ascx.cs" %>
<asp:PlaceHolder runat="server" ID="plcBasicRepeater"></asp:PlaceHolder>
<cms:UniPager runat="server" ID="pgrSearch" PageControl="repSearchResults">
    <PageNumbersTemplate>
        <a href="<%# Eval("PageURL") %>">
            <%# Eval("Page") %></a>
    </PageNumbersTemplate>
    <CurrentPageTemplate>
        <strong>
            <%# Eval("Page") %></strong>
    </CurrentPageTemplate>
    <PageNumbersSeparatorTemplate>
        &nbsp;-&nbsp;
    </PageNumbersSeparatorTemplate>
    <FirstPageTemplate>
        <a href="<%# Eval("FirstURL") %>">|&lt;</a>
    </FirstPageTemplate>
    <LastPageTemplate>
        <a href="<%# Eval("LastURL") %>">&gt;|</a>
    </LastPageTemplate>
    <PreviousPageTemplate>
        <a href="<%# Eval("PreviousURL") %>">&lt;</a>
    </PreviousPageTemplate>
    <NextPageTemplate>
        <a href="<%# Eval("NextURL") %>">&gt;</a>
    </NextPageTemplate>
    <PreviousGroupTemplate>
        <a href="<%# Eval("PreviousGroupURL") %>">...</a>
    </PreviousGroupTemplate>
    <NextGroupTemplate>
        <a href="<%# Eval("NextGroupURL") %>">...</a>
    </NextGroupTemplate>
    <DirectPageTemplate>
        Page
        <asp:TextBox ID="DirectPageControl" runat="server" Style="width: 25px;" />
        of
        <%# Eval("Pages") %>
    </DirectPageTemplate>
    <LayoutTemplate>
        <asp:PlaceHolder runat="server" ID="plcFirstPage"></asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcPreviousPage"></asp:PlaceHolder>
        &nbsp;
        <asp:PlaceHolder runat="server" ID="plcPreviousGroup"></asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcPageNumbers"></asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcNextGroup"></asp:PlaceHolder>
        &nbsp;
        <asp:PlaceHolder runat="server" ID="plcNextPage"></asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="plcLastPage"></asp:PlaceHolder>
        <br />
        <asp:PlaceHolder runat="server" ID="plcDirectPage"></asp:PlaceHolder>
    </LayoutTemplate>
</cms:UniPager>
<cms:LocalizedLabel runat="server" ID="lblNoResults" CssClass="ContentLabel" Visible="false"
    EnableViewState="false" />