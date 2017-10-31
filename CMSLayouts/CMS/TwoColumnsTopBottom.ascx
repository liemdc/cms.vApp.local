<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<div style="width: 100%">
<table border="0" width="100%">
  <tr>
    <td colspan="2">
      <cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
    </td>
  </tr>
  <tr valign="top">
    <td>
      <cc1:CMSWebPartZone ID="zoneLeft" runat="server" />      
    </td>
    <td>
      <cc1:CMSWebPartZone ID="zoneRight" runat="server" />      
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <cc1:CMSWebPartZone ID="zoneBottom" runat="server" />      
    </td>
  </tr>
</table>
</div>