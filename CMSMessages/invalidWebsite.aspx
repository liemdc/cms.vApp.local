<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSMessages_invalidWebsite"
    Theme="Default" CodeFile="invalidWebsite.aspx.cs" %>

<%@ Register Src="~/CMSAdminControls/UI/PageElements/PageTitle.ascx" TagName="PageTitle"
    TagPrefix="cms" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server" enableviewstate="false">
    <title></title>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            height: 100%;
        }
    </style>
</head>
<body class="<%=mBodyClass%>">
    <form id="form1" runat="server">
    <div style="font-weight: bold; text-align: center; padding: 20px; color: Red; font-size: 14px">
        <p>Website của bạn đang ở trạng thái offline.</p>
        <p>**************************************************</p>
        <p>Công Ty TNHH Ứng Dụng Tin Học Việt Trí</p>
        <p>Địa Chỉ: 32/16 Tân Thới Nhất 02, Q.12, TP.Hồ Chí Minh</p>
        <p>ĐT:(84.8)3883 1454 - Fax:(84.8)3883 1454</p>
    </div>
    </form>
</body>
</html>
