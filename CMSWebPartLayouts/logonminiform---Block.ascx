<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/CMSWebPartLayouts/logonminiform---Block.ascx.cs"
    Inherits="CMSWebParts_Membership_Logon_LogonMiniForm_Web_Deployment" %>
<asp:Login ID="loginElem" runat="server" DestinationPageUrl="~/Default.aspx" EnableViewState="false">
    <LayoutTemplate>
        <asp:Panel ID="pnlLogonMiniForm" runat="server" DefaultButton="btnLogon" EnableViewState="false">
            <cms:LocalizedLabel ID="lblUserName" runat="server" AssociatedControlID="UserName" EnableViewState="false" />
            <asp:TextBox ID="UserName" runat="server" CssClass="LogonField" EnableViewState="false" />
            <asp:RequiredFieldValidator ID="rfvUserNameRequired" runat="server" ControlToValidate="UserName"
                ValidationGroup="Login1" Display="Dynamic" EnableViewState="false">*</asp:RequiredFieldValidator>
            <cms:LocalizedLabel ID="lblPassword" runat="server" AssociatedControlID="Password" EnableViewState="false" />
            <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="LogonField" EnableViewState="false" />
            <cms:LocalizedButton ID="btnLogon" ResourceString="LogonForm.LogOnButton" runat="server" CommandName="Login" ValidationGroup="Login1" EnableViewState="false" />
            <asp:ImageButton ID="btnImageLogon" runat="server" Visible="false" CommandName="Login"
                ValidationGroup="Login1" EnableViewState="false" /><br />
            <asp:Label ID="FailureText" CssClass="ErrorLabel" runat="server" EnableViewState="false" />
        </asp:Panel>
    </LayoutTemplate>
</asp:Login>