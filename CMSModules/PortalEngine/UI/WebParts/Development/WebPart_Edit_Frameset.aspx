<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_PortalEngine_UI_WebParts_Development_WebPart_Edit_Frameset"
    CodeFile="WebPart_Edit_Frameset.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" enableviewstate="false">
    <title>Development - Web parts</title>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            height: 100%;
        }
    </style>
</head>
<frameset border="0" rows="<%= TabsBreadFrameHeight %>, *" framespacing="0" id="rowsFrameset">
    <frame name="webparteditheader" src="WebPart_Edit_Header.aspx?webpartid=<%=QueryHelper.GetInteger("webpartid", 0)%> "
        scrolling="no" frameborder="0" noresize="noresize" />
    <frame name="webparteditcontent" src="WebPart_Edit_General.aspx?webpartid=<%=QueryHelper.GetInteger("webpartid", 0)%> "
        frameborder="0" />
    <cms:NoFramesLiteral ID="ltlNoFrames" runat="server" />
</frameset>
</html>
