<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/CMSWebPartLayouts/ShoppingCartMiniPreview---EcommerceSite.ascx.cs"
    Inherits="CMSWebParts_Ecommerce_ShoppingCart_ShoppingCartMiniPreviewWebPart_Web_Deployment" %>
<cms:cmsupdatepanel id="upnlAjax" runat="server">
    <ContentTemplate>
<table cellspacing="0">
    <tr>
        <td colspan="3" style="padding-right: 5px; height:38px; padding-left:15px;">
<asp:Literal runat="server" ID="ltlRTLFix" text="<%# rtlFix %>" EnableViewState="false"></asp:Literal> 
<asp:PlaceHolder ID="plcShoppingCart" runat="server" EnableViewState="false">
                <asp:HyperLink ID="lnkShoppingCart" runat="server" CssClass="ShoppingCartLink"></asp:HyperLink>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="plcMyAccount" runat="server" EnableViewState="false">|&nbsp;<asp:HyperLink ID="lnkMyAccount"
                runat="server" CssClass="ShoppingCartLink"></asp:HyperLink>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="plcMyWishlist" runat="server" EnableViewState="false">|&nbsp;<asp:HyperLink ID="lnkMyWishlist"
                runat="server" CssClass="ShoppingCartLink"></asp:HyperLink>
            </asp:PlaceHolder>
        </td>
    </tr>
    <asp:PlaceHolder ID="plcTotalPrice" runat="server" EnableViewState="false">
    <tr>
  <td align="left" style="padding-left:15px; width:22%;">
      <asp:Image ID="imgCartIcon" runat="server" CssClass="ShoppingCartIcon" />
  </td>
        <td align="left" style="font-weight:bold;">
            <asp:Label ID="lblTotalPriceTitle" runat="server" Text="" CssClass="SmallTextLabel"></asp:Label>
        </td>
        <td align="right" style="padding-right: 5px;font-weight:bold;">
            <asp:Label ID="lblTotalPriceValue" runat="server" Text="" CssClass="SmallTextLabel"></asp:Label>
        </td>
    </tr>
    </asp:PlaceHolder>
</table>
    </ContentTemplate>
</cms:cmsupdatepanel>