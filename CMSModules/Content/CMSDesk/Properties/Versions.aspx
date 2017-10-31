<%@ Page Language="C#" AutoEventWireup="true" Inherits="CMSModules_Content_CMSDesk_Properties_Versions"
    Theme="Default" CodeFile="Versions.aspx.cs" %>

<%@ Register Src="~/CMSAdminControls/UI/UniGrid/UniGrid.ascx" TagName="UniGrid" TagPrefix="cms" %>
<%@ Register Src="~/CMSAdminControls/UI/PageElements/Help.ascx" TagName="Help" TagPrefix="cms" %>
<%@ Register Src="~/CMSModules/Content/Controls/VersionList.ascx" TagName="VersionList"
    TagPrefix="cms" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" enableviewstate="false">
    <title>Properties - Versions</title>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            height: 100%;
        }
    </style>

    <script type="text/javascript">
        //<![CDATA[
        function RefreshTree(expandNodeId, selectNodeId) {
            // Update tree
            parent.RefreshTree(expandNodeId, selectNodeId);
        }
        //]]>
    </script>

</head>
<body class="VerticalTabsBody <%=mBodyClass%>">
    <form id="form1" runat="server">
    <asp:PlaceHolder runat="server" ID="plcManager"></asp:PlaceHolder>
    <asp:Panel runat="server" ID="pnlBody" CssClass="VerticalTabsPageBody">
        <asp:Panel ID="pnlMenu" runat="server" CssClass="ContentEditMenu">
            <table width="100%">
                <tr>
                    <td>
                        <div style="height: 24px; padding: 5px;">
                        </div>
                    </td>
                    <td class="TextRight">
                        <cms:help id="helpElem" runat="server" topicname="versions" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlContent" runat="server" CssClass="PageContent">
            <asp:Label runat="server" ID="lblError" CssClass="ErrorLabel" EnableViewState="false" />
            <asp:Label runat="server" ID="lblApprove" Visible="false" EnableViewState="false" />
            <asp:Label runat="server" ID="lblInfo" CssClass="InfoLabel" EnableViewState="false" />
            <asp:Panel runat="server" ID="pnlVersions">
                <div style="width: 100%">
                    <table width="100%">
                        <asp:PlaceHolder ID="plcForm" runat="server">
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblCheckInfo" runat="server" Font-Bold="true" EnableViewState="false" />
                                    <asp:Panel runat="server" ID="pnlForm">
                                        <table>
                                            <tr>
                                                <td style="vertical-align: top;">
                                                    <cms:localizedlabel id="lblVersion" runat="server" resourcestring="VersionsProperties.Version" />
                                                </td>
                                                <td>
                                                    <cms:cmstextbox id="txtVersion" runat="server" cssclass="TextBoxField" maxlength="50" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top;">
                                                    <cms:localizedlabel id="lblComment" runat="server" resourcestring="VersionsProperties.Comment"
                                                        enableviewstate="false" />
                                                </td>
                                                <td>
                                                    <cms:cmstextbox id="txtComment" runat="server" textmode="MultiLine" cssclass="TextAreaField" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <cms:localizedbutton id="btnCheckout" runat="server" cssclass="SubmitButton" visible="false"
                                                        onclick="btnCheckout_Click" resourcestring="VersionsProperties.btnCheckout" enableviewstate="false" />
                                                    <cms:localizedbutton id="btnCheckin" runat="server" cssclass="SubmitButton" visible="false"
                                                        onclick="btnCheckin_Click" resourcestring="VersionsProperties.btnCheckin" enableviewstate="false" />
                                                    <cms:localizedbutton id="btnUndoCheckout" runat="server" visible="false" onclick="btnUndoCheckout_Click"
                                                        resourcestring="VersionsProperties.btnUndoCheckout" cssclass="LongSubmitButton"
                                                        enableviewstate="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                </td>
                            </tr>
                        </asp:PlaceHolder>
                        <tr>
                            <td colspan="2">
                                <cms:versionlist id="versionsElem" runat="server" islivesite="false" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
    </form>
</body>
</html>
