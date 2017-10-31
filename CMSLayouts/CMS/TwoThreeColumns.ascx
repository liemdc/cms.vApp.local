<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<table border="0" width="100%">
  <tr valign="top">
    <td width="50%">
      <cc1:CMSWebPartZone ID="zoneLeft" runat="server" />      
    </td>
    <td width="50%">
      <cc1:CMSWebPartZone ID="zoneRight" runat="server" />      
    </td>
  </tr>
</table>
<table border="0" width="100%">
  <tr valign="top">
    <td width="33%">
      <cc1:CMSWebPartZone ID="zoneBottomLeft" runat="server" />      
    </td>
    <td width="33%">
      <cc1:CMSWebPartZone ID="zoneBottomCenter" runat="server" />      
    </td>
    <td width="33%">
      <cc1:CMSWebPartZone ID="zoneBottomRight" runat="server" />      
    </td>
  </tr>
</table>