<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="Manager.aspx.cs" Inherits="CMSTemplates_Manager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script src="~/App_Themes/VMMP/js/jquery.min.js"></script>
    <script src="~/App_Themes/VMMP/js/jquery-ui.min.js"></script>
    <script src="~/App_Themes/VMMP/js/jquery.ui.touch-punch.min.js"></script>
    <style>
        .hover { background-color: lightblue; }
        .activeHover { background-color: lightgray; }
        .ui-draggable-dragging { background-color: lightgreen; color: White; }
    </style>
    <script type="text/javascript">
        var lastValue = null;
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
        function InitalizejQuery() {
            $('.draggable').draggable({
                helper: 'clone',
                start: function (ev, ui) {
                    var $draggingElement = $(ui.helper);
                    $draggingElement.width(GvLevelA.GetWidth());
                }
            });
            $('.draggable').droppable({
                activeClass: "hover",
                tolerance: "intersect",
                hoverClass: "activeHover",
                drop: function (event, ui) {
                    var draggingSortIndex = ui.draggable.attr("sortOrder");
                    var targetSortIndex = $(this).attr("sortOrder");
                    GvLevelA.PerformCallback("DRAGROW|" + draggingSortIndex + '|' + targetSortIndex);
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
    <dx:ASPxPageControl ID="PageControl" ClientInstanceName="PageControl" Width="100%" runat="server" ActiveTabIndex="0" OnLoad="PageControl_Load">
        <ClientSideEvents ActiveTabChanged="OnTabChanged" />
        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
        <ContentStyle BorderRight-BorderWidth="0" BorderLeft-BorderWidth="0" BorderBottom-BorderWidth="0" Paddings-Padding="0" />
        <TabPages>
            <dx:TabPage Name="ProcessTab" Text="Danh sách Công đoạn" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="ProcessTab" Visible="true" runat="server">
                        <dx:ASPxGlobalEvents ID="ge" runat="server">
                            <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
                        </dx:ASPxGlobalEvents>
                        <dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsGvLevelA" KeyFieldName="ProcessListId" 
                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="2" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText" OnCustomCallback="GvLevelA_CustomCallback" OnHtmlRowPrepared="GvLevelA_HtmlRowPrepared">
                            <Columns>
                                <dx:GridViewDataTextColumn Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewBandColumn Caption="Danh mục công đoạn đơn hàng">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="ProcessListName" Caption="Công đoạn" CellStyle-Paddings-PaddingLeft="8px">
                                            <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                        </dx:GridViewDataTextColumn> 
                                        <dx:GridViewDataComboBoxColumn FieldName="ProcessListGroup" Caption="Nhóm công đoạn" CellStyle-Paddings-PaddingLeft="8px" Width="328">
                                            <PropertiesComboBox DropDownStyle="DropDownList">
                                                <Items>
                                                    <dx:ListEditItem Value="dataTho" Text="Bộ phận Thô" />
                                                    <dx:ListEditItem Value="dataTinh" Text="Bộ phận Tinh" />
                                                    <dx:ListEditItem Value="dataQA" Text="Bộ phận QA" />
                                                </Items>
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataCheckColumn FieldName="DXNhanDuKien" Caption="Nhận dự kiến" Width="88" />
                                        <dx:GridViewDataTextColumn FieldName="ProcessListIds" Caption="Mã hiệu" EditFormSettings-Visible="False" Width="148" />
                                        <dx:GridViewDataComboBoxColumn FieldName="ProcessListStatus" Caption="Hiện tại" Width="178">
                                            <PropertiesComboBox DropDownStyle="DropDownList">
                                                <Items>
                                                    <dx:ListEditItem Value="Enable" Text="Đang sử dụng" />
                                                    <dx:ListEditItem Value="Disable" Text="Ngưng hoạt động" />
                                                    <dx:ListEditItem Value="Maintenance" Text="Bảo trì" />
                                                </Items>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </dx:GridViewBandColumn>
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />        
                            <SettingsPager Mode="ShowAllRecords" />
                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" ProcessFocusedRowChangedOnServer="True" />
                            <Settings VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                            <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
                            <SettingsPopup EditForm-Width="320" EditForm-Modal="true" EditForm-HorizontalAlign="WindowCenter" EditForm-VerticalAlign="WindowCenter" />
                            <Styles DetailCell-Paddings-Padding="0" DetailCell-Paddings-PaddingBottom="1" Row-CssClass="draggable" />
                            <StylesPopup EditForm-Header-Font-Bold="true" EditForm-Header-Paddings-Padding="5" EditForm-Header-Paddings-PaddingTop="7" />
                            <SettingsText PopupEditFormCaption="Cập nhật dữ liệu" CommandUpdate="Cập nhật" CommandCancel="Hủy bỏ" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxPageControl runat="server" ID="DPageControl" Width="100%" ActiveTabIndex="0">
                                        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
                                        <ContentStyle Paddings-Padding="0" />
                                        <TabPages>
                                            <dx:TabPage Text="Công việc" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelAA" ClientInstanceName="GvLevelAA" runat="server" Width="100%" DataSourceID="OdsGvLevelAA" KeyFieldName="SubProcessId" 
                                                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelNd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText"> 
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataTextColumn FieldName="SubProcessName" Caption="Tên công việc">
                                                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataCheckColumn FieldName="SubProcessFinish" Caption="Hoàn thành" Width="88" />
                                                            </Columns>
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <SettingsPager Mode="ShowAllRecords"/>
                                                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                                                        </dx:ASPxGridView>
                                                        <asp:ObjectDataSource ID="OdsGvLevelAA" runat="server" TypeName="ProcessListModels" SelectMethod="SubProcessList" InsertMethod="SubProcessCreated" UpdateMethod="SubProcessUpdated" DeleteMethod="SubProcessDeleted">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                            </SelectParameters>
                                                            <InsertParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                                <asp:Parameter Name="SubProcessFinish" Type="Boolean" />
                                                                <asp:Parameter Name="SubProcessName" Type="String" />
                                                            </InsertParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="SubProcessId" Type="Int32" />
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                                <asp:Parameter Name="SubProcessFinish" Type="Boolean" />
                                                                <asp:Parameter Name="SubProcessName" Type="String" />
                                                            </UpdateParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="SubProcessId" Type="Int32" />
                                                            </DeleteParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Máy gia công" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelAB" ClientInstanceName="GvLevelAB" runat="server" Width="100%" DataSourceID="OdsGvLevelAB" KeyFieldName="MachineryId" 
                                                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelNd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataTextColumn FieldName="MachineryName" Caption="Máy">
                                                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="MachinerySymbol" Caption="Kí hiệu" Width="88">
                                                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataComboBoxColumn FieldName="MachineryStatus" Caption="Trạng thái máy" Width="188">
                                                                    <PropertiesComboBox DropDownStyle="DropDownList">
                                                                        <Items>
                                                                            <dx:ListEditItem Value="dataChay" Text="Đang chạy" />
                                                                            <dx:ListEditItem Value="dataSua" Text="Sửa chữa" />
                                                                            <dx:ListEditItem Value="dataHu" Text="Máy hỏng" />
                                                                        </Items>
                                                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                                    </PropertiesComboBox>
                                                                </dx:GridViewDataComboBoxColumn>
                                                            </Columns>
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <SettingsPager Mode="ShowAllRecords"/>
                                                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                                                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />
                                                            <Styles DetailCell-Paddings-Padding="0" DetailCell-Paddings-PaddingBottom="8" />
                                                            <Templates>
                                                                <DetailRow>
                                                                    <dx:ASPxGridView ID="GvLevelABA" ClientInstanceName="GvLevelABA" runat="server" Width="100%" DataSourceID="OdsLevelABA" KeyFieldName="DetailId" SettingsEditing-EditFormColumnCount="1"
                                                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" BorderTop-BorderWidth="0" 
                                                                        OnBeforePerformDataSelect="GvLevelABA_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                            <dx:GridViewDataTextColumn FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" MinWidth="188" />
                                                                            <dx:GridViewDataTextColumn FieldName="DetailStartTimeM" Caption="Bắt đầu" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Width="188"/>
                                                                            <dx:GridViewDataTextColumn FieldName="DetailEndTimeM" Caption="Kết thúc" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Width="188"/>
                                                                        </Columns>
                                                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                                        <SettingsContextMenu Enabled="true" EnableColumnMenu="False" />
                                                                        <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                                    </dx:ASPxGridView>
                                                                    <asp:ObjectDataSource ID="OdsLevelABA" runat="server" TypeName="ProcessListModels" SelectMethod="ProjectProcessDetailByMachineId" >
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter Name="MachineryId" SessionField="MachineryId" Type="Int32" />
                                                                        </SelectParameters>
                                                                    </asp:ObjectDataSource>
                                                                </DetailRow>
                                                            </Templates>
                                                       </dx:ASPxGridView>
                                                       <asp:ObjectDataSource ID="OdsGvLevelAB" runat="server" TypeName="ProcessListModels" SelectMethod="MachineriesList" InsertMethod="MachineriesCreated" UpdateMethod="MachineriesUpdated" DeleteMethod="MachineriesDeleted">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                            </SelectParameters>
                                                            <InsertParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                                <asp:Parameter Name="MachineryName" Type="String" />
                                                                <asp:Parameter Name="MachinerySymbol" Type="String" />
                                                                <asp:Parameter Name="MachineryStatus" Type="String" />
                                                            </InsertParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="MachineryId" Type="Int32" />
                                                                <asp:Parameter Name="MachineryName" Type="String" />
                                                                <asp:Parameter Name="MachinerySymbol" Type="String" />
                                                                <asp:Parameter Name="MachineryStatus" Type="String" />
                                                            </UpdateParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="MachineryId" Type="Int32" />
                                                            </DeleteParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Nhân viên" Visible="true">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <dx:ASPxGridView ID="GvLevelAC" ClientInstanceName="GvLevelAC" runat="server" Width="100%" DataSourceID="OdsGvLevelAC" KeyFieldName="EmployeeProcessId"
                                                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="1" OnFillContextMenuItems="GvLevelAC_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelNd_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                                <dx:GridViewDataComboBoxColumn FieldName="EmployeeId" Caption="Mã nhân viên" Width="88" Visible="false" EditFormSettings-Visible="True">
                                                                    <PropertiesComboBox DataSourceID="MinEmployeeList" TextField="EmployeeFullName" ValueField="EmployeeId" TextFormatString="{0}">
                                                                        <Columns>
                                                                            <dx:ListBoxColumn FieldName="EmployeeCode" Caption="Mã số" Width="38" />
                                                                            <dx:ListBoxColumn FieldName="EmployeeFullName" Caption="Họ tên" />   
                                                                            <dx:ListBoxColumn FieldName="EmployeeStatus" Caption="Hiện tại" />                                                                            
                                                                        </Columns>
                                                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                                    </PropertiesComboBox>
                                                                </dx:GridViewDataComboBoxColumn>
                                                                <dx:GridViewDataTextColumn FieldName="EmployeeCode" EditFormSettings-Visible="False" Caption="Mã nhân viên" Width="88" />
                                                                <dx:GridViewDataTextColumn FieldName="EmployeeFullName" EditFormSettings-Visible="False" Caption="Họ và tên" Width="288" />
                                                                <dx:GridViewDataComboBoxColumn FieldName="EmployeeGender" EditFormSettings-Visible="False" Caption="Giới tính" Width="88">
                                                                    <PropertiesComboBox DropDownStyle="DropDownList">
                                                                        <Items>
                                                                            <dx:ListEditItem Value="0" Text="Chưa biết" />
                                                                            <dx:ListEditItem Value="1" Text="Nam" />
                                                                            <dx:ListEditItem Value="2" Text="Nữ" />
                                                                        </Items>
                                                                    </PropertiesComboBox>
                                                                </dx:GridViewDataComboBoxColumn>
                                                                <dx:GridViewDataTextColumn FieldName="EmployeeDescription" EditFormSettings-Visible="False" Caption="Mô tả" />
                                                            </Columns>
                                                            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                                            <SettingsContextMenu Enabled="true" />
                                                            <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                                            <SettingsPager Mode="ShowAllRecords"/>
                                                            <SettingsBehavior ConfirmDelete="true" EnableRowHotTrack="true" />
                                                        </dx:ASPxGridView>
                                                        <asp:ObjectDataSource ID="MinEmployeeList" runat="server" TypeName="EmployeeModels" SelectMethod="MinEmployeeListBySubListId">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                        <asp:ObjectDataSource ID="OdsGvLevelAC" runat="server" TypeName="EmployeeModels" SelectMethod="EmployeeProcessList" InsertMethod="EmployeeProcessCreated" DeleteMethod="EmployeeProcessDeleted">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                            </SelectParameters>
                                                            <InsertParameters>
                                                                <asp:SessionParameter Name="SubProcessListID" SessionField="SubProcessListID" Type="Int32" />
                                                                <asp:Parameter Name="EmployeeId" Type="Int32" />
                                                            </InsertParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="EmployeeProcessId" Type="Int32" />
                                                            </DeleteParameters>
                                                        </asp:ObjectDataSource>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>            
                                </DetailRow>
                                <EditForm>
                                    <div style="padding:8px;">
                                        <dx:ASPxGridViewTemplateReplacement ID="dxEditors" ReplacementType="EditFormEditors" runat="server" />                                                                                    
                                    </div>
                                    <div class="bottomCmd" style="border-top:1px solid #A8A8A8;padding-top:3px">
                                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                        <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                    </div>
                                </EditForm>
                            </Templates>
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsGvLevelA" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessList" InsertMethod="ProcessListCreated" UpdateMethod="ProcessListUpdated" DeleteMethod="ProcessListDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="ProcessListName" Type="String" />
                                <asp:Parameter Name="ProcessListGroup" Type="String" />
                                <asp:Parameter Name="ProcessListStatus" Type="String" />
                                <asp:Parameter Name="DXNhanDuKien" Type="Boolean" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ProcessListId" Type="Int32" />
                                <asp:Parameter Name="ProcessListName" Type="String" />
                                <asp:Parameter Name="ProcessListGroup" Type="String" />
                                <asp:Parameter Name="ProcessListStatus" Type="String" />
                                <asp:Parameter Name="DXNhanDuKien" Type="Boolean" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="ProcessListId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="EmployeeTab" Text="Danh sách Nhân viên" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="EmployeeTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelB" ClientInstanceName="GvLevelB" runat="server" Width="100%" DataSourceID="OdsLevelA" KeyFieldName="EmployeeId" 
                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="3" OnFillContextMenuItems="GvLevelB_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText"> 
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="EmployeeCode" Caption="Mã số" Width="100"/>
                                <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="EmployeeLastName" Caption="Họ" Width="148"/>
                                <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="EmployeeFirstName" Caption="Tên" Width="100" />
                                <dx:GridViewDataTextColumn VisibleIndex="4" FieldName="EmployeeTel" Caption="Điện thoại" Width="128" />
                                <dx:GridViewDataDateColumn VisibleIndex="5" FieldName="EmployeeDateOfBirth" Caption="Ngày sinh" Width="128" />
                                <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="EmployeeGender" Caption="Giới tính" Width="100">
                                    <PropertiesComboBox DropDownStyle="DropDownList">
                                        <Items>
                                            <dx:ListEditItem Value="0" Text="Chưa biết" />
                                            <dx:ListEditItem Value="1" Text="Nam" />
                                            <dx:ListEditItem Value="2" Text="Nữ" />
                                        </Items>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn VisibleIndex="7" FieldName="EmployeeStatus" Caption="Hiện tại" Width="100">
                                    <PropertiesComboBox DropDownStyle="DropDownList">
                                        <Items>
                                            <dx:ListEditItem Value="Đang làm" Text="Đang làm" />
                                            <dx:ListEditItem Value="Đã Nghỉ việc" Text="Đã Nghỉ việc" />
                                            <dx:ListEditItem Value="Không xác định" Text="Không xác định" />
                                        </Items>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataTextColumn VisibleIndex="7" EditFormSettings-ColumnSpan="2" FieldName="EmployeeDescription" Caption="Giới thiệu" />
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelA" runat="server" TypeName="EmployeeModels" SelectMethod="EmployeeList" InsertMethod="EmployeeCreated" UpdateMethod="EmployeeUpdated" DeleteMethod="EmployeeDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="EmployeeCode" Type="String" />
                                <asp:Parameter Name="EmployeeLastName" Type="String" />
                                <asp:Parameter Name="EmployeeFirstName" Type="String" />
                                <asp:Parameter Name="EmployeeTel" Type="String" />  
                                <asp:Parameter Name="EmployeeDateOfBirth" Type="DateTime" />
                                <asp:Parameter Name="EmployeeGender" Type="Int32" />
                                <asp:Parameter Name="EmployeeStatus" Type="String" />
                                <asp:Parameter Name="EmployeeDescription" Type="String" />                  
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="EmployeeId" Type="Int32" />
                                <asp:Parameter Name="EmployeeCode" Type="String" />
                                <asp:Parameter Name="EmployeeLastName" Type="String" />
                                <asp:Parameter Name="EmployeeFirstName" Type="String" />
                                <asp:Parameter Name="EmployeeTel" Type="String" />  
                                <asp:Parameter Name="EmployeeDateOfBirth" Type="DateTime" />
                                <asp:Parameter Name="EmployeeGender" Type="Int32" />
                                <asp:Parameter Name="EmployeeStatus" Type="String" />
                                <asp:Parameter Name="EmployeeDescription" Type="String" />         
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="EmployeeId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

