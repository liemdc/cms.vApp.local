<%@ Control Language="C#" AutoEventWireup="true"
    Inherits="CMSWebParts_Membership_FacebookConnect_FacebookConnectLogon" CodeFile="~/CMSWebParts/Membership/FacebookConnect/FacebookConnectLogon.ascx.cs" %>

<asp:Label ID="lblError" runat="server" CssClass="ErrorLabel" Visible="false" EnableViewState="false" />
<asp:Literal ID="ltlScript" runat="server" EnableViewState="false" />
<asp:PlaceHolder ID="plcFBButton" runat="server">
    <fb:login-button <%=LatestVersionAttribute%> size="<%=Size%>" length="<%=Length%>"
        onlogin="Facebook_login();" autologoutlink="false"><%=SignInText%></fb:login-button>
</asp:PlaceHolder>
<cms:CMSButton ID="btnSignOut" runat="server" Visible="false" EnableViewState="false" />
<asp:HyperLink ID="lnkSignOutImageBtn" runat="server" Visible="false" EnableViewState="false">
    <asp:Image ID="imgSignOut" runat="server" Visible="false" EnableViewState="false" />
</asp:HyperLink>
<asp:HyperLink ID="lnkSignOutLink" runat="server" Visible="false" EnableViewState="false" />