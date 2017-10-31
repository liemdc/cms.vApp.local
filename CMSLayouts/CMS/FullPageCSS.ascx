<%@ Control Language="C#" ClassName="Simple" Inherits="CMS.PortalControls.CMSAbstractLayout" %> 
<%@ Register Assembly="CMS.PortalControls" Namespace="CMS.PortalControls" TagPrefix="cc1" %> 
<%@ Register Assembly="CMS.Controls" Namespace="CMS.Controls" TagPrefix="cc1" %> 
<div>
  <cc1:CMSWebPartZone ID="zoneTop" runat="server" />      
</div>
<div style="width: 100%;">
    <cc1:CMSWebPartZone ID="zoneCenter" runat="server" />      
</div>
<div>
  <cc1:CMSWebPartZone ID="zoneBottom" runat="server" />
</div>