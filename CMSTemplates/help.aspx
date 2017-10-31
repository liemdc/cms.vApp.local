<%@ Page Language="C#" AutoEventWireup="true" CodeFile="help.aspx.cs" Inherits="CMSTemplates_help" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trợ giúp</title>
    <style type="text/css">
        .btnSend{float:right;margin-top:5px}
        .txtTitle{margin-bottom:5px}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxTextBox runat="server" ID="txtTitle" Border-BorderColor="#d3d3d3" Height="20px" Width="100%" NullText="Tiêu đề" CssClass="txtTitle">
            <ValidationSettings SetFocusOnError="true" ErrorText="">
                <RequiredField IsRequired="True" ErrorText=""/>
            </ValidationSettings>
        </dx:ASPxTextBox>
        <cms:CMSHtmlEditor ID="editor" runat="server" IsLiveSite="true" Toolbar="Basic" DefaultLanguage="vi" Skin="kama" />
        <dx:ASPxButton ID="btnImageAndText" runat="server" Text="Gửi" AutoPostBack="false" Image-Url="../App_Themes/VMMP/images/mail_send.png" Border-BorderColor="#d3d3d3" CssClass="btnSend" OnClick="btnImageAndText_Click"/>
    </form>
</body>
</html>
