<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="OrdersList.aspx.cs" Inherits="CMSTemplates_OrdersList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function AdjustSize() {
            var TabHeight = 28;
            var ControlHeight = 27;
            var MainHeight = ASPxClientUtils.GetDocumentClientHeight();
            if (document.body.scrollHeight > MainHeight) { MainHeight = document.body.scrollHeight; }
            var GridHeight = MainHeight - HeaderPanel.GetHeight() - FooterPanel.GetHeight() - TabHeight;
            if (typeof GvLevelA !== 'undefined') { GvLevelA.SetHeight(0); GvLevelA.SetHeight(GridHeight); }
            if (typeof GvLevelB !== 'undefined') { GvLevelB.SetHeight(0); GvLevelB.SetHeight(GridHeight - ControlHeight); }
            if (typeof GvLevelC !== 'undefined') { GvLevelC.SetHeight(0); GvLevelC.SetHeight(GridHeight); }
            if (typeof GvLevelD !== 'undefined') { GvLevelD.SetHeight(0); GvLevelD.SetHeight(GridHeight); }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
    <dx:ASPxPageControl ID="PageControl" ClientInstanceName="PageControl" Width="100%" runat="server" ActiveTabIndex="0" OnLoad="PageControl_Load">
        <ActiveTabStyle BorderBottom-BorderColor="#A8A8A8" />
        <ContentStyle BorderRight-BorderWidth="0" BorderLeft-BorderWidth="0" BorderBottom-BorderWidth="0" Paddings-Padding="0" />
        <TabPages>
            <dx:TabPage Name="OrdersListTab" Text="Danh sách đơn hàng" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="OrdersListTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsLevelA" KeyFieldName="ProjectTaskID"
                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelA_FillContextMenuItems" SettingsEditing-EditFormColumnCount="3" OnCustomColumnDisplayText="OnCustomColumnDisplayText" OnContextMenuItemClick="GvLevelA_ContextMenuItemClick" OnInitNewRow="GvLevelA_InitNewRow">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" Width="200" FixedStyle="Left" />  
                                <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="ProjectTaskOverlayNum" Caption="Số phủ" Width="120" FixedStyle="Left" /> 
                                <dx:GridViewDataSpinEditColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="ProjectTaskHoleNum" Caption="Số lỗ" Width="88" PropertiesSpinEdit-NumberType="Integer" />
                                <dx:GridViewDataSpinEditColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="ProjectTaskDiameterOut" Caption="ĐK ngoài" Width="88" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DecimalPlaces="2" />
                                <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="ProjectTaskMaterialsRequire" Caption="NVL KH yêu cầu" Width="128" />  
                                <dx:GridViewDataComboBoxColumn VisibleIndex="6" EditFormSettings-VisibleIndex="6" FieldName="ProjectTaskMaterialsCode" Caption="NVL thay thế" Width="100">
                                    <PropertiesComboBox DataSourceID="OdsMaterials" TextField="ProjectTaskMaterialsCode" ValueField="ProjectTaskMaterialsCode" ValueType="System.String" DropDownStyle="DropDown" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn VisibleIndex="7" EditFormSettings-VisibleIndex="7" FieldName="ProjectTaskMoldsId" Caption="Phân loại" Width="88">
                                    <PropertiesComboBox DataSourceID="OdsMolds" TextField="MoldsName" ValueField="MoldsId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith" TextFormatString="{0}" EnableSynchronization="False">
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="MoldsName" Width="88" Caption="Loại" />
                                            <dx:ListBoxColumn FieldName="MoldsFactor" Width="48" Caption="Hệ số" />
                                        </Columns>
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>                                
                                <dx:GridViewDataSpinEditColumn VisibleIndex="8" EditFormSettings-VisibleIndex="8" FieldName="ProjectTaskThickness" Caption="Bề dày" Width="88" PropertiesSpinEdit-NumberType="Integer" />
                                <dx:GridViewDataTextColumn VisibleIndex="9" EditFormSettings-VisibleIndex="9" FieldName="ProjectTaskThicknessTotal" Caption="Tổng bề dày" Width="100" />
                                <dx:GridViewDataSpinEditColumn VisibleIndex="10" EditFormSettings-VisibleIndex="10" FieldName="ProjectTaskQuantities" Caption="Số lượng" Width="88" PropertiesSpinEdit-NumberType="Integer" />
                                <dx:GridViewDataTextColumn VisibleIndex="11" EditFormSettings-VisibleIndex="11" FieldName="ProjectTaskContainHead" Caption="Đầu chùa" Width="88" />  
                                <dx:GridViewDataTextColumn VisibleIndex="12" EditFormSettings-VisibleIndex="12" FieldName="ProjectTaskBottoHob" Caption="Botto tiện" Width="88" />
                                <dx:GridViewDataTextColumn VisibleIndex="13" EditFormSettings-VisibleIndex="13" FieldName="ProjectTaskChildNote" Caption="Chú thích con cái" Width="128" />  
                                <dx:GridViewDataTextColumn VisibleIndex="14" EditFormSettings-VisibleIndex="14" FieldName="ProjectTaskHorikomi" Caption="Horikomi" Width="88" /> 
                                <dx:GridViewDataComboBoxColumn VisibleIndex="15" EditFormSettings-VisibleIndex="15" FieldName="ProjectTaskHardness" Caption="Độ cứng" Width="88">
                                    <PropertiesComboBox DataSourceID="OdsHardness" TextField="ProjectTaskHardness" ValueField="ProjectTaskHardness" ValueType="System.String" DropDownStyle="DropDown" />
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn VisibleIndex="16" EditFormSettings-VisibleIndex="0" FieldName="ProjectTaskCustomerId" Caption="Khách hàng" Width="128">
                                    <PropertiesComboBox DataSourceID="OdsCustomer" TextField="CustomerName" ValueField="CustomerId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>   
                                <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienThoQuaTinh" Caption="Dự kiến: Thô qua Tinh" VisibleIndex="17" Width="148"> 
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienTinhQuaQA" Caption="Dự kiến: Tinh qua QA" VisibleIndex="17" Width="148"> 
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienXuatHang" Caption="Dự kiến: Xuất hàng" VisibleIndex="17" Width="148"> 
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="ProjectTaskTransmit" Caption="Ngày nhận" VisibleIndex="17" Width="128"> 
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn FieldName="ProjectTaskDeadline" Caption="Ngày hoàn thành" VisibleIndex="18" Width="128">                                    
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm"> 
                                        <DateRangeSettings StartDateEditID="ProjectTaskTransmit" />                                       
                                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
            	                        <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
	                                </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataMemoColumn FieldName="ProjectTaskDescription" Caption="Mô tả" VisibleIndex="23" MinWidth="348" />                                            
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" ContextMenuItemClick="function(s,e) { if (e.item.name == 'CloneProduct') e.processOnServer = true; }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="50" FirstPageButton-Visible="true" LastPageButton-Visible="true" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" Summary-Text="Trang {0} / {1} (Số dòng: {2}):" PageSizeItemSettings-Caption="Số dòng 1 trang:" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Visible" />
                            <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
                            <SettingsPopup EditForm-Width="480" EditForm-Modal="true" EditForm-HorizontalAlign="WindowCenter" EditForm-VerticalAlign="WindowCenter" />  
                            <StylesPopup EditForm-Header-Font-Bold="true" EditForm-Header-Paddings-Padding="5" EditForm-Header-Paddings-PaddingTop="7" />
                            <SettingsText PopupEditFormCaption="Cập nhật dữ liệu" CommandUpdate="Cập nhật" CommandCancel="Hủy bỏ" />
                            <SettingsSearchPanel CustomEditorID="dxTxtSearch" />
                            <Templates>
                                <EditForm>
                                    <div style="padding:8px;overflow-y:scroll;height:408px">
                                        <dx:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors" runat="server" />                                                                                    
                                    </div>
                                    <div class="bottomCmd" style="border-top:1px solid #A8A8A8;padding-top:3px">
                                        <dx:ASPxCheckBox ID="CkMethod" Checked="true" Text="Nhập liên tiếp." runat="server" />
                                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                        <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                    </div>
                                </EditForm>
                                <PagerBar>
                                    <table style="width:100%;border-spacing:0">
                                        <tr>
                                            <td style="text-align:right;padding-right:3px">
                                                <dx:ASPxLabel ID="dxLblNotes" runat="server" Text="Nội dung tìm kiếm:" />
                                            </td>
                                            <td style="width:128px;text-align:right;padding-right:3px">
                                                <dx:ASPxTextBox ID="dxTxtSearch" runat="server" NullText="Nhập dữ liệu cần tìm ..." Width="255" />
                                            </td>
                                            <td>
                                                <dx:ASPxGridViewTemplateReplacement ID="dxEditors" ReplacementType="Pager" runat="server" />                                   
                                            </td>                                            
                                        </tr>
                                    </table>
                                </PagerBar>
                            </Templates>
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsMinProcessList" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessList" />
                        <asp:ObjectDataSource ID="OdsHardness" runat="server" TypeName="OrdersModels" SelectMethod="HardnessInOrders" />
                        <asp:ObjectDataSource ID="OdsMolds" runat="server" TypeName="MoldsModels" SelectMethod="MinMoldsList" />
                        <asp:ObjectDataSource ID="OdsMaterials" runat="server" TypeName="OrdersModels" SelectMethod="MaterialInOrders" />
                        <asp:ObjectDataSource ID="OdsCustomer" runat="server" TypeName="CustomerModels" SelectMethod="MinCustomerList" />
                        <asp:ObjectDataSource ID="OdsLevelA" runat="server" TypeName="OrdersModels" SelectMethod="OrdersList" InsertMethod="OrdersCreated" UpdateMethod="OrdersUpdated" DeleteMethod="OrdersDeleted" OnInserted="OdsLevelA_Inserted">
                            <InsertParameters>
                                <asp:Parameter Name="ProjectTaskMoldCode" Type="String" />
                                <asp:Parameter Name="ProjectTaskOverlayNum" Type="String" />
                                <asp:Parameter Name="ProjectTaskHoleNum" Type="String" />
                                <asp:Parameter Name="ProjectTaskDiameterOut" Type="Decimal" />  
                                <asp:Parameter Name="ProjectTaskMaterialsRequire" Type="String" />
                                <asp:Parameter Name="ProjectTaskMaterialsCode" Type="String" />
                                <asp:Parameter Name="ProjectTaskMoldsId" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskThickness" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskThicknessTotal" Type="String" />
                                <asp:Parameter Name="ProjectTaskQuantities" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskContainHead" Type="String" />
                                <asp:Parameter Name="ProjectTaskBottoHob" Type="String" />
                                <asp:Parameter Name="ProjectTaskChildNote" Type="String" />
                                <asp:Parameter Name="ProjectTaskHorikomi" Type="String" />
                                <asp:Parameter Name="ProjectTaskHardness" Type="String" />
                                <asp:Parameter Name="ProjectTaskCustomerId" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskDuKienThoQuaTinh" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDuKienTinhQuaQA" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDuKienXuatHang" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDeadline" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskTransmit" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDescription" Type="String" /> 
                                                              
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ProjectTaskID" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskMoldCode" Type="String" />
                                <asp:Parameter Name="ProjectTaskOverlayNum" Type="String" />
                                <asp:Parameter Name="ProjectTaskHoleNum" Type="String" />
                                <asp:Parameter Name="ProjectTaskDiameterOut" Type="Decimal" />  
                                <asp:Parameter Name="ProjectTaskMaterialsRequire" Type="String" />
                                <asp:Parameter Name="ProjectTaskMaterialsCode" Type="String" />
                                <asp:Parameter Name="ProjectTaskMoldsId" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskThickness" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskThicknessTotal" Type="String" />
                                <asp:Parameter Name="ProjectTaskQuantities" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskContainHead" Type="String" />
                                <asp:Parameter Name="ProjectTaskBottoHob" Type="String" />
                                <asp:Parameter Name="ProjectTaskChildNote" Type="String" />
                                <asp:Parameter Name="ProjectTaskHorikomi" Type="String" />
                                <asp:Parameter Name="ProjectTaskHardness" Type="String" />
                                <asp:Parameter Name="ProjectTaskCustomerId" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskDuKienThoQuaTinh" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDuKienTinhQuaQA" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDuKienXuatHang" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDeadline" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskTransmit" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDescription" Type="String" />     
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="ProjectTaskID" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="OrdersListNdTab" Text="Quản lý đơn hàng" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="OrdersListNdTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelB" ClientInstanceName="GvLevelB" runat="server" Width="100%" DataSourceID="OdsLevelB" KeyFieldName="ProjectTaskID"
                            Border-BorderWidth="0" BorderBottom-BorderWidth="1" OnFillContextMenuItems="GvLevelB_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                            <Columns>                                
                                <dx:GridViewBandColumn Caption="Dữ liệu thông tin đơn hàng" VisibleIndex="0">
                                    <Columns>
                                        <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="48" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                        <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" Width="200" FixedStyle="Left" EditFormSettings-Visible="False" />  
                                        <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="ProjectTaskOverlayNum" Caption="Số phủ" Width="120" FixedStyle="Left" EditFormSettings-Visible="False" /> 
                                        <dx:GridViewDataSpinEditColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="ProjectTaskDiameterOut" Caption="ĐK ngoài" Width="88" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DecimalPlaces="2" EditFormSettings-Visible="False" />
                                        <dx:GridViewDataSpinEditColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="ProjectTaskThickness" Caption="Bề dày" Width="88" PropertiesSpinEdit-NumberType="Integer" EditFormSettings-Visible="False" />
                                        <dx:GridViewDataComboBoxColumn VisibleIndex="7" EditFormSettings-VisibleIndex="7" FieldName="ProjectTaskMoldsId" Caption="Phân loại" Width="88" EditFormSettings-Visible="False">
                                            <PropertiesComboBox DataSourceID="OdsMolds" TextField="MoldsName" ValueField="MoldsId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith" TextFormatString="{0}" EnableSynchronization="False">
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="MoldsName" Width="88" Caption="Loại" />
                                                    <dx:ListBoxColumn FieldName="MoldsFactor" Width="48" Caption="Hệ số" />
                                                </Columns>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>                                
                                        <dx:GridViewDataSpinEditColumn VisibleIndex="10" EditFormSettings-VisibleIndex="10" FieldName="ProjectTaskQuantities" Caption="Số lượng" Width="78" PropertiesSpinEdit-NumberType="Integer" EditFormSettings-Visible="False" />
                                        <dx:GridViewDataComboBoxColumn VisibleIndex="14" EditFormSettings-VisibleIndex="0" FieldName="ProjectTaskCustomerId" Caption="Khách hàng" Width="100" EditFormSettings-Visible="False">
                                            <PropertiesComboBox DataSourceID="OdsCustomer" TextField="CustomerName" ValueField="CustomerId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>  
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </dx:GridViewBandColumn> 
                                <dx:GridViewBandColumn Caption="Dự kiến / Thực tế: Thô qua Tinh" VisibleIndex="15">
                                    <Columns>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienThoQuaTinh" Caption="Dự kiến" EditFormSettings-Caption="Dự kiến Thô qua Tinh" Width="120" VisibleIndex="15"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskThucTeThoQuaTinh" Caption="Thực tế" EditFormSettings-Caption="Thực tế Thô qua Tinh" Width="120" VisibleIndex="15">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="" Caption="Kết quả" Width="118" VisibleIndex="15" EditFormSettings-Visible="False" /> 
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn Caption="Dự kiến / Thực tế: Tinh qua QA" VisibleIndex="16">
                                    <Columns>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienTinhQuaQA" Caption="Dự kiến" EditFormSettings-Caption="Dự kiến Tinh qua QA" Width="120" VisibleIndex="16"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskThucTeTinhQuaQA" Caption="Thực tế" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn Caption="Dự kiến / Thực tế: Xuất hàng" VisibleIndex="17">
                                    <Columns>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienXuatHang" Caption="Dự kiến" EditFormSettings-Caption="Dự kiến Xuất hàng" Width="120" VisibleIndex="17"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskThucTeXuatHang" Caption="Thực tế" EditFormSettings-Caption="Thực tế Xuất hàng" Width="120" VisibleIndex="17"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn Caption="Dữ liệu trạng thái đơn hàng" VisibleIndex="18">
                                    <Columns>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskTransmit" Caption="Ngày nhận" VisibleIndex="18" Width="118"> 
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataDateColumn FieldName="ProjectTaskDeadline" Caption="Ngày hoàn thành" VisibleIndex="18" Width="120">
                                            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm">
                                                <DateRangeSettings StartDateEditID="ProjectTaskTransmit" />    
                                                <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
            	                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
	                                    </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataSpinEditColumn VisibleIndex="20" EditFormSettings-VisibleIndex="20" FieldName="ProjectTaskPrice" Caption="Đơn giá" Width="108" PropertiesSpinEdit-NumberFormat="Currency" PropertiesSpinEdit-DisplayFormatString="{0:C}" PropertiesSpinEdit-DisplayFormatInEditMode="true" />
                                        <dx:GridViewDataSpinEditColumn VisibleIndex="20" EditFormSettings-VisibleIndex="20" FieldName="ProjectTaskPriceCalc" Caption="Thành tiền" Width="108" PropertiesSpinEdit-NumberFormat="Currency" PropertiesSpinEdit-DisplayFormatString="{0:C}" EditFormSettings-Visible="False" />
                                        <dx:GridViewDataComboBoxColumn VisibleIndex="21" EditFormSettings-VisibleIndex="21" FieldName="ProjectTaskStatusID" Caption="Trạng thái" Width="88">
                                            <PropertiesComboBox DataSourceID="OdsTaskStatus" TextField="TaskStatusDisplayName" ValueField="TaskStatusID" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                        <dx:GridViewDataComboBoxColumn VisibleIndex="22" EditFormSettings-VisibleIndex="22" FieldName="ProjectTaskPriorityID" Caption="Độ ưu tiên">
                                            <PropertiesComboBox DataSourceID="OdsTaskPriority" TextField="TaskPriorityDisplayName" ValueField="TaskPriorityID" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>
                                <HeaderStyle HorizontalAlign="Left" />
                            </dx:GridViewBandColumn>
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="50" FirstPageButton-Visible="true" LastPageButton-Visible="true" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" Summary-Text="Trang {0} / {1} (Số dòng: {2}):" PageSizeItemSettings-Caption="Số dòng 1 trang:" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Visible" />
                            <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
                            <SettingsPopup EditForm-Width="480" EditForm-Modal="true" EditForm-HorizontalAlign="WindowCenter" EditForm-VerticalAlign="WindowCenter" />
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true" />
                            <Styles DetailCell-Paddings-Padding="0" DetailCell-Paddings-PaddingBottom="8" />
                            <StylesPopup EditForm-Header-Font-Bold="true" EditForm-Header-Paddings-Padding="5" EditForm-Header-Paddings-PaddingTop="7" />
                            <SettingsText PopupEditFormCaption="Cập nhật dữ liệu" CommandUpdate="Cập nhật" CommandCancel="Hủy bỏ" />
                            <SettingsSearchPanel CustomEditorID="dxTxtSearchGvLevelB" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxGridView ID="GvLevelBA" ClientInstanceName="GvLevelBA" runat="server" Width="100%" DataSourceID="OdsLevelBA" KeyFieldName="ProcessId" SettingsEditing-EditFormColumnCount="1"
                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" BorderTop-BorderWidth="0" 
                                        OnFillContextMenuItems="GvLevelBA_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelBA_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                                        <Columns>
                                            <dx:GridViewBandColumn Caption="Dữ liệu công đoạn" VisibleIndex="0">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="34" Settings-AllowSort="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                                    <dx:GridViewDataComboBoxColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="ProcessListId" Caption="Công đoạn Id" Width="48" Visible="false" EditFormSettings-Visible="True">
                                                        <PropertiesComboBox DataSourceID="OdsProcessListNotInTaskId" TextField="ProcessListName" ValueField="ProcessListId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                        </PropertiesComboBox>
                                                    </dx:GridViewDataComboBoxColumn>
                                                    <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="ProcessListName" Caption="Công đoạn" Width="307" EditFormSettings-Visible="False" /> 
                                                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="ProcessListgroup" Caption="Nhóm công đoạn" Width="253" EditFormSettings-Visible="False" ReadOnly="true">
                                                        <PropertiesComboBox DropDownStyle="DropDownList">
                                                            <Items>
                                                                <dx:ListEditItem Value="dataTho" Text="Bộ phận Thô" />
                                                                <dx:ListEditItem Value="dataTinh" Text="Bộ phận Tinh" />
                                                                <dx:ListEditItem Value="dataQA" Text="Bộ phận QA" />
                                                            </Items>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                        </PropertiesComboBox>
                                                    </dx:GridViewDataComboBoxColumn>
                                                </Columns>
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </dx:GridViewBandColumn>
                                            <dx:GridViewBandColumn Caption="Dữ liệu trạng thái" VisibleIndex="1">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn VisibleIndex="11" FieldName="ProcessExpectedTime" Caption="Thời gian dự kiến" Width="107" EditFormSettings-Visible="False"> 
                                                        <PropertiesTextEdit DisplayFormatString="{0} giờ." />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn VisibleIndex="11" FieldName="ProcessFactTime" Caption="Thời gian thực tế" Width="107" EditFormSettings-Visible="False"> 
                                                        <PropertiesTextEdit DisplayFormatString="{0} giờ." />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataComboBoxColumn VisibleIndex="13" FieldName="" Caption="Trạng thái" Width="107" EditFormSettings-Visible="False">
                                                        <PropertiesComboBox DropDownStyle="DropDownList">
                                                            <Items>
                                                                <dx:ListEditItem Value="0" Text="Không xác định" Selected="true" />
                                                                <dx:ListEditItem Value="1" Text="Đang chạy" />
                                                                <dx:ListEditItem Value="2" Text="Hoàn thành" />
                                                                <dx:ListEditItem Value="3" Text="Hỗ trợ" />
                                                            </Items>
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                        </PropertiesComboBox>
                                                    </dx:GridViewDataComboBoxColumn> 
                                                    <dx:GridViewDataTextColumn VisibleIndex="14" FieldName="ProcessNotes" Caption="Ghi chú" MinWidth="348" Width="585" EditFormSettings-Visible="False" /> 
                                                    <dx:GridViewDataTextColumn VisibleIndex="15" FieldName="UserModified" Caption="Cập nhật bởi" MinWidth="148" EditFormSettings-Visible="False" /> 
                                                    <dx:GridViewDataDateColumn VisibleIndex="16" FieldName="DateModified" Caption="Cập nhật lúc" Width="120" EditFormSettings-Visible="False"> 
                                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                                                            <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                                                        </PropertiesDateEdit>
                                                    </dx:GridViewDataDateColumn>
                                                </Columns>
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </dx:GridViewBandColumn>
                                        </Columns>
                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                        <SettingsContextMenu Enabled="true" EnableColumnMenu="False" />
                                        <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />
                                        <SettingsPopup EditForm-Width="480" EditForm-Modal="true" EditForm-HorizontalAlign="WindowCenter" EditForm-VerticalAlign="WindowCenter" />
                                        <StylesPopup EditForm-Header-Font-Bold="true" EditForm-Header-Paddings-Padding="5" EditForm-Header-Paddings-PaddingTop="7" />
                                        <SettingsText PopupEditFormCaption="Cập nhật dữ liệu" CommandUpdate="Cập nhật" CommandCancel="Hủy bỏ" />
                                        <Templates>
                                            <EditForm>
                                                <div style="padding:8px">
                                                    <dx:ASPxGridViewTemplateReplacement ID="dxEditors" ReplacementType="EditFormEditors" runat="server" />                                                                                    
                                                </div>
                                                <div class="bottomCmd" style="border-top:1px solid #A8A8A8;padding-top:3px">
                                                    <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                                    <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                                </div>
                                            </EditForm>
                                        </Templates>
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="OdsProcessListNotInTaskId" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessListNotInTaskId">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="OdsLevelBA" runat="server" TypeName="OrdersModels" SelectMethod="ProjectProcessListByProjectTaskID" InsertMethod="ProjectProcessCreated" DeleteMethod="ProjectProcessDeleted">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
                                            <asp:Parameter Name="ProcessListId" Type="Int32" />
                                        </InsertParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="ProcessId" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:ObjectDataSource>
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
                                <PagerBar>
                                    <table style="width:100%;border-spacing:0">
                                        <tr>
                                            <td style="text-align:right;padding-right:3px">
                                                <dx:ASPxLabel ID="dxLblNotes" runat="server" Text="Nội dung tìm kiếm:" />
                                            </td>
                                            <td style="width:128px;text-align:right;padding-right:3px">
                                                <dx:ASPxTextBox ID="dxTxtSearchGvLevelB" runat="server" NullText="Nhập dữ liệu cần tìm ..." Width="255" />
                                            </td>
                                            <td>
                                                <dx:ASPxGridViewTemplateReplacement ID="dxEditors" ReplacementType="Pager" runat="server" />                                   
                                            </td>                                            
                                        </tr>
                                    </table>
                                </PagerBar>
                            </Templates>
                        </dx:ASPxGridView> 
                        <dx:ASPxGridViewExporter ID="GvExport" runat="server" GridViewID="GvLevelB" />
                        <asp:ObjectDataSource ID="OdsTaskStatus" runat="server" TypeName="OrdersModels" SelectMethod="TaskStatusList" />
                        <asp:ObjectDataSource ID="OdsTaskPriority" runat="server" TypeName="OrdersModels" SelectMethod="TaskPriorityList" />
                        <asp:ObjectDataSource ID="OdsLevelB" runat="server" TypeName="OrdersModels" SelectMethod="OrdersListNd" UpdateMethod="OrdersUpdatedNd">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MainPanel$plcMain$PageControl$CbTaskStatus" Name="TaskStatus" Type="String" />
                                <asp:ControlParameter ControlID="MainPanel$plcMain$PageControl$CbTaskPriority" Name="TaskPriority" Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ProjectTaskID" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskStatusID" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskPriorityID" Type="Int32" />
                                <asp:Parameter Name="ProjectTaskPrice" Type="Decimal" />
                                <asp:Parameter Name="ProjectTaskDeadline" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskTransmit" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDescription" Type="String" />    
                                <asp:Parameter Name="ProjectTaskDuKienThoQuaTinh" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskThucTeThoQuaTinh" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskDuKienTinhQuaQA" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskThucTeTinhQuaQA" Type="DateTime" /> 
                                <asp:Parameter Name="ProjectTaskDuKienXuatHang" Type="DateTime" />
                                <asp:Parameter Name="ProjectTaskThucTeXuatHang" Type="DateTime" /> 
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <table style="width:100%;border-spacing:0">
                            <tr>
                                <td style="text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="dxLblNotes" runat="server" Text="Chọn [ Trạng thái / Độ ưu tiên ]: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;text-align:right;padding-right:3px">
                                    <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbTaskStatus" OnTextChanged="CbTaskData_TextChanged" ClientSideEvents-TextChanged="function(s, e) { GvLevelB.PerformCallback();}">
                                        <Items>
                                            <dx:ListEditItem Text="Chọn tất cả" Value="2;3;6;7" Selected="true" />
                                            <dx:ListEditItem Text="Chưa bắt đầu" Value="2" />
                                            <dx:ListEditItem Text="Đang chạy" Value="3" />
                                            <dx:ListEditItem Text="Bị hủy bỏ" Value="6" />
                                            <dx:ListEditItem Text="Hoàn thành" Value="7" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                                <td style="width:128px;text-align:right;padding-right:3px">
                                    <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbTaskPriority" OnTextChanged="CbTaskData_TextChanged" ClientSideEvents-TextChanged="function(s, e) { GvLevelB.PerformCallback();}">
                                        <Items>
                                            <dx:ListEditItem Text="Chọn tất cả" Value="2;3;4" Selected="true" />
                                            <dx:ListEditItem Text="Ưu tiên cao" Value="2" />
                                            <dx:ListEditItem Text="Bình thường" Value="3" />
                                            <dx:ListEditItem Text="Không ưu tiên" Value="4" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>                                
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxLabel ID="GvLevelCLabelE" runat="server" Text="Xuất dữ liệu: " Font-Bold="true" />
                                </td>
                                <td style="width:128px;text-align:right;padding-right:3px">
                                    <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbExportMode" ClientSideEvents-TextChanged="function(s, e) { GvLevelB.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLS" UseSubmitBehavior="False" OnClick="btnXlsExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelB.PerformCallback();}" />
                                </td>
                                <td style="width:100px;text-align:right;padding-right:3px">
                                    <dx:ASPxButton ID="btnXlsxExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLSX" UseSubmitBehavior="False" OnClick="btnXlsxExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelB.PerformCallback();}" />
                                </td>
                            </tr>
                        </table> 
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="CustomerTab" Text="Khách hàng" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>
                    <dx:ContentControl ID="CustomerTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelC" ClientInstanceName="GvLevelC" runat="server" Width="100%" DataSourceID="OdsLevelC" KeyFieldName="CustomerId"
                            Border-BorderWidth="0" OnFillContextMenuItems="GvLevelC_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="CustomerName" Caption="Khách hàng" Width="228">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn> 
                                <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="CustomerPhone" Caption="Điện thoại" Width="128" />  
                                <dx:GridViewDataTextColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="CustomerEmail" Caption="E-mail" Width="128" />                                  
                                <dx:GridViewDataTextColumn VisibleIndex="4" EditFormSettings-VisibleIndex="4" FieldName="CustomerAddress" Caption="Địa chỉ" MinWidth="288" />  
                                <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="UserModified" Caption="Cập nhật bởi" Width="188" EditFormSettings-Visible="False" />                                                             
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" FirstPageButton-Visible="true" LastPageButton-Visible="true" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" Summary-Text="Trang {0} / {1} (Số dòng: {2}):" PageSizeItemSettings-Caption="Số dòng 1 trang:" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelC" runat="server" TypeName="CustomerModels" SelectMethod="CustomerList" InsertMethod="CustomerCreated" UpdateMethod="CustomerUpdated" DeleteMethod="CustomerDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="CustomerName" Type="String" />
                                <asp:Parameter Name="CustomerPhone" Type="String" />
                                <asp:Parameter Name="CustomerEmail" Type="String" />
                                <asp:Parameter Name="CustomerAddress" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CustomerId" Type="Int32" />
                                <asp:Parameter Name="CustomerName" Type="String" />
                                <asp:Parameter Name="CustomerPhone" Type="String" />
                                <asp:Parameter Name="CustomerEmail" Type="String" />
                                <asp:Parameter Name="CustomerAddress" Type="String" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="CustomerId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="MoldsTab" Text="Loại khuôn" TabStyle-Font-Names="Arial" TabStyle-Width="100%">
                <ContentCollection>                    
                    <dx:ContentControl ID="MoldsTab" Visible="true" runat="server">
                        <dx:ASPxGridView ID="GvLevelD" ClientInstanceName="GvLevelD" runat="server" Width="100%" DataSourceID="OdsLevelD" KeyFieldName="MoldsId"
                            Border-BorderWidth="0" SettingsEditing-EditFormColumnCount="3" OnFillContextMenuItems="GvLevelD_FillContextMenuItems" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                            <Columns>
                                <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="58" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                <dx:GridViewDataTextColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="MoldsName" Caption="Loại khuôn" MinWidth="188">
                                    <PropertiesTextEdit ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataSpinEditColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="MoldsMinScheduledDays" Caption="Ngày dự kiến tối thiểu" Width="188">
                                    <PropertiesSpinEdit NumberType="Integer" MaxValue="30" ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn VisibleIndex="3" EditFormSettings-VisibleIndex="3" FieldName="MoldsFactor" Caption="Hệ số" Width="188">
                                    <PropertiesSpinEdit DecimalPlaces="2" MaxValue="30" ValidationSettings-Display="Dynamic" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-RequiredField-ErrorText="Data is required." />
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataTextColumn VisibleIndex="5" EditFormSettings-VisibleIndex="5" FieldName="UserModified" Caption="Cập nhật bởi" Width="188" EditFormSettings-Visible="False" />
                            </Columns>
                            <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" ColumnResized="function(s, e) { OnColumnResized(s, e, 0); }" />
                            <SettingsContextMenu Enabled="true" />
                            <SettingsPager Mode="ShowPager" PageSize="20" FirstPageButton-Visible="true" LastPageButton-Visible="true" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" Summary-Text="Trang {0} / {1} (Số dòng: {2}):" PageSizeItemSettings-Caption="Số dòng 1 trang:" />
                            <SettingsBehavior AllowDragDrop="true" ConfirmDelete="true" ColumnResizeMode="Control" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                            <Settings ShowHeaderFilterButton="true" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden" />
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true"/>
                            <Styles DetailCell-Paddings-Padding="0" DetailCell-Paddings-PaddingBottom="8" />
                            <Templates>
                                <DetailRow>
                                    <dx:ASPxGridView ID="GvLevelDA" ClientInstanceName="GvLevelDA" runat="server" Width="100%" DataSourceID="OdsLevelDA" KeyFieldName="MoldsProcessId" SettingsEditing-EditFormColumnCount="1"
                                        Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" BorderTop-BorderWidth="0" 
                                        OnFillContextMenuItems="GvLevelDA_FillContextMenuItems" OnBeforePerformDataSelect="GvLevelDA_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">                                    
                                        <Columns>
                                            <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="44" Settings-AllowSort="False" EditFormSettings-Visible="False" UnboundType="String" FixedStyle="Left" />
                                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" EditFormSettings-VisibleIndex="1" FieldName="ProcessListId" Caption="Công đoạn đơn hàng" MinWidth="228" Visible="false" EditFormSettings-Visible="True">
                                                <PropertiesComboBox DataSourceID="OdsProcessListNotInMoldsId" TextField="ProcessListName" ValueField="ProcessListId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
                                                </PropertiesComboBox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="ProcessListName" Caption="Công đoạn đơn hàng" MinWidth="228" EditFormSettings-Visible="False" />                                                             
                                            <dx:GridViewDataTextColumn VisibleIndex="2" EditFormSettings-VisibleIndex="2" FieldName="UserModified" Caption="Cập nhật bởi" Width="175" EditFormSettings-Visible="False" />                                                             
                                        </Columns>
                                        <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
                                        <SettingsContextMenu Enabled="true" EnableColumnMenu="False" />
                                        <SettingsBehavior ConfirmDelete="true" EnableCustomizationWindow="true" EnableRowHotTrack="true" />
                                        <Settings VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                                    </dx:ASPxGridView>
                                    <asp:ObjectDataSource ID="OdsProcessListNotInMoldsId" runat="server" TypeName="ProcessListModels" SelectMethod="MinProcessListNotInMoldsId">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="MoldsId" SessionField="MoldsId" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="OdsLevelDA" runat="server" TypeName="MoldsModels" SelectMethod="MoldsProcessListByMoldsId" InsertMethod="MoldsProcessCreated" DeleteMethod="MoldsProcessDeleted">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="MoldsId" SessionField="MoldsId" Type="Int32" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:SessionParameter Name="MoldsId" SessionField="MoldsId" Type="Int32" />
                                            <asp:Parameter Name="ProcessListId" Type="Int32" />
                                        </InsertParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="MoldsProcessId" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:ObjectDataSource>
                                </DetailRow>
                            </Templates>
                        </dx:ASPxGridView>
                        <asp:ObjectDataSource ID="OdsLevelD" runat="server" TypeName="MoldsModels" SelectMethod="MoldsList" InsertMethod="MoldsCreated" UpdateMethod="MoldsUpdated" DeleteMethod="MoldsDeleted">
                            <InsertParameters>
                                <asp:Parameter Name="MoldsName" Type="String" />
                                <asp:Parameter Name="MoldsMinScheduledDays" Type="Decimal" />
                                <asp:Parameter Name="MoldsFactor" Type="Decimal" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="MoldsId" Type="Int32" />
                                <asp:Parameter Name="MoldsName" Type="String" />
                                <asp:Parameter Name="MoldsMinScheduledDays" Type="Decimal" />
                                <asp:Parameter Name="MoldsFactor" Type="Decimal" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="MoldsId" Type="Int32" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

