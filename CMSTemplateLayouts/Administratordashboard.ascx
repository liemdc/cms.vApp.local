<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3">
      <cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
    </td>
  </tr>
  <tr>
    <td colspan="3">
      <cc1:CMSWebPartZone ID="DashboardTop" runat="server" />      
    </td>
  </tr>
  <tr valign="top">
    <td style="width:33%">
      <cc1:CMSWebPartZone ID="zoneLeft" runat="server" />      
    </td>
    <td style="width:33%">
      <cc1:CMSWebPartZone ID="zoneCenter" runat="server" />      
    </td>
    <td style="width:33%">
      <cc1:CMSWebPartZone ID="zoneRight" runat="server" />      
    </td>
  </tr>
   <tr>
    <td colspan="3">
      <cc1:CMSWebPartZone ID="DashBoardBottom" runat="server" />      
    </td>
  </tr>
</table>
