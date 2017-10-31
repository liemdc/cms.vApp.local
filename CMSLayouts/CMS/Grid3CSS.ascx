<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<div>
  <cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
</div>
<div style="width: 100%;">
  <div style="width: 33%; float: left;">
    <cc1:CMSWebPartZone ID="zoneTopLeft" runat="server" />      
  </div>
  <div style="width: 33%; float: right;">
    <cc1:CMSWebPartZone ID="zoneTopRight" runat="server" />      
  </div>
  <div style="width: 34%; float: left;">
    <cc1:CMSWebPartZone ID="zoneTopCenter" runat="server" />      
  </div>
</div>
<div style="clear: both">
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
<div style="clear: both">  
  <cc1:CMSWebPartZone ID="zoneBottom" runat="server" />      
</div>