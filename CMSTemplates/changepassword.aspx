<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/VMMP.master" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="CMSTemplates_changepassword" %>

<%@ Register Src="~/CMSWebParts/Membership/Profile/ChangePassword.ascx" TagPrefix="uc1" TagName="ChangePassword" %>


<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" Runat="Server">
<div class="OverBox">
    <div class="loginMargin">
        <fieldset class="frmPassword">
            <legend>Khôi phục mật khẩu</legend>
            <table class="ChangePasswordTable">
                <tr>
                    <td class="FieldLabel"><label for="txtEmail" id="lblEmail">Email:</label></td>
                    <td class="FieldInput"><asp:TextBox ID="txtUser" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="FieldLabel">&nbsp;</td>
                    <td><asp:Button CssClass="btnfgPass" ID="btnKhoiPhuc" runat="server" Text="Khôi phục"/></td>
                </tr>
            </table>            
        </fieldset>
        <br />
        <fieldset class="frmPassword" runat="server" id="cpw">
            <legend>Thay đổi mật khẩu</legend>
            <uc1:ChangePassword runat="server" ID="ChangePassword" />
        </fieldset>
    </div>
</div>
</asp:Content>

