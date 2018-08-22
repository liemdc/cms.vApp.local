<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="TaskHistory.aspx.cs" Inherits="CMSTemplates_TaskHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function AdjustSize() {
            var TabHeight = 28;
            var ControlHeight = 27;
            var Height = Math.max(0, document.documentElement.clientHeight);
            if (typeof GvLevelA !== 'undefined')
                GvLevelA.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight));
            if (typeof GvLevelB !== 'undefined')
                GvLevelB.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight));
            if (typeof GvLevelC !== 'undefined')
                GvLevelC.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight + ControlHeight));
            if (typeof GvLevelD !== 'undefined')
                GvLevelD.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + TabHeight + ControlHeight));
        }
        function OnTabChanged(s, e) {
            AdjustSize();
        }
        function OnDuration(s) {
            if (GvLevelA.GetEditor("HistoryEnd").GetValue() == null || GvLevelA.GetEditor("HistoryBegin").GetValue() == null) { return; }
            var dateDiff = GvLevelA.GetEditor("HistoryEnd").GetValue().getTime() - GvLevelA.GetEditor("HistoryBegin").GetValue().getTime();
            var totalHours = Math.floor(dateDiff / (1000 * 60 * 60));
            var totalMinutes = Math.floor((dateDiff - totalHours * (1000 * 60 * 60)) / (1000 * 60));
            var totalResult = totalHours + (100 / 60 * totalMinutes) / 100;
            GvLevelA.GetEditor("HistoryDuration").SetValue(parseFloat(totalResult).toFixed(2));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">    
    <dx:ASPxPageControl ID="PageControl" ClientInstanceName="PageControl" Width="100%" runat="server" ActiveTabIndex="0">
        <ClientSideEvents ActiveTabChanged="OnTabChanged" />
        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
        <ContentStyle BorderRight-BorderWidth="0" BorderLeft-BorderWidth="0" BorderBottom-BorderWidth="0" Paddings-Padding="0" />
        <TabPages>
            <dx:TabPage Text="Nhật ký làm việc" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="TaskHistoryTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsLevelA" KeyFieldName="HistoryId" 
                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="3" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataComboBoxColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="HistoryTaskId" Caption="Công việc" Width="288" EditFormSettings-ColumnSpan="2">
                                    <PropertiesComboBox DataSourceID="OdsTask" TextField="TaskName" ValueField="TaskId" ValueType="System.Int32">
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn> 
                                <dx:GridViewDataComboBoxColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="HistoryEmployeeId" Caption="Nhân viên" MinWidth="288">
                                    <PropertiesComboBox DataSourceID="OdsEmployee" TextField="EmployeeFullName" ValueField="EmployeeId" ValueType="System.Int32" TextFormatString="{1}">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="EmployeeCode" Caption="Mã số" Width="38" />
                                            <dx:ListBoxColumn FieldName="EmployeeFullName" Caption="Họ tên" />                                            
                                        </Columns>
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn> 
                                <dx:GridViewDataDateColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="HistoryBegin" Caption="Bắt đầu" Width="188">
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="HistoryEnd" Caption="Kết thúc" Width="188">
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                        <DateRangeSettings StartDateEditID="HistoryBegin" />
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        <ClientSideEvents DateChanged="function(s, e) { OnDuration(s); }" />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn> 
                                <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="HistoryDuration" Caption="Đã làm" Width="128" ReadOnly="true"> 
                                    <PropertiesTextEdit DisplayFormatString="{0} giờ." DisplayFormatInEditMode="true">
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>                                                    
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsEmployee" runat="server" TypeName="EmployeeModels" SelectMethod="MinEmployeeList" />
                        <asp:ObjectDataSource ID="OdsTask" runat="server" TypeName="TaskModels" SelectMethod="MinTaskList" />
                        <asp:ObjectDataSource ID="OdsLevelA" runat="server" TypeName="TaskModels" SelectMethod="TaskHistoryList" InsertMethod="TaskHistoryCreated" UpdateMethod="TaskHistoryUpdated" DeleteMethod="TaskHistoryDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="HistoryEmployeeId" Type="Int32" />
                                <asp:Parameter Name="HistoryTaskId" Type="Int32" />
                                <asp:Parameter Name="HistoryBegin" Type="DateTime" />
                                <asp:Parameter Name="HistoryEnd" Type="DateTime" />
                                <asp:Parameter Name="HistoryDuration" Type="Decimal" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="HistoryId" Type="Int32" />
                                <asp:Parameter Name="HistoryEmployeeId" Type="Int32" />
                                <asp:Parameter Name="HistoryTaskId" Type="Int32" />
                                <asp:Parameter Name="HistoryBegin" Type="DateTime" />
                                <asp:Parameter Name="HistoryEnd" Type="DateTime" />
                                <asp:Parameter Name="HistoryDuration" Type="Decimal" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="HistoryId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Danh sách công việc" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="TaskListTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelB" ClientInstanceName="GvLevelB" runat="server" Width="100%" DataSourceID="OdsLevelB" KeyFieldName="TaskId" 
                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelB_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="TaskName" Caption="Công việc" Width="288">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="TaskDescription" Caption="Mô tả công việc" MinWidth="288">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn>  
                                <dx:GridViewDataTextColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="UserModified" Caption="Cập nhật bởi" Width="188" EditFormSettings-Visible="False" />                                                             
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelB" runat="server" TypeName="TaskModels" SelectMethod="TaskList" InsertMethod="TaskCreated" UpdateMethod="TaskUpdated" DeleteMethod="TaskDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="TaskName" Type="String" />
                                <asp:Parameter Name="TaskDescription" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="TaskId" Type="Int32" />
                                <asp:Parameter Name="TaskName" Type="String" />
                                <asp:Parameter Name="TaskDescription" Type="String" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="TaskId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Báo cáo thống kê" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="ReportTimeTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelC" ClientInstanceName="GvLevelC" runat="server" Width="100%" DataSourceID="OdsLevelC" KeyFieldName="EmployeeId" 
                            Border-BorderWidth="0" BorderBottom-BorderWidth="1" OnFillContextMenuItems="GvLevelC_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="EmployeeFullName" Caption="Nhân viên" />
                                <dx:GridViewBandColumn VisibleIndex ="2" Caption="Giờ làm công đoạn" HeaderStyle-HorizontalAlign="Center">
                                    <Columns>
                                        <dx:GridViewDataDateColumn VisibleIndex="1" FieldName="DateBegin" Caption="Bắt đầu" Width="128">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn VisibleIndex="2" FieldName="DateEnd" Caption="Kết thúc" Width="128">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn> 
                                        <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="ProcessTotal" Caption="Giờ công đoạn" Width="128" PropertiesTextEdit-DisplayFormatString="{0:#,###.##} giờ." />
                                    </Columns>
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn VisibleIndex ="3" Caption="Giờ làm khác" HeaderStyle-HorizontalAlign="Center">
                                    <Columns>
                                        <dx:GridViewDataDateColumn VisibleIndex="1" FieldName="OrDateBegin" Caption="Bắt đầu" Width="128">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn VisibleIndex="2" FieldName="OrDateEnd" Caption="Kết thúc" Width="128">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn> 
                                        <dx:GridViewDataTextColumn VisibleIndex="5" FieldName="TaskTotal" Caption="Giờ làm khác" Width="135" PropertiesTextEdit-DisplayFormatString="{0:#,###.##} giờ." />
                                    </Columns>
                                </dx:GridViewBandColumn>
                            </Columns>
                            <SettingsDetail ShowDetailRow="True" />
                            <Styles DetailCell-Paddings-Padding="0" />
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxPageControl runat="server" ID="DPageControl" Width="100%" ActiveTabIndex="0">
                                        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
                                        <ContentStyle Paddings-Padding="0" />
                                        <TabPages>
                                            <dx:TabPage Text="Báo cáo chung" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelCA" ClientInstanceName="GvLevelCA" runat="server" DataSourceID="OdsLevelCA" KeyFieldName="TaskId" Width="100%"
                                                            Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Border-BorderWidth="0"
                                                            OnBeforePerformDataSelect="GvLevelCA_BeforePerformDataSelect" OnFillContextMenuItems="GvLevelC_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" FieldName="EmployeeCode" Caption="EId" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" />
                                                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="TaskName" Caption="Loại việc" />
                                                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="MachineName" Caption="Máy" Width="371" />
                                                                <dx:GridViewDataDateColumn VisibleIndex="2" FieldName="DateBegin" Caption="Bắt đầu" Width="115" >
                                                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                                    </PropertiesDateEdit>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataDateColumn VisibleIndex="3" FieldName="DateEnd" Caption="Kết thúc" Width="115">
                                                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                                    </PropertiesDateEdit>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTextColumn VisibleIndex="5" FieldName="TaskTime" Caption="Đã làm" Width="122" PropertiesTextEdit-DisplayFormatString="{0:#,###.##} giờ." />
                                                            </Columns>
                                                            <TotalSummary>
                                                                <dx:ASPxSummaryItem SummaryType="Count" FieldName="TaskName" ShowInColumn="TaskName" DisplayFormat="Count: {0} việc." />
                                                                <dx:ASPxSummaryItem SummaryType="Sum" FieldName="TaskTime" ShowInColumn="TaskTime" DisplayFormat="Sum: {0} giờ." />
                                                            </TotalSummary>
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />                                        
                                                            <SettingsBehavior EnableRowHotTrack="true" />
                                                            <Settings ShowFooter="true" ShowHeaderFilterButton="true" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <SettingsContextMenu Enabled="true" />    
                                                            <SettingsPager Mode="ShowAllRecords" />                                
                                                        </dx:ASPxGridView> 
                                                     </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Không sử dụng máy" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelCB" ClientInstanceName="GvLevelCB" runat="server" DataSourceID="OdsLevelCB" KeyFieldName="TaskId" Width="100%"
                                                            Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Border-BorderWidth="0"
                                                            OnBeforePerformDataSelect="GvLevelCA_BeforePerformDataSelect" OnFillContextMenuItems="GvLevelC_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" FieldName="EmployeeCode" Caption="EId" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" />
                                                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="TaskName" Caption="Loại việc" />
                                                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="MachineName" Caption="Máy" Width="371" />
                                                                <dx:GridViewDataDateColumn VisibleIndex="2" FieldName="DateBegin" Caption="Bắt đầu" Width="115" >
                                                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                                    </PropertiesDateEdit>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataDateColumn VisibleIndex="3" FieldName="DateEnd" Caption="Kết thúc" Width="115">
                                                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                                    </PropertiesDateEdit>
                                                                </dx:GridViewDataDateColumn>
                                                                <dx:GridViewDataTextColumn VisibleIndex="5" FieldName="TaskTime" Caption="Đã làm" Width="122" PropertiesTextEdit-DisplayFormatString="{0:#,###.##} giờ." />
                                                            </Columns>
                                                            <TotalSummary>
                                                                <dx:ASPxSummaryItem SummaryType="Count" FieldName="TaskName" ShowInColumn="TaskName" DisplayFormat="Count: {0} việc." />
                                                                <dx:ASPxSummaryItem SummaryType="Sum" FieldName="TaskTime" ShowInColumn="TaskTime" DisplayFormat="Sum: {0} giờ." />
                                                            </TotalSummary>
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />                                        
                                                            <SettingsBehavior EnableRowHotTrack="true" />
                                                            <Settings ShowFooter="true" ShowHeaderFilterButton="true" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <SettingsContextMenu Enabled="true" />    
                                                            <SettingsPager Mode="ShowAllRecords" />                                
                                                        </dx:ASPxGridView> 
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>                                  
                                </DetailRow>
                            </Templates>
                        </dx:ASPxGridView>
                        <dx:ASPxGridViewExporter ID="GvExport" runat="server" GridViewID="GvLevelC" />  
                        <asp:ObjectDataSource ID="OdsLevelC" runat="server" TypeName="EmployeeModels" SelectMethod="EmployeeListTask">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DeStart" Name="PRDateBegin" Type="DateTime" />
                                <asp:ControlParameter ControlID="DeEnd" Name="PRDateEnd" Type="DateTime" />
                            </SelectParameters>
                        </asp:ObjectDataSource>  
                        <asp:ObjectDataSource ID="OdsLevelCA" runat="server" TypeName="EmployeeModels" SelectMethod="EmployeeTaskTaskDetail">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeId" SessionField="EmployeeId" Type="Int32" />
                                <asp:SessionParameter Name="PRDateBegin" SessionField="PRDateBegin" Type="DateTime" />
                                <asp:SessionParameter Name="PRDateEnd" SessionField="PRDateEnd" Type="DateTime" />
                                <asp:Parameter Name="Machine" Type="Boolean" DefaultValue="True" />
                            </SelectParameters>
                        </asp:ObjectDataSource>     
                        <asp:ObjectDataSource ID="OdsLevelCB" runat="server" TypeName="EmployeeModels" SelectMethod="EmployeeTaskTaskDetail">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmployeeId" SessionField="EmployeeId" Type="Int32" />
                                <asp:SessionParameter Name="PRDateBegin" SessionField="PRDateBegin" Type="DateTime" />
                                <asp:SessionParameter Name="PRDateEnd" SessionField="PRDateEnd" Type="DateTime" />
                                <asp:Parameter Name="Machine" Type="Boolean" DefaultValue="False" />
                            </SelectParameters>
                        </asp:ObjectDataSource>                                      
                        <table style="width:100%;border-spacing:0">
                            <tr>
                                <td style="text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="GvLevelCLabel" runat="server" Text="Chọn khoảng thời gian [ Từ ngày / Đến ngày ]: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;height:25px;padding-right:3px">
                                    <dx:ASPxDateEdit ID="DeStart" ClientInstanceName="DeStart" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChanged">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                            <RequiredField IsRequired="True" ErrorText="Start date is required" />
                                        </ValidationSettings>
                                        <ClientSideEvents DateChanged="function(s, e) { GvLevelC.PerformCallback();}" />
                                    </dx:ASPxDateEdit>
                                </td>
                                <td style="width:128px;height:25px;padding-right:3px">
                                    <dx:ASPxDateEdit ID="DeEnd" ClientInstanceName="DeEnd" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChanged">
                                        <DateRangeSettings StartDateEditID="DeStart" />
                                        <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                            <RequiredField IsRequired="True" ErrorText="End date is required" />
                                        </ValidationSettings>
                                        <ClientSideEvents DateChanged="function(s, e) { GvLevelC.PerformCallback();}" />
                                    </dx:ASPxDateEdit>
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="GvLevelCLabelE" runat="server" Text="Xuất dữ liệu: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;text-align:right;padding-right:3px">
                                    <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbExportMode" ClientSideEvents-TextChanged="function(s, e) { GvLevelC.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLS" UseSubmitBehavior="False" OnClick="btnXlsExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelC.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsxExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLSX" UseSubmitBehavior="False" OnClick="btnXlsxExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelC.PerformCallback();}" />
                                </td>
                            </tr>
                        </table>                         
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Hiệu suất máy" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="TaskMachineTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelD" ClientInstanceName="GvLevelD" runat="server" Width="100%" DataSourceID="OdsLevelD" KeyFieldName="MachineryId" 
                            Border-BorderWidth="0" BorderBottom-BorderWidth="1" OnFillContextMenuItems="GvLevelC_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="MachineryName" Caption="Tên máy" MinWidth="188" />
                                <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="MachinerySymbol" Caption="Kí hiệu" Width="188" />
                                <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="SumTG" Caption="T/g máy chạy" Width="188" PropertiesTextEdit-DisplayFormatString="0,0.00 giờ" />
                                <dx:GridViewDataTextColumn VisibleIndex="4" FieldName="SumHS" Caption="Hiệu suất [T/g máy chạy/Số ngày*24]" Width="250"  PropertiesTextEdit-DisplayFormatString="0.0000" />
                                <dx:GridViewDataProgressBarColumn VisibleIndex="5" FieldName="CalcPE" Caption="Hiệu suất" Width="200" CellStyle-Paddings-Padding="0" PropertiesProgressBar-Style-Border-BorderWidth="0" />
                                <dx:GridViewDataDateColumn Visible="false" FieldName="DateBegin" Caption="Bắt đầu" />
                                <dx:GridViewDataDateColumn Visible="false" FieldName="DateEnd" Caption="Kết thúc" /> 
                            </Columns>
                            <SettingsDetail ShowDetailRow="True" />
                            <Styles DetailCell-Paddings-Padding="0" />
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                            <Templates>
                                <DetailRow>     
                                    <dx:ASPxGridView ID="GvLevelDA" ClientInstanceName="GvLevelDA" runat="server" Width="100%" DataSourceID="OdsLevelDA" KeyFieldName="DetailId" SettingsEditing-EditFormColumnCount="1"
                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" BorderTop-BorderWidth="0" 
                                        OnBeforePerformDataSelect="GvLevelDA_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                                        <Columns>
                                            <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                            <dx:GridViewDataTextColumn FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" MinWidth="188" />
                                            <dx:GridViewDataTextColumn FieldName="DetailStartTimeM" Caption="Bắt đầu" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Width="187"/>
                                            <dx:GridViewDataTextColumn FieldName="DetailEndTimeM" Caption="Kết thúc" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Width="187"/>
                                        </Columns>
                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                        <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="OdsLevelDA" runat="server" TypeName="ProcessListModels" SelectMethod="ProjectProcessDetailByMachineId" >
                                        <SelectParameters>
                                            <asp:SessionParameter Name="MachineryId" SessionField="MachineryId" Type="Int32" />
                                            <asp:SessionParameter Name="DeStartDA" SessionField="DeStartDA" Type="DateTime" />
                                            <asp:SessionParameter Name="DeEndDA" SessionField="DeEndDA" Type="DateTime" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </DetailRow>
                            </Templates>
                        </dx:ASPxGridView>
                        <dx:ASPxGridViewExporter ID="GvExportD" runat="server" GridViewID="GvLevelD" />  
                        <asp:ObjectDataSource ID="OdsLevelD" runat="server" TypeName="ProcessListModels" SelectMethod="MachineriesList" InsertMethod="MachineriesCreated" UpdateMethod="MachineriesUpdated" DeleteMethod="MachineriesDeleted">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DeStartD" Name="DeStartD" Type="DateTime" />
                                <asp:ControlParameter ControlID="DeEndD" Name="DeEndD" Type="DateTime" />
                            </SelectParameters>                            
                        </asp:ObjectDataSource>
                        <table style="width:100%;border-spacing:0">
                            <tr>
                                <td style="text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Chọn khoảng thời gian [ Từ ngày / Đến ngày ]: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;height:25px;padding-right:3px">
                                    <dx:ASPxDateEdit ID="DeStartD" ClientInstanceName="DeStartD" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChangedD">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                            <RequiredField IsRequired="True" ErrorText="Start date is required" />
                                        </ValidationSettings>
                                        <ClientSideEvents DateChanged="function(s, e) { GvLevelD.PerformCallback();}" />
                                    </dx:ASPxDateEdit>
                                </td>
                                <td style="width:128px;height:25px;padding-right:3px">
                                    <dx:ASPxDateEdit ID="DeEndD" ClientInstanceName="DeEndD" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChangedD">
                                        <DateRangeSettings StartDateEditID="DeStartD" />
                                        <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                            <RequiredField IsRequired="True" ErrorText="End date is required" />
                                        </ValidationSettings>
                                        <ClientSideEvents DateChanged="function(s, e) { GvLevelD.PerformCallback();}" />
                                    </dx:ASPxDateEdit>
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Xuất dữ liệu: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;text-align:right;padding-right:3px">
                                    <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbExportModeD" ClientSideEvents-TextChanged="function(s, e) { GvLevelD.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsExportD" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLS" UseSubmitBehavior="False" OnClick="btnXlsExportD_Click" ClientSideEvents-Click="function(s, e) { GvLevelD.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsxExportD" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLSX" UseSubmitBehavior="False" OnClick="btnXlsxExportD_Click" ClientSideEvents-Click="function(s, e) { GvLevelD.PerformCallback();}" />
                                </td>
                            </tr>
                        </table>                         
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

