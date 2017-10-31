<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_Licenses_Pages_License_New"
    Theme="Default" MasterPageFile="~/CMSMasterPages/UI/SimplePage.master" Title="Licenses - New License"
    CodeFile="License_New.aspx.cs" %>

<asp:Content ContentPlaceHolderID="plcContent" runat="server">
    <asp:Label ID="lblInfo" runat="server" />
    <asp:Label runat="server" ID="lblError" ForeColor="red" EnableViewState="false" Visible="false" />
    <table>
        <tr>
            <td class="FieldLabel" style="vertical-align: top">
                <asp:Label ID="lblDomain" runat="server" EnableViewState="False" Text="License domain (for example: mydomain.com):" />
            </td>
            <td>
                <asp:TextBox ID="txtDomain" runat="server" TextMode="SingleLine" MaxLength="100"
                    Width="600" />
                <asp:RequiredFieldValidator ID="rfvLicenseKey" runat="server" EnableViewState="false"
                    ControlToValidate="txtDomain" Display="dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="FieldLabel" style="vertical-align: top">
                <asp:Label ID="lblEdition" runat="server" EnableViewState="False" Text="Select license edition:" />
            </td>
            <td>
                <asp:DropDownList ID="ddlEdition" runat="server" AutoPostBack="true" MaxLength="100"
                    Width="600" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <br />
                <asp:Button ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="ContentButton"
                    EnableViewState="false" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
            </td>
        </tr>
    </table>
</asp:Content>
