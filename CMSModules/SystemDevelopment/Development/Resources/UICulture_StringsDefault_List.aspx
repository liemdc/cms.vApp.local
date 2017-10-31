<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Inherits="CMSModules_SystemDevelopment_Development_Resources_UICulture_StringsDefault_List"
    Theme="Default" Title="Strings - Strings List" CodeFile="UICulture_StringsDefault_List.aspx.cs" %>
<%@ Register src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" tagname="UniGrid" tagprefix="cms" %>

<asp:Content ID="controls" runat="server" ContentPlaceHolderID="plcBeforeContent">
    <asp:Panel ID="pnlSites" runat="server" CssClass="PageHeaderLine">
        <asp:Label ID="lblAvailableCultures" runat="server" CssClass="FieldLabel" />
        <asp:DropDownList ID="ddlAvailableCultures" runat="server" Visible="true" AutoPostBack="true"
            CssClass="DropDownField">
        </asp:DropDownList>
    </asp:Panel>
</asp:Content>
<asp:Content ContentPlaceHolderID="plcContent" ID="content" runat="server">
    <asp:Label ID="lblInfo" runat="server" Visible="false" />
    <cms:UniGrid ID="UniGridStrings" runat="server" Visible="True" IsLiveSite="false" />
</asp:Content>
