<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<div style="width: 100%;">
  <div style="width: 50%; float: left;">
    <cc1:CMSWebPartZone ID="zoneLeft" runat="server" />      
  </div>
  <div style="width: 50%; float: right;">
    <cc1:CMSWebPartZone ID="zoneRight" runat="server" />      
  </div>
</div>
<div style="width: 100%; clear: both;">
  <div style="width: 33%; float: left;">
    <cc1:CMSWebPartZone ID="zoneBottomLeft" runat="server" />      
  </div>
  <div style="width: 33%; float: right;">
    <cc1:CMSWebPartZone ID="zoneBottomRight" runat="server" />      
  </div>
  <div style="width: 34%; float: left;">
    <cc1:CMSWebPartZone ID="zoneBottomCenter" runat="server" />      
  </div>
</div>
<div style="clear: both"></div>