<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/VMMP.master" AutoEventWireup="true" CodeFile="desk.aspx.cs" Inherits="CMSTemplates_desk" %>
<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="plcMain" Runat="Server">
<script type="text/javascript">  
    var command;
    var isCallbackError = false;
    var commandx;
    function BeginCall(s, e) {
        if (e.command != "NEXTPAGE") {
            commandx = e.command;
        }
    }
    function EndCall(s, e) {
        if (commandx != "REFRESH") {
            s.Refresh();
        }
    }
    function OnControlsInitialized(s, e) {
        //ASPxClientUtils.AttachEventToElement(window, "resize", function (evt) {
        //    ReSizeControl(s);
        //});
    }
    function OnInit(s, e) {
        s.SetWidth($(window).width() - 12);
        s.SetHeight($(window).height() - 142);
    }
    function OnInitAll(s, e) {
        s.SetWidth($(window).width() - 12);
        s.SetHeight($(window).height() - 111);
    }
    function OnBeginCallback(s, e) {
        if (e.command != "NEXTPAGE") {
            command = e.command;
        }
    }
    function OnEndCallback(s, e) {
        if (isCallbackError == false) {
            if (command === "UPDATEEDIT" || command === "DELETEROW" || command === "CANCELEDIT") {
                if (command != "REFRESH") {
                    //s.Refresh();
                }
            }
        } else {
            isCallbackError = false;
        }
    }
    function OnCallbackError(s, e) {
        isCallbackError = true;
    }
</script>
<dx:ASPxSplitter ID="SMain" runat="server" FullscreenMode="True" Width="100%" Height="100%" Orientation="Vertical">
    <Panes>
        <dx:SplitterPane Size="20px" AllowResize="False" PaneStyle-BorderRight-BorderWidth="0px" PaneStyle-BorderLeft-BorderWidth="0px" PaneStyle-Paddings-PaddingTop="3px" PaneStyle-BackColor="White">
            <ContentCollection>
                <dx:SplitterContentControl ID="SCCMenu" runat="server">
                    <div style="float:left">
                        <dx:ASPxMenu ID="NBMenuLeft" runat="server" AllowSelectItem="true" EnableAnimation="true" EnableViewState="false" CssClass="linkMenu">
                            <ItemStyle HoverStyle-Border-BorderColor="White" SelectedStyle-Border-BorderColor="White"/>
                            <SubMenuStyle Border-BorderWidth="0px"/>
                            <SubMenuItemStyle Border-BorderWidth="0px" />
                            <ClientSideEvents ItemClick="function(s, e) { SelectedItemChanged(e); }" />
                        </dx:ASPxMenu>
                    </div>
                    <div style="float:right">
                        <dx:ASPxMenu ID="NBMenuRight" runat="server" AllowSelectItem="true" EnableAnimation="true" CssClass="linkMenu">
                            <ItemStyle HoverStyle-Border-BorderColor="White" SelectedStyle-Border-BorderColor="White"/>
                            <ClientSideEvents ItemClick="function(s, e) { SelectedItemChanged(e); }" />
                        </dx:ASPxMenu>
                    </div>
                </dx:SplitterContentControl>
            </ContentCollection>
        </dx:SplitterPane>

        <dx:SplitterPane AllowResize="False" PaneStyle-Paddings-Padding="0px" AutoWidth="true" PaneStyle-BorderRight-BorderWidth="0px" PaneStyle-BorderLeft-BorderWidth="0px" PaneStyle-BorderBottom-BorderWidth="0px">
            <Panes>
                <dx:SplitterPane PaneStyle-BackColor="White" AutoWidth="true" Name="SplMain">
                    <ContentCollection>
                        <dx:SplitterContentControl ID="SCCMain" runat="server">
                            <dx:ASPxCallbackPanel LoadingPanelText="Đang tải..." ID="CallbackPanel" runat="server" CssClass="mainaa" ClientInstanceName="callbackPanel" OnCallback="CallbackHandler">
                                <PanelCollection>
                                    <dx:PanelContent>
                                        <dx:ASPxPageControl ID="PageControl" runat="server" EnableViewState="false" TabAlign="Justify" EnableTabScrolling="true" Width="100%" LoadingPanelText="Đang tải..."
                                            ContentStyle-BorderLeft-BorderStyle="None" ContentStyle-BorderRight-BorderStyle="None" ContentStyle-Paddings-Padding="6px"
                                            TabStyle-BorderBottom-BorderStyle="None" TabSpacing="2px" BackColor="White" ContentStyle-BorderBottom-BorderWidth="0px">
                                            <TabTemplate>
                                                <div class="tab">
                                                    <div class="title"><%# Container.TabPage.Text %></div>
                                                    <div class="close">
                                                        <a onclick="RemoveTab(<%# Container.TabPage.Index %>); return ASPxClientUtils.PreventEventAndBubble(event);">
                                                            <img src="../App_Themes/VMMP/images/icon-close.png" />
                                                        </a>
                                                    </div>
                                                </div>
                                            </TabTemplate>
                                        </dx:ASPxPageControl>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
            </Panes>
        </dx:SplitterPane>

        <dx:SplitterPane Size="24px" MaxSize="24px" AllowResize="False" AutoHeight="false" Separator-Size="1px" Separator-Image-Height="1px">
            <PaneStyle BackColor="#FFFFFF" Paddings-PaddingBottom="0px" Paddings-PaddingLeft="8px" Paddings-PaddingRight="0px" Paddings-PaddingTop="0px" Border-BorderWidth="0" BorderTop-BorderWidth="1px" />
            <ContentCollection>
                <dx:SplitterContentControl runat="server">
                    <asp:Label CssClass="copytext" runat="server"><span style="float:left">Hỗ trợ từ xa: <a target="_blank" href="http://get.teamviewer.com/x3tvcza">Bấm vào đây</a> để tải về</span>Vina Mold & Metal Products Copyright © 2015 Viet Tri.</asp:Label>
                </dx:SplitterContentControl>
            </ContentCollection>
        </dx:SplitterPane>

    </Panes>
</dx:ASPxSplitter>
<dx:ASPxGlobalEvents ID="ASPxGEvent" runat="server">
    <ClientSideEvents ControlsInitialized="OnControlsInitialized" />
</dx:ASPxGlobalEvents>
</asp:Content>

