<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="OrdersProcess.aspx.cs" Inherits="CMSTemplates_OrdersProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function AdjustSize() {
            var Height = Math.max(0, document.documentElement.clientHeight);
            if (typeof GvLevelA !== 'undefined')
                GvLevelA.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight()));
        }
        function OnDuration(s) {
            if (GvLevelAAA.GetEditor("DetailEndTimeM").GetValue() == null || GvLevelAAA.GetEditor("DetailStartTimeM").GetValue() == null) { return;}
            var dateDiff = GvLevelAAA.GetEditor("DetailEndTimeM").GetValue().getTime() - GvLevelAAA.GetEditor("DetailStartTimeM").GetValue().getTime();
            var totalHours = Math.floor(dateDiff / (1000 * 60 * 60));
            var totalMinutes = Math.floor((dateDiff - totalHours * (1000 * 60 * 60)) / (1000 * 60));
            var totalResult = totalHours + (100 / 60 * totalMinutes) / 100;
            GvLevelAAA.GetEditor("DetailTotalTimeM").SetValue(parseFloat(totalResult).toFixed(2));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
    <dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsGvLevelA" KeyFieldName="ProcessListId" Border-BorderWidth="0">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ProcessListName" VisibleIndex="0" Caption="Công đoạn đơn hàng" CellStyle-Paddings-PaddingLeft="8px" />
        </Columns>
        <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />        
        <SettingsPager Mode="ShowAllRecords" />
        <SettingsBehavior EnableRowHotTrack="true" />
        <Settings VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
        <Styles DetailCell-Paddings-Padding="0" />
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="GvLevelAA" ClientInstanceName="GvLevelAA" runat="server" DataSourceID="OdsGvLevelAA" KeyFieldName="ProjectTaskID" Width="100%" 
                    Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Border-BorderWidth="0" BorderLeft-BorderWidth="1" BorderRight-BorderWidth="1"
                    OnBeforePerformDataSelect="GvLevelAA_BeforePerformDataSelect" OnHtmlDataCellPrepared="GvLevelAA_HtmlDataCellPrepared" OnStartRowEditing="GvLevelAA_StartRowEditing" OnFillContextMenuItems="GvLevelAA_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                    <Columns>
                        <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="48" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" />
                        <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" ReadOnly="true" />
					    <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="ProjectTaskOverlayNum" Caption="Số phủ" ReadOnly="true" Width="88" />
                        <dx:GridViewDataTextColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="MoldsName" Caption="Loại" ReadOnly="true" Width="100"/>
                        <dx:GridViewDataTextColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="ProjectTaskDiameterOut" Caption="Đ kính" ReadOnly="true" EditFormSettings-Visible="False" Width="58"/>
                        <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="ProjectTaskQuantities" Caption="Số lượng" ReadOnly="true" EditFormSettings-Visible="False" Width="65"/>
                        <dx:GridViewDataTextColumn VisibleIndex="6" EditFormSettings-VisibleIndex="6" FieldName="ProjectTaskThickness" Caption="Bề dày" ReadOnly="true" EditFormSettings-Visible="False" Width="58"/>
                        <dx:GridViewDataTextColumn VisibleIndex="7" EditFormSettings-VisibleIndex="7" FieldName="CustomerName" Caption="Khách hàng" ReadOnly="true" Width="100"/>
                        <dx:GridViewDataTextColumn VisibleIndex="8" EditFormSettings-VisibleIndex="8" FieldName="ProjectTaskTransmit" Caption="Ngày nhận" ReadOnly="true" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy" EditFormSettings-Visible="False" Width="78"/>
                        <dx:GridViewDataTextColumn VisibleIndex="9" EditFormSettings-VisibleIndex="9" FieldName="ProjectTaskDeadline" Caption="Ngày xuất" ReadOnly="true" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy" EditFormSettings-Visible="False" Width="78"/>
                        <dx:GridViewDataDateColumn VisibleIndex="10" EditFormSettings-VisibleIndex="10" FieldName="ProcessExpectedCompletion" Caption="Ngày dự kiến" Width="108">
                            <PropertiesDateEdit DisplayFormatString="MM/dd/yyyy HH:mm">
                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataSpinEditColumn VisibleIndex="11" EditFormSettings-VisibleIndex="11" FieldName="AutoPriority" Caption="Độ trễ" ReadOnly="true" EditFormSettings-Visible="False" Width="48" />
                        <dx:GridViewDataComboBoxColumn VisibleIndex="12" EditFormSettings-VisibleIndex="12" FieldName="ProcessPlusBrowse" Caption="Nhóm hỗ trợ" Visible="false" EditFormSettings-Visible="True">
                            <PropertiesComboBox DataSourceID="OdsProcessExtraList" ValueField="ProcessListId" TextField="ProcessListName" ValueType="System.Int32" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataSpinEditColumn VisibleIndex="13" EditFormSettings-VisibleIndex="13" FieldName="ProcessExpectedTime" Caption="Tg dự kiến" Width="78">
                            <PropertiesSpinEdit DecimalPlaces="2" NumberType="Float" DisplayFormatString="{0} giờ.">
                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataCheckColumn VisibleIndex="14" EditFormSettings-VisibleIndex="14" FieldName="ProcessGangerBrowse" Caption="Duyệt" Visible="false" EditFormSettings-Visible="True" />
                    </Columns>
                    <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                    <SettingsEditing Mode="PopupEditForm" />
                    <SettingsPopup>
                        <EditForm Width="480" Modal="true" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" />
                    </SettingsPopup>
                    <SettingsBehavior EnableRowHotTrack="true" />
                    <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true"/>
                    <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                    <SettingsContextMenu Enabled="true" />    
                    <SettingsPager Mode="ShowPager" PageSize="10" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                    <Styles DetailCell-Paddings-Padding="0" />
                    <Templates>
                        <DetailRow>
                            <dx:ASPxGridView ID="GvLevelAAA" ClientInstanceName="GvLevelAAA" runat="server" DataSourceID="OdsGvLevelAAA" KeyFieldName="DetailId" Width="100%"
                                Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Styles-Footer-BackColor="#F2F2F2" Border-BorderWidth="0" BorderLeft-BorderWidth="1"
                                OnBeforePerformDataSelect="GvLevelAAA_BeforePerformDataSelect" OnStartRowEditing="GvLevelAAA_StartRowEditing" OnFillContextMenuItems="GvLevelAAA_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                <Columns>
                                    <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="47" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                    <dx:GridViewDataComboBoxColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="SubProcessID" Caption="Loại việc">
                                        <PropertiesComboBox DataSourceID="OdsMinOrdersSubProcessList" TextField="SubProcessName" ValueField="SubProcessID" ValueType="System.Int32" TextFormatString="{0}">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="SubProcessName" Caption="Loại việc" />
                                                <dx:ListBoxColumn FieldName="SubProcessFinish" Caption="Finish" Width="38" />                                            
                                            </Columns>
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataDateColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="DetailStartTimeM" Caption="Bắt đầu" Width="138">
                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                            <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            <ClientSideEvents DateChanged="function(s, e) { OnDuration(s); }" />
                                        </PropertiesDateEdit>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="DetailEndTimeM" Caption="Kết thúc" Width="171">
                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                                            <DateRangeSettings StartDateEditID="DetailStartTimeM" />
                                            <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            <ClientSideEvents DateChanged="function(s, e) { OnDuration(s); }" />
                                        </PropertiesDateEdit>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataComboBoxColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="DetailOwnerM" Caption="Nhân viên" Width="169">
                                        <PropertiesComboBox DataSourceID="OdsMinEmployeeListByProcessListId" TextField="EmployeeFullName" ValueField="EmployeeId" ValueType="System.Int32" TextFormatString="{1}">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="EmployeeCode" Caption="Mã số" Width="38" />
                                                <dx:ListBoxColumn FieldName="EmployeeFullName" Caption="Họ tên" />                                            
                                            </Columns>
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataComboBoxColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="DetailMachineId" Caption="Máy gia công" Width="174">
                                        <PropertiesComboBox DataSourceID="OdsMinOrdersMachineryList" TextField="MachineryName" ValueField="MachineryID" ValueType="System.Int32" TextFormatString="{0}">
                                            <Columns>
                                                <dx:ListBoxColumn FieldName="MachineryName" Caption="Tên máy" />
                                                <dx:ListBoxColumn FieldName="MachinerySymbol" Caption="Ký hiệu" Width="38" />                                            
                                            </Columns>
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        </PropertiesComboBox>
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="DetailTotalTimeM" Caption="Đã làm" Width="78" ReadOnly="true"> 
                                        <PropertiesTextEdit DisplayFormatString="{0} giờ." DisplayFormatInEditMode="true">
                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="SubProcessID" ShowInColumn="SubProcessID" SummaryType="Count" DisplayFormat="Count: {0} việc." />
                                    <dx:ASPxSummaryItem FieldName="DetailTotalTimeM" ShowInColumn="DetailTotalTimeM" SummaryType="Sum" DisplayFormat="{0} giờ." />
                                </TotalSummary>
                                <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
                                <SettingsPopup>
                                    <EditForm Width="388" Modal="true" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" />
                                </SettingsPopup>
                                <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                                <Settings ShowFooter="true" ShowHeaderFilterButton="true" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                <SettingsContextMenu Enabled="true" />    
                                <SettingsPager Mode="ShowAllRecords" />                                
                            </dx:ASPxGridView>
                            <asp:ObjectDataSource ID="OdsGvLevelAAA" runat="server" TypeName="OrdersModels" SelectMethod="OrdersProcessListDetail" UpdateMethod="OrdersProcessDetailUpdated" InsertMethod="OrdersProcessDetailCreated" DeleteMethod="OrdersProcessDetailDeleted">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
                                    <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
                                    <asp:Parameter Name="SubProcessID" Type="Int32" />
                                    <asp:Parameter Name="DetailMachineId" Type="Int32" />
                                    <asp:Parameter Name="DetailStartTimeM" Type="DateTime" />
                                    <asp:Parameter Name="DetailEndTimeM" Type="DateTime" />
                                    <asp:Parameter Name="DetailTotalTimeM" Type="Decimal" />
                                    <asp:Parameter Name="DetailOwnerM" Type="Int32" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="DetailId" Type="Int32" />
                                    <asp:Parameter Name="SubProcessID" Type="Int32" />
                                    <asp:Parameter Name="DetailMachineId" Type="Int32" />
                                    <asp:Parameter Name="DetailStartTimeM" Type="DateTime" />
                                    <asp:Parameter Name="DetailEndTimeM" Type="DateTime" />
                                    <asp:Parameter Name="DetailTotalTimeM" Type="Decimal" />
                                    <asp:Parameter Name="DetailOwnerM" Type="Int32" />
                                </UpdateParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="DetailId" Type="Int32" />
                                </DeleteParameters>
                            </asp:ObjectDataSource>
                        </DetailRow>
                    </Templates>
                </dx:ASPxGridView>
                <asp:ObjectDataSource ID="OdsGvLevelAA" runat="server" TypeName="OrdersModels" SelectMethod="OrdersProcessList" UpdateMethod="OrdersProcessUpdated">
                    <SelectParameters>
                        <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ProjectTaskID" Type="Int32" />
                        <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
                        <asp:Parameter Name="ProcessGangerBrowse" Type="Boolean" />
                        <asp:Parameter Name="ProcessExpectedTime" Type="Decimal" />
                        <asp:Parameter Name="ProcessExpectedCompletion" Type="DateTime" />
                        <asp:Parameter Name="ProcessPlusBrowse" Type="Int32" />        
                    </UpdateParameters>
                </asp:ObjectDataSource>   
            </DetailRow>
        </Templates>
    </dx:ASPxGridView>
    <asp:ObjectDataSource ID="OdsGvLevelA" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessListForUserId" />
    <asp:ObjectDataSource ID="OdsProcessExtraList" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessListIsFinish">
        <SelectParameters>
            <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
            <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>      
    <asp:ObjectDataSource ID="OdsMinEmployeeListByProcessListId" runat="server" TypeName="EmployeeModels" SelectMethod="MinEmployeeListByProcessListId">
        <SelectParameters>
            <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="OdsMinOrdersSubProcessList" runat="server" TypeName="OrdersModels" SelectMethod="MinOrdersSubProcessList">
        <SelectParameters>
            <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="OdsMinOrdersMachineryList" runat="server" TypeName="OrdersModels" SelectMethod="MinOrdersMachineryList">
        <SelectParameters>
            <asp:SessionParameter Name="ProcessListId" SessionField="ProcessListId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

