<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DanhMucChucNang.ascx.cs" Inherits="CMSTemplates_Controls_DanhMucChucNang" %>
<dx:ASPxGridView ID="GvRoles" ClientInstanceName="GvRoles" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="PermissionID" 
    OnBatchUpdate="GvRoles_BatchUpdate"> 
    <SettingsPager Mode="ShowAllRecords" />
    <SettingsLoadingPanel Text="Đang tải..."/>
    <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị"/>
    <SettingsBehavior AllowSort="false" />
    <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
    <Settings VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Visible"/>    
    <Styles Header-CssClass="Detail" DetailCell-Paddings-PaddingTop="5px" DetailCell-Paddings-PaddingRight="0px" DetailCell-Paddings-PaddingBottom="5px" />
    <ClientSideEvents Init="OnInit" />
    <SettingsCommandButton UpdateButton-Text="Cập nhật" UpdateButton-ButtonType="Button" CancelButton-ButtonType="Button" CancelButton-Text="Quay lại"/>
    <Templates>
        <DetailRow>
            <dx:ASPxGridView ID="gvRoleChild" ClientInstanceName="gvRoleChild" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="PermissionID" 
                SettingsBehavior-AllowSort="false" OnBeforePerformDataSelect="gvRoleChild_BeforePerformDataSelect" OnBatchUpdate="gvRoleChild_BatchUpdate">
                <SettingsPager Mode="ShowAllRecords" />
                <SettingsLoadingPanel Text="Đang tải..."/>
                <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị"/>
                <SettingsCommandButton UpdateButton-Text="Cập nhật" UpdateButton-ButtonType="Button" CancelButton-ButtonType="Button" CancelButton-Text="Quay lại"/>
            </dx:ASPxGridView>
        </DetailRow>
    </Templates>
</dx:ASPxGridView>