<%@ Page Title="" Language="C#" MasterPageFile="~/CMSTemplates/Default.Master" AutoEventWireup="true" CodeFile="ReportOrders.aspx.cs" Inherits="CMSTemplates_ReportOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plcHead" Runat="Server">
    <script type="text/javascript">
        function PvOnInit(s, e) {
            AdjustSize();
            PGReportOrders.PerformCallback();
        }
        function AdjustSize() {
            var ControlHeight = 27;
            var Height = Math.max(0, document.documentElement.clientHeight);
            if (typeof PGReportOrders !== 'undefined')
                PGReportOrders.SetHeight(Height - (HeaderPanel.GetHeight() + FooterPanel.GetHeight() + ControlHeight));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plcMain" Runat="Server">
    <dx:ASPxPivotGrid ID="PGReportOrders" ClientInstanceName="PGReportOrders" runat="server" Width="100%" DataSourceID="OdsPGReportOrders" 
        Height="480" OnCustomCellDisplayText="PGReportOrders_CustomCellDisplayText">        
        <ClientSideEvents Init="PvOnInit" BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
        <OptionsView VerticalScrollBarMode="Visible" VerticalScrollingMode="Standard" HorizontalScrollBarMode="Visible" ShowRowGrandTotals="False" ShowColumnGrandTotals="False" ShowRowTotals="False" ShowDataHeaders="False" ShowColumnHeaders="False" ShowFilterHeaders="False" />
        <OptionsPager Position="Bottom" RowsPerPage="20" PageSizeItemSettings-Visible="true" PageSizeItemSettings-Position="Right" />
        <OptionsCustomization AllowExpand="false" AllowSort="false" />
        <Fields>
            <dx:PivotGridField Area="RowArea" FieldName="ProjectTaskMoldCode" Caption="Mã số khuôn" />
            <dx:PivotGridField Area="RowArea" FieldName="ProjectTaskOverlayNum" Caption="Số phủ" />
            <dx:PivotGridField Area="RowArea" FieldName="MoldsName" Caption="Phân loại" />
            <dx:PivotGridField Area="RowArea" FieldName="ProjectTaskQuantities" Caption="Số lượng" />
            <dx:PivotGridField Area="RowArea" FieldName="ProjectTaskTransmitVtX" Caption="Ngày nhận hàng" />
            <dx:PivotGridField Area="RowArea" FieldName="ProjectTaskDeadlineVtX" Caption="Ngày hoàn thành" /> 
            <dx:PivotGridField Area="ColumnArea" FieldName="ProcessListOrder" SortOrder="Ascending" />
            <dx:PivotGridField Area="ColumnArea" FieldName="ProcessListName" />
            <dx:PivotGridField Area="DataArea" FieldName="ProjectTaskStatusID" />
        </Fields>
    </dx:ASPxPivotGrid>
    <asp:ObjectDataSource ID="OdsPGReportOrders" runat="server" TypeName="ReportModels" SelectMethod="ReportOrdersList">
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
                <dx:ASPxComboBox runat="server" Width="128" Height="25" ID="CbFilter" ClientSideEvents-TextChanged="function(s, e) { PGReportOrders.PerformCallback(); }">
                    <Items>
                        <dx:ListEditItem Text="Nhận đơn hàng" Value="Transmit" Selected="true" />
                        <dx:ListEditItem Text="Hoàn thành đơn hàng" Value="Deadline" />
                    </Items>
                </dx:ASPxComboBox>
            </td>
            <td style="width:128px;height:25px;padding-right:3px">
                <dx:ASPxDateEdit ID="DeStart" ClientInstanceName="DeStart" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm">
                    <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                        <RequiredField IsRequired="True" ErrorText="Start date is required" />
                    </ValidationSettings>
                    <ClientSideEvents DateChanged="function(s, e) { PGReportOrders.PerformCallback(); }" />
                </dx:ASPxDateEdit>
            </td>
            <td style="width:128px;height:25px;padding-right:3px">
                <dx:ASPxDateEdit ID="DeEnd" ClientInstanceName="DeEnd" runat="server" Width="128" Height="25" DisplayFormatString="dd/MM/yyyy HH:mm" EditFormatString="dd/MM/yyyy HH:mm">
                    <DateRangeSettings StartDateEditID="DeStart" />
                    <TimeSectionProperties Visible="true" TimeEditProperties-DisplayFormatString="HH:mm" />
                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                        <RequiredField IsRequired="True" ErrorText="End date is required" />
                    </ValidationSettings>
                    <ClientSideEvents DateChanged="function(s, e) { PGReportOrders.PerformCallback(); }" />
                </dx:ASPxDateEdit>
            </td>           
        </tr>
    </table>
</asp:Content>

