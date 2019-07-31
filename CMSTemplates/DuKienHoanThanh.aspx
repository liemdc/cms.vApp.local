<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="DuKienHoanThanh.aspx.cs" Inherits="CMSTemplates_DuKienHoanThanh" %>

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
    Border-BorderWidth="0" BorderBottom-BorderWidth="1">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" Width="188" />
        <dx:GridViewDataTextColumn FieldName="ProjectTaskOverlayNum" Caption="Số phủ" Width="100" />
        <dx:GridViewDataTextColumn FieldName="ProjectTaskMoldsId" Caption="Phân loại" Width="100" />
        <dx:GridViewDataTextColumn FieldName="ProjectTaskQuantities" Caption="Số lượng" Width="100" />
        <dx:GridViewDataComboBoxColumn FieldName="ProjectTaskCustomerId" Caption="Khách hàng" Width="128">
            <PropertiesComboBox DataSourceID="OdsCustomer" TextField="CustomerName" ValueField="CustomerId" ValueType="System.Int32" IncrementalFilteringMode="StartsWith">
                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" RequiredField-ErrorText="Data is required." />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>        
        <dx:GridViewDataTextColumn FieldName="ProjectTaskTransmit" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Ngày nhận" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_NC" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: NC" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_MC" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: MC" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_PhayTay" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: Phay tay" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_Nhiet" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: Nhiệt luyện" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_Mai" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: Mài chi tiết" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_Mai" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: Tiện mài SNK" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_EDM" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: EDM" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_WEDM" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: WEDM" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_LapRap" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: LR Đánh bóng" Width="158" />
        <dx:GridViewDataTextColumn FieldName="DX_DuKienHT_QA" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Dự kiến HT: QA" Width="158" />
        <dx:GridViewDataTextColumn FieldName="ProjectTaskDeadline" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy HH:mm" Caption="Ngày hoàn thành" Width="158" />
        <dx:GridViewDataTextColumn FieldName="ProjectTaskDescription" Caption="Ghi chú" Width="480" />        
    </Columns>
    <Styles DetailCell-Paddings-Padding="0" Header-VerticalAlign="Bottom" />
    <SettingsContextMenu Enabled="true" EnableRowMenu="False">
        <ColumnMenuItemVisibility GroupByColumn="false" ShowGroupPanel="false" ShowFooter="false"/>
    </SettingsContextMenu>
    <ClientSideEvents Init="OnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
    <SettingsPager Mode="ShowPager" PageSize="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
    <SettingsBehavior EnableRowHotTrack="true" />
    <Settings ShowHeaderFilterButton="false" VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Visible" />    
</dx:ASPxGridView>
<dx:ASPxGridViewExporter ID="GvExport" runat="server" GridViewID="GvLevelA" />
<asp:ObjectDataSource ID="OdsCustomer" runat="server" TypeName="CustomerModels" SelectMethod="MinCustomerList" />
<asp:ObjectDataSource ID="OdsGvLevelA" runat="server" TypeName="ReportModels" SelectMethod="DuKienHoanThanh">
    <SelectParameters>
        <asp:ControlParameter ControlID="DeStart" Name="RTDateBegin" Type="DateTime" />
        <asp:ControlParameter ControlID="DeEnd" Name="RTDateEnd" Type="DateTime" />
        <asp:ControlParameter ControlID="CbFilter" Name="Filter" Type="String" />
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

