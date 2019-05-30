<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DevNext.aspx.cs" Inherits="CMSTemplates_DevNext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Literal ID="txtOut" runat="server"></asp:Literal>
        <asp:Button ID="btnUpdate" runat="server" Text="Tạo mã mới" OnClick="btnUpdate_Click" />
    </form>
</body>
</html>
