<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/VMMP.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="CMSTemplates_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" Runat="Server">
<div class="OverBox">
    <div class="loginMargin">
        <fieldset class="frmPassword">
            <legend>Đăng nhập</legend>
            <table class="ChangePasswordTable">
                <tr>
                    <td class="FieldLabel"><label for="txtEmail" id="lblEmail">Tên đăng nhập:</label></td>
                    <td class="FieldInput"><asp:TextBox ID="txtUser" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="FieldLabel"><label for="txtPass" id="lblPass">Mật khẩu:</label></td>
                    <td class="FieldInput"><asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="FieldLabel">&nbsp;</td>
                    <td><a href="~/Change-password" class="cp">Khôi phục mật khẩu</a></td>
                </tr>
                <tr>
                    <td class="FieldLabel">&nbsp;</td>
                    <td><asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" OnClick="btnDangNhap_Click" /></td>
                </tr>
            </table>
        </fieldset>
    </div>
</div>
</asp:Content>

