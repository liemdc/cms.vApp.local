<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="ReportTotal.aspx.cs" Inherits="CMSTemplates_ReportTotal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function AdjustSize() {
            var ControlHeight = 27;
            var Height = Math.max(0, document.documentElement.clientHeight);
            if (typeof GvLevelA !== 'undefined')
                GvLevelA.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + ControlHeight));
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
<dx:ASPxGridView ID="GvLevelA" ClientInstanceName="GvLevelA" runat="server" Width="100%" DataSourceID="OdsGvLevelA" KeyFieldName="ProjectTaskID" 
    Border-BorderWidth="0" BorderBottom-BorderWidth="1" OnCustomColumnDisplayText="OnCustomColumnDisplayText" OnHtmlDataCellPrepared="GvLevelA_HtmlDataCellPrepared">
    <Columns>
        <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="48" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" />
        <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" Width="228" />
        <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="ProjectTaskOverlayNum" Caption="Số phủ" Width="88" />
        <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="MoldsName" Caption="Phân loại" Width="100" />
        <dx:GridViewDataTextColumn VisibleIndex="4" FieldName="ProjectTaskQuantities" Caption="Số lượng" Width="88" />
        <dx:GridViewDataTextColumn VisibleIndex="5" FieldName="ProjectTaskDiameterOut" Caption="Đkính" Width="78" />
        <dx:GridViewDataTextColumn VisibleIndex="6" FieldName="ProjectTaskWeight" Caption="Khối lượng" Width="88" />
        <dx:GridViewDataTextColumn VisibleIndex="7" FieldName="CustomerName" Caption="Khách hàng" Width="118" />
        <dx:GridViewDataTextColumn VisibleIndex="8" FieldName="ProjectTaskTransmit" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Ngày nhận" Width="118" />
        <dx:GridViewDataTextColumn VisibleIndex="9" FieldName="ProjectTaskDeadline" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Ngày hoàn thành" Width="120" />
        <dx:GridViewDataTextColumn VisibleIndex="10" FieldName="TaskStatusDisplayName" Caption="Trạng thái" Width="88" />
        <dx:GridViewDataTextColumn VisibleIndex="11" FieldName="ProjectTaskStatusID" Width="0" />
        <dx:GridViewDataTextColumn VisibleIndex="12" FieldName="ProjectTaskDescription" Caption="Ghi chú" Width="142" />
        <dx:GridViewBandColumn Caption="Tiện NC" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="TienNCDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="TienNCHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="TienNCKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Phay Tay" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="PhayTayDH" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="PhayTayHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="PhayTayKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Phay MC" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="PhayMCDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="PhayMCHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="PhayMCKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Nhiệt luyện" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="NhietLuyenDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="NhietLuyenHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="NhietLuyenKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Tiện tinh NC" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="TienTinhNCDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="TienTinhNCHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="TienTinhNCKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Mài phẳng khuôn dập" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="MaiPhangKhuonDapDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="MaiPhangKhuonDapHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="MaiPhangKhuonDapKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="EDM" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="EDMDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="EDMHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="EDMKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="WEDM" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="WEDMDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="WEDMHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="WEDMKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Mài bóng & Lắp ráp" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="MaiBongVaLapRapDK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="MaiBongVaLapRapHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="MaiBongVaLapRapKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Bộ phận QA" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="BoPhanQADK" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="BoPhanQAHT" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="BoPhanQAKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
        <dx:GridViewBandColumn Caption="Xuất hàng" VisibleIndex="16">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="ProjectTaskDuKienXuatHang" Caption="Dự kiến hoàn thành" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="ProjectTaskThucTeXuatHang" Caption="Thực tế hoàn thành" EditFormSettings-Caption="Thực tế Tinh qua QA" Width="120" VisibleIndex="16"> 
                    <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="DateTime" EditFormatString="dd/MM/yyyy HH:mm" AllowNull="true">
                        <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ProjectTaskXuatHangKQ" Caption="Kết quả" Width="78" VisibleIndex="16" EditFormSettings-Visible="False" /> 
            </Columns>
            <HeaderStyle HorizontalAlign="Center" />
        </dx:GridViewBandColumn>
    </Columns>
    <SettingsDetail ShowDetailRow="True" />
    <Styles DetailCell-Paddings-Padding="0" Header-VerticalAlign="Bottom" />
    <SettingsContextMenu Enabled="true" EnableRowMenu="False">
        <ColumnMenuItemVisibility GroupByColumn="false" ShowGroupPanel="false" ShowFooter="false"/>
    </SettingsContextMenu>
    <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
    <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
    <SettingsBehavior EnableRowHotTrack="true" />
    <Settings ShowHeaderFilterButton="false" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Visible" />
    <Templates>
        <DetailRow>
            <dx:ASPxGridView ID="GvLevelAA" ClientInstanceName="GvLevelAA" runat="server" DataSourceID="OdsGvLevelAA" KeyFieldName="ProcessListId" Width="100%"
                Border-BorderColor="#CFCFCF" Styles-Header-Border-BorderColor="#CFCFCF" Styles-Header-BackColor="#F2F2F2" Styles-Footer-BackColor="#F2F2F2" Border-BorderWidth="0" BorderLeft-BorderWidth="1" BorderRight-BorderWidth="1"
                OnBeforePerformDataSelect="GvLevelAA_BeforePerformDataSelect" OnCustomColumnDisplayText="OnCustomColumnDisplayText">
                <Columns>
                    <dx:GridViewDataTextColumn VisibleIndex="0" Caption="Num" Width="34" Settings-AllowSort="False" Settings-AllowHeaderFilter="False" EditFormSettings-Visible="False" UnboundType="String" />
                    <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="ProcessListName" Caption="Công đoạn" />
                    <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="ProcessExpectedTime" Caption="KH Giờ" Width="115" PropertiesTextEdit-DisplayFormatString="{0} giờ." />
                    <dx:GridViewDataDateColumn VisibleIndex="2" FieldName="ProcessExpectedCompletion" Caption="KH Ngày" Width="115" >
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                            <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="ProcessFactTime" Caption="TH Giờ" Width="115" PropertiesTextEdit-DisplayFormatString="{0} giờ." />
                    <dx:GridViewDataDateColumn VisibleIndex="3" FieldName="ProcessCompletion" Caption="TH Ngày" Width="115">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm" EditFormat="Custom" EditFormatString="dd/MM/yyyy HH:mm">
                            <TimeSectionProperties Visible="true" TimeEditProperties-EditFormatString="HH:mm" />
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem SummaryType="Count" FieldName="ProcessListName" ShowInColumn="ProcessListName" DisplayFormat="Count: {0} công đoạn." />
                    <dx:ASPxSummaryItem SummaryType="Sum" FieldName="ProcessExpectedTime" ShowInColumn="ProcessExpectedTime" DisplayFormat="Sum: {0} giờ." />
                    <dx:ASPxSummaryItem SummaryType="Sum" FieldName="ProcessFactTime" ShowInColumn="ProcessFactTime" DisplayFormat="Sum: {0} giờ." />
                </TotalSummary>
                <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />                                        
                <SettingsBehavior EnableRowHotTrack="true" />
                <Settings ShowFooter="true" ShowHeaderFilterButton="true" VerticalScrollBarMode="Hidden" HorizontalScrollBarMode="Hidden" />
                <SettingsPager Mode="ShowAllRecords" />                           
            </dx:ASPxGridView>
        </DetailRow>
    </Templates>
</dx:ASPxGridView>
<dx:ASPxGridViewExporter ID="GvExport" runat="server" GridViewID="GvLevelA" />
<asp:ObjectDataSource ID="OdsGvLevelA" runat="server" TypeName="ReportModels" SelectMethod="ReportTotalList">
    <SelectParameters>
        <asp:ControlParameter ControlID="DeStart" Name="RTDateBegin" Type="DateTime" />
        <asp:ControlParameter ControlID="DeEnd" Name="RTDateEnd" Type="DateTime" />
        <asp:ControlParameter ControlID="CbFilter" Name="Filter" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="OdsGvLevelAA" runat="server" TypeName="ReportModels" SelectMethod="ReportTotalDetailList">
    <SelectParameters>
        <asp:SessionParameter Name="ProjectTaskID" SessionField="ProjectTaskID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<table style="width:100%;border-spacing:0">
    <tr>
        <td style="text-align:right;padding-right:3px">
            <dx:ASPxLabel ID="GvLevelCLabel" runat="server" Text="Chọn khoảng thời gian [ Bắt đầu / Kết thúc ]: " Font-Bold="true" />
        </td>
        <td style="width:128px;text-align:right;padding-right:3px">
            <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbFilter" ClientSideEvents-TextChanged="function(s, e) { GvLevelA.PerformCallback();}">
                <Items>
                    <dx:ListEditItem Text="Nhận đơn hàng" Value="Transmit" Selected="true" />
                    <dx:ListEditItem Text="Hoàn thành đơn hàng" Value="Deadline" />
                </Items>
            </dx:ASPxComboBox>
        </td>
        <td style="width:128px;height:25px;padding-right:3px">
            <dx:ASPxDateEdit ID="DeStart" ClientInstanceName="DeStart" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChanged">
                <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                    <RequiredField IsRequired="True" ErrorText="Start date is required" />
                </ValidationSettings>
                <ClientSideEvents DateChanged="function(s, e) { GvLevelA.PerformCallback();}" />
            </dx:ASPxDateEdit>
        </td>
        <td style="width:128px;height:25px;padding-right:3px">
            <dx:ASPxDateEdit ID="DeEnd" ClientInstanceName="DeEnd" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm" OnDateChanged="On_DateChanged">
                <DateRangeSettings StartDateEditID="DeStart" />
                <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                    <RequiredField IsRequired="True" ErrorText="End date is required" />
                </ValidationSettings>
                <ClientSideEvents DateChanged="function(s, e) { GvLevelA.PerformCallback();}" />
            </dx:ASPxDateEdit>
        </td>
        <td style="width:100px;text-align:right;padding-right:3px">
            <dx:ASPxLabel ID="GvLevelCLabelE" runat="server" Text="Xuất dữ liệu: " Font-Bold="true" />
        </td>
        <td style="width:128px;text-align:right;padding-right:3px">
            <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbExportMode" ClientSideEvents-TextChanged="function(s, e) { GvLevelA.PerformCallback();}" />
        </td>
        <td style="width:100px;text-align:right;padding-right:3px">
            <dx:ASPxButton ID="btnXlsExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLS" UseSubmitBehavior="False" OnClick="btnXlsExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelA.PerformCallback();}" />
        </td>
        <td style="width:100px;text-align:right;padding-right:3px">
            <dx:ASPxButton ID="btnXlsxExport" runat="server" Width="100" Height="25" Paddings-Padding="0" Text="Excel XLSX" UseSubmitBehavior="False" OnClick="btnXlsxExport_Click" ClientSideEvents-Click="function(s, e) { GvLevelA.PerformCallback();}" />
        </td>
    </tr>
</table>
</asp:Content>

