<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<div>
  <cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
</div>
<div>
  <div style="width: 33%; float: left;">
    <cc1:CMSWebPartZone ID="zoneLeft" runat="server" />      
  </div>
  <div style="width: 34%; float: left;">
    <div class="Content"><cc1:CMSWebPartZone ID="zoneCenter" runat="server" /></div>      
  </div>
  <div style="width: 33%; float: right;">
    <cc1:CMSWebPartZone ID="zoneRight" runat="server" />      
  </div>
</div>
<div style="clear: both">
  <cc1:CMSWebPartZone ID="zoneBottom" runat="server" />
</div>