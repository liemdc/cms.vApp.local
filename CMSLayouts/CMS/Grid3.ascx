﻿<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
<div style="width: 100%">
<table border="0" width="100%">
  <tr valign="top">
    <td>
      <cc1:CMSWebPartZone ID="zoneTopLeft" runat="server" />      
    </td>
    <td>
      <cc1:CMSWebPartZone ID="zoneTopCenter" runat="server" />      
    </td>
    <td>
      <cc1:CMSWebPartZone ID="zoneTopRight" runat="server" />      
    </td>
  </tr>
  <tr valign="top">
    <td>
      <cc1:CMSWebPartZone ID="zoneBottomLeft" runat="server" />      
    </td>
    <td>
      <cc1:CMSWebPartZone ID="zoneBottomCenter" runat="server" />      
    </td>
    <td>
      <cc1:CMSWebPartZone ID="zoneBottomRight" runat="server" />      
    </td>
  </tr>
</table>
</div>
<cc1:CMSWebPartZone ID="zoneBottom" runat="server" />      