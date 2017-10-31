<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="SystemConfig.aspx.cs" Inherits="CMSTemplates_SystemConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function AdjustSize() {
            var TabHeight = 28;
            var Height = Math.max(0, document.documentElement.clientHeight);
            if (typeof GvLevelA !== 'undefined')
                GvLevelA.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight));
            if (typeof GvLevelB !== 'undefined')
                GvLevelB.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight));
        }
        function OnTabChanged(s, e) {
            AdjustSize();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
    <dx:ASPxPageControl ID="PageControl" ClientInstanceName="PageControl" Width="100%" runat="server" ActiveTabIndex="0" OnLoad="PageControl_Load">
        <ClientSideEvents ActiveTabChanged="OnTabChanged" />
        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
        <ContentStyle BorderRight-BorderWidth="0" BorderLeft-BorderWidth="0" BorderBottom-BorderWidth="0" Paddings-Padding="0" />
        <TabPages>
            <dx:TabPage Name="UsersTab" Text="Quản lý tài khoản" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="UsersTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsLevelA" KeyFieldName="UserID" 
                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="3" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn FieldName="FullName" Caption="Họ và tên">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn> 
                                <dx:GridViewDataTextColumn FieldName="Email" Caption="Email" Width="228">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn> 
                                <dx:GridViewDataDateColumn FieldName="UserDateOfBirth" Caption="Ngày sinh" Width="148" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy">
                                    <PropertiesDateEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="UserCreated" Caption="Ngày tạo" Width="148" EditFormSettings-Visible="False" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm" />
                                <dx:GridViewDataDateColumn FieldName="LastLogon" Caption="Đăng nhập lần cuối" Width="148" EditFormSettings-Visible="False" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm" />                                                   
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelA" runat="server" TypeName="SystemModels" SelectMethod="UserList" InsertMethod="UserCreated" UpdateMethod="UserUpdated" DeleteMethod="UserDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="FullName" Type="String" />
                                <asp:Parameter Name="UserDateOfBirth" Type="DateTime" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="UserID" Type="Int32" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter Name="FullName" Type="String" />
                                <asp:Parameter Name="UserDateOfBirth" Type="DateTime" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="UserID" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="GroupsTab" Text="Quản lý nhóm chức năng" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="GroupsTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelB" ClientInstanceName="GvLevelB" runat="server" Width="100%" DataSourceID="OdsLevelB" KeyFieldName="RoleName" 
                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelB_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn FieldName="RoleDisplayName" Caption="Nhóm" Width="288">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn> 
                                <dx:GridViewDataTextColumn FieldName="RoleDescription" Caption="Mô tả nhóm">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn> 
                            </Columns>
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                            <Styles DetailCell-Paddings-Padding="0" DetailCell-Paddings-PaddingBottom="1" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxPageControl ID="PageControlNd" ClientInstanceName="PageControlNd" Width="100%" runat="server" ActiveTabIndex="0">
                                        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
                                        <ContentStyle Paddings-Padding="0" />
                                        <TabPages>
                                            <dx:TabPage Text="Chức năng hệ thống" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelBA" ClientInstanceName="GvLevelBA" runat="server" Width="100%" DataSourceID="OdsLevelBA" KeyFieldName="PermissionID" 
                                                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelBatch_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBNd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText"> 
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Nhóm chức năng" ReadOnly="true" />
                                                                <dx:GridViewDataCheckColumn FieldName="PermissionAllow" Caption="Quyền tương tác" Width="128" />
                                                            </Columns>
                                                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <SettingsPager Mode="ShowPager" PageSize="20" />
                                                            <SettingsBehavior EnableRowHotTrack="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <Styles DetailCell-Paddings-Padding="0" StatusBar-BorderTop-BorderColor="#CFCFCF" BatchEditCell-BorderBottom-BorderWidth="1" />
                                                            <Templates>
                                                                <DetailRow>
                                                                    <dx:ASPxGridView ID="GvLevelBAA" ClientInstanceName="GvLevelBAA" runat="server" Width="100%" DataSourceID="OdsLevelBRd" KeyFieldName="PermissionID" 
                                                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Styles-Footer-BackColor="#F2F2F2" Styles-StatusBar-BorderTop-BorderColor="#CFCFCF" Border-BorderWidth="0" BorderLeft-BorderWidth="1"
                                                                        OnFillContextMenuItems="GvLevelBatch_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBRd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="43" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                            <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Chức năng" ReadOnly="true" />
                                                                            <dx:GridViewDataCheckColumn FieldName="PermissionAllow" Caption="Quyền tương tác" Width="128" />
                                                                        </Columns>
                                                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                                        <SettingsContextMenu Enabled="true" />
                                                                        <SettingsPager Mode="ShowPager" PageSize="20" />
                                                                        <SettingsBehavior EnableRowHotTrack="true" />
                                                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                                        <Styles StatusBar-BorderTop-BorderColor="#CFCFCF" />
                                                                    </dx:ASPxGridView>
                                                                </DetailRow>
                                                            </Templates>
                                                        </dx:ASPxGridView>
                                                        <asp:ObjectDataSource ID="OdsLevelBA" runat="server" TypeName="SystemModels" SelectMethod="PermissionsList" UpdateMethod="PermissionsUpdated">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                                <asp:Parameter Name="RoleGroup" Type="String" DefaultValue="Functions" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="PermissionID" Type="Int32" />
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                                <asp:Parameter Name="PermissionAllow" Type="Boolean" />
                                                            </UpdateParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Chức năng công đoạn" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelBB" ClientInstanceName="GvLevelBB" runat="server" Width="100%" DataSourceID="OdsLevelBB" KeyFieldName="PermissionID" 
                                                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelBatch_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBNd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText"> 
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Nhóm chức năng" ReadOnly="true" />
                                                                <dx:GridViewDataCheckColumn FieldName="PermissionAllow" Caption="Quyền tương tác" Width="128" />
                                                            </Columns>
                                                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <SettingsPager Mode="ShowPager" PageSize="20" />
                                                            <SettingsBehavior EnableRowHotTrack="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <Styles DetailCell-Paddings-Padding="0" />
                                                            <Templates>
                                                                <DetailRow>
                                                                    <dx:ASPxGridView ID="GvLevelBBA" ClientInstanceName="GvLevelBBA" runat="server" Width="100%" DataSourceID="OdsLevelBRd" KeyFieldName="PermissionID" 
                                                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Styles-Footer-BackColor="#F2F2F2" Styles-StatusBar-BorderTop-BorderColor="#CFCFCF" Border-BorderWidth="0" BorderLeft-BorderWidth="1"
                                                                        OnFillContextMenuItems="GvLevelBatch_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBRd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="43" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                            <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Chức năng" ReadOnly="true" />
                                                                            <dx:GridViewDataCheckColumn FieldName="PermissionAllow" Caption="Quyền tương tác" Width="128" />
                                                                        </Columns>
                                                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                                        <SettingsContextMenu Enabled="true" />
                                                                        <SettingsPager Mode="ShowPager" PageSize="20" />
                                                                        <SettingsBehavior EnableRowHotTrack="true" />
                                                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                                        <Styles StatusBar-BorderTop-BorderColor="#CFCFCF" />
                                                                    </dx:ASPxGridView>
                                                                </DetailRow>
                                                            </Templates>
                                                        </dx:ASPxGridView>
                                                        <asp:ObjectDataSource ID="OdsLevelBB" runat="server" TypeName="SystemModels" SelectMethod="PermissionsListNd" UpdateMethod="PermissionsUpdated">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                                <asp:Parameter Name="RoleGroup" Type="String" DefaultValue="Functions" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="PermissionID" Type="Int32" />
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                                <asp:Parameter Name="PermissionAllow" Type="Boolean" />
                                                            </UpdateParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Danh sách tài khoản" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelBC" ClientInstanceName="GvLevelBC" runat="server" Width="100%" DataSourceID="OdsLevelBC" KeyFieldName="UserID" 
                                                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="1" OnFillContextMenuItems="GvLevelBC_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBC_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText"> 
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataComboBoxColumn FieldName="UserID" Caption="Họ và tên" Visible="false" EditFormSettings-Visible="True">
                                                                    <PropertiesComboBox DataSourceID="OdsLevelBCNd" TextField="FullName" ValueField="UserID" ValueType="System.Int32" TextFormatString="{0}">
                                                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="FullName" Caption="Họ và tên" />
                                                                            <dx:ListBoxColumn FieldName="Email" Caption="Email" Width="188" />
                                                                            <dx:ListBoxColumn FieldName="UserDateOfBirth" Caption="Ngày sinh" Width="128" />
                                                                        </Columns>
                                                                    </PropertiesComboBox>
                                                                </dx:GridViewDataComboBoxColumn>
                                                                <dx:GridViewDataTextColumn FieldName="FullName" Caption="Họ và tên" EditFormSettings-Visible="False" /> 
                                                                <dx:GridViewDataTextColumn FieldName="Email" Caption="Email" Width="228" EditFormSettings-Visible="False" /> 
                                                                <dx:GridViewDataDateColumn FieldName="UserDateOfBirth" Caption="Ngày sinh" Width="148" EditFormSettings-Visible="False" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
                                                                <dx:GridViewDataDateColumn FieldName="UserCreated" Caption="Ngày tạo" Width="148" EditFormSettings-Visible="False" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm" />
                                                                <dx:GridViewDataDateColumn FieldName="LastLogon" Caption="Đăng nhập lần cuối" Width="148" EditFormSettings-Visible="False" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm" />                                                   
                                                            </Columns>
                                                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                                                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />                                                            
                                                        </dx:ASPxGridView>                                                        
                                                        <asp:ObjectDataSource ID="OdsLevelBC" runat="server" TypeName="SystemModels" SelectMethod="UserListByRole" InsertMethod="UserRoleCreated" DeleteMethod="UserRoleDeleted">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                            </SelectParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="UserID" Type="Int32" />
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                            </InsertParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="UserID" Type="Int32" />
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                            </DeleteParameters>
                                                        </asp:ObjectDataSource>
                                                        <asp:ObjectDataSource ID="OdsLevelBCNd" runat="server" TypeName="SystemModels" SelectMethod="UserListNotInRole">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>
                                </DetailRow>
                            </Templates>
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelB" runat="server" TypeName="SystemModels" SelectMethod="RoleList" InsertMethod="RoleCreated" UpdateMethod="RoleUpdated" DeleteMethod="RoleDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="RoleDisplayName" Type="String" />
                                <asp:Parameter Name="RoleDescription" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="RoleName" Type="String" />
                                <asp:Parameter Name="RoleDisplayName" Type="String" />
                                <asp:Parameter Name="RoleDescription" Type="String" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="RoleName" Type="String" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="OdsLevelBRd" runat="server" TypeName="SystemModels" SelectMethod="PermissionsListRd" UpdateMethod="PermissionsUpdated">
                            <SelectParameters>
                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                <asp:SessionParameter Name="RoleGroupId" SessionField="RoleGroupId" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="PermissionID" Type="Int32" />
                                <asp:SessionParameter Name="RoleName" SessionField="RoleName" Type="String" />
                                <asp:Parameter Name="PermissionAllow" Type="Boolean" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>            
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

