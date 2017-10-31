<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NhomNguoidung.ascx.cs" Inherits="CMSTemplates_Controls_NhomNguoidung" %>
<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<dx:ASPxGridView ID="gvRole" ClientInstanceName="gvRole" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="RoleID"
    SettingsBehavior-ConfirmDelete="True" OnRowDeleting="gvRole_RowDeleting" OnRowInserting="gvRole_RowInserting" OnRowUpdating="gvRole_RowUpdating"
    Styles-DetailCell-Paddings-PaddingTop="5px" Styles-DetailCell-Paddings-PaddingRight="0px" Styles-DetailCell-Paddings-PaddingBottom="5px"> 
    <ClientSideEvents Init="OnInit" />
    <Columns>
        <dx:GridViewDataTextColumn FieldName="RoleDisplayName" Caption="Tên nhóm" VisibleIndex="1" PropertiesTextEdit-MaxLength="50"/>
        <dx:GridViewDataTextColumn FieldName="RoleDescription" Caption="Diễn giải" VisibleIndex="2" Width="488px" PropertiesTextEdit-MaxLength="150"/>
    </Columns>
    <SettingsEditing Mode="Inline" />
    <Styles AlternatingRow-Enabled="True" Header-CssClass="Detail"/>
    <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
    <Settings VerticalScrollBarMode="Visible" HorizontalScrollBarMode="Hidden"/>
    <SettingsPager Mode="ShowAllRecords" />
    <SettingsLoadingPanel Text="Đang tải..."/>
    <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị" ConfirmDelete="Bạn có muốn xóa Nhóm này không?" />
    <SettingsCommandButton EditButton-Image-ToolTip="Sửa" EditButton-Image-Url="~/App_Themes/Default/Images/Design/Controls/UniGrid/Actions/edit.png"
        DeleteButton-Image-ToolTip="Xóa" DeleteButton-Image-Url="~/App_Themes/Default/Images/Design/Controls/UniGrid/Actions/delete.png"
        NewButton-ButtonType="Button" NewButton-Text="Thêm mới" 
        UpdateButton-Image-Url="~/App_Themes/Default/Images/Design/Controls/UniGrid/Actions/Upload.png" UpdateButton-Image-ToolTip="Cập nhật"
        CancelButton-Image-Url="~/App_Themes/Default/Images/Design/Controls/UniGrid/Actions/Undo.png" CancelButton-Image-ToolTip="Thoát"/>
    <Templates>
        <DetailRow>
            <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true" LoadingPanelText="Đang tải..."
                ContentStyle-Border-BorderStyle="None" ContentStyle-Paddings-Padding="0px" TabStyle-BorderBottom-BorderStyle="None" TabSpacing="2px" ContentStyle-CssClass="Detail">
                <TabPages>
                    <dx:TabPage Text="Quản lý chức năng" Visible="true">
                        <ContentCollection>
                            <dx:ContentControl runat="server">
                                <dx:ASPxGridView ID="gvPermissions" ClientInstanceName="gvPermissions" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="PermissionID"
                                    SettingsBehavior-AllowSort="false" OnBeforePerformDataSelect="gvPermissions_BeforePerformDataSelect" OnBatchUpdate="gvPermissions_BatchUpdate" 
                                    Styles-DetailCell-Paddings-PaddingRight="0px" BorderRight-BorderWidth="0px"> 
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Nhóm chức năng" VisibleIndex="1" ReadOnly="true" 
                                            PropertiesTextEdit-FocusedStyle-Border-BorderColor="#FFFFFF" PropertiesTextEdit-Style-Paddings-PaddingLeft="4px" PropertiesTextEdit-ReadOnlyStyle-Border-BorderColor="#FFFFFF"/>
                                        <dx:GridViewDataCheckColumn FieldName="PermissionToRole" Caption="Cho phép" VisibleIndex="2" Width="10%" CellStyle-HorizontalAlign="Center" PropertiesCheckEdit-Style-CssClass="PermissionToRole">
                                            <PropertiesCheckEdit>
                                                <DisplayImageChecked Url="/App_Themes/Default/Images/Design/Controls/UniMatrix/allowed.png" Width="16px" Height="16px" />
                                                <DisplayImageUnchecked Url="/App_Themes/Default/Images/Design/Controls/UniMatrix/denied.png" Width="16px" Height="16px" />
                                            </PropertiesCheckEdit>
                                        </dx:GridViewDataCheckColumn>
                                    </Columns>
                                    <SettingsDetail ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="true" />
                                    <Styles AlternatingRow-Enabled="True" Header-CssClass="Detail" />
                                    <SettingsPager Mode="ShowAllRecords" />
                                    <Settings VerticalScrollBarMode="Hidden" />
                                    <SettingsLoadingPanel Text="Đang tải..."/>
                                    <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị"/>
                                    <SettingsCommandButton NewButton-ButtonType="Button" NewButton-Text="Thêm mới" UpdateButton-Text="Cập nhật" UpdateButton-ButtonType="Button" CancelButton-ButtonType="Button" CancelButton-Text="Hủy bỏ"/>
                                    <Templates>
                                        <DetailRow>
                                            <dx:ASPxGridView ID="gvPermissionsChild" ClientInstanceName="gvPermissionsChild" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="PermissionID"
                                                SettingsBehavior-AllowSort="false" OnBeforePerformDataSelect="gvPermissionsChild_BeforePerformDataSelect" OnBatchUpdate="gvPermissionsChild_BatchUpdate" BorderRight-BorderWidth="0px">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="PermissionDisplayName" Caption="Chức năng" VisibleIndex="0" ReadOnly="true" 
                                                        PropertiesTextEdit-FocusedStyle-Border-BorderColor="#FFFFFF" PropertiesTextEdit-Style-Paddings-PaddingLeft="4px" PropertiesTextEdit-ReadOnlyStyle-Border-BorderColor="#FFFFFF"/>
                                                    <dx:GridViewDataCheckColumn FieldName="PermissionToRole" Caption="Cho phép" VisibleIndex="1" Width="58px" CellStyle-HorizontalAlign="Center" PropertiesCheckEdit-Style-CssClass="PermissionToRole">
                                                        <PropertiesCheckEdit>
                                                            <DisplayImageChecked Url="/App_Themes/Default/Images/Design/Controls/UniMatrix/allowed.png" Width="16px" Height="16px" />
                                                            <DisplayImageUnchecked Url="/App_Themes/Default/Images/Design/Controls/UniMatrix/denied.png" Width="16px" Height="16px" />
                                                        </PropertiesCheckEdit>
                                                    </dx:GridViewDataCheckColumn>
                                                </Columns>
                                                <Styles AlternatingRow-Enabled="True" />
                                                <SettingsPager Mode="ShowAllRecords"/>
                                                <SettingsLoadingPanel Text="Đang tải..."/>
                                                <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị"/>
                                                <SettingsCommandButton UpdateButton-Text="Cập nhật" UpdateButton-ButtonType="Button" CancelButton-ButtonType="Button" CancelButton-Text="Hủy bỏ"/>
                                            </dx:ASPxGridView>
                                        </DetailRow>
                                    </Templates>
                                </dx:ASPxGridView>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Text="Người dùng" Visible="true">
                        <ContentCollection>
                            <dx:ContentControl runat="server">
                                <dx:ASPxGridView ID="gvUser" ClientInstanceName="gvUser" AutoGenerateColumns="false" runat="server" Width="100%" KeyFieldName="UserID" SettingsBehavior-ConfirmDelete="True" 
                                    OnBeforePerformDataSelect="gvUser_BeforePerformDataSelect" OnRowDeleting="gvUser_RowDeleting" OnRowInserting="gvUser_RowInserting" BorderRight-BorderWidth="0px"> 
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ButtonType="Image" ShowDeleteButton="true" VisibleIndex="0" Width="87px">
                                            <DeleteButton Image-Url="~/App_Themes/Default/Images/Design/Controls/UniGrid/Actions/delete.png" Image-ToolTip="Xóa" />
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="FullName" VisibleIndex="1" Caption="Họ và tên" />
                                        <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="2" Caption="Email" />
                                        <dx:GridViewDataDateColumn FieldName="UserDateOfBirth" VisibleIndex="3" Caption="Ngày sinh" Width="90px" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
                                        <dx:GridViewDataTextColumn FieldName="UserCreated" VisibleIndex="4" Caption="Ngày tạo" Width="150px" />
                                        <dx:GridViewDataTextColumn FieldName="LastLogon" VisibleIndex="5" Caption="Đăng nhập lần cuối" Width="150px" />
                                    </Columns>
                                    <Styles AlternatingRow-Enabled="True" />
                                    <SettingsPager Mode="ShowAllRecords" />
                                    <SettingsLoadingPanel Text="Đang tải..."/>
                                    <SettingsText EmptyDataRow="Không có dữ liệu để hiển thị" ConfirmDelete="Bạn có muốn xóa người dùng ra khỏi nhóm này không?" />
                                    <SettingsCommandButton NewButton-ButtonType="Button" NewButton-Text="Thêm mới" UpdateButton-Text="Cập nhật" UpdateButton-ButtonType="Button" CancelButton-ButtonType="Button" CancelButton-Text="Thoát"/>
                                    <Templates>
                                        <EditForm>
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="width:100px">Tên người dùng:</td>
                                                    <td>
                                                        <dx:ASPxComboBox ID="cbUser" ClientInstanceName="cbUser" runat="server" ValueField="UserName" Border-BorderStyle="Dashed" EnableCallbackMode="true" DropDownStyle="DropDownList" EncodeHtml="False" Width="258px"
                                                            ValueType="System.String" DropDownWidth="550" IncrementalFilteringMode="StartsWith" TextFormatString="{0}" OnItemRequestedByValue="cbUser_ItemRequestedByValue" ValidationSettings-ValidationGroup="<%#Container.ValidationGroup %>">
                                                            <Columns>
                                                                <dx:ListBoxColumn FieldName="FullName" Caption="Họ và tên" Width="100%" />
                                                                <dx:ListBoxColumn FieldName="Email" Caption="Email" Width="200px"/>
                                                                <dx:ListBoxColumn FieldName="UserDateOfBirth" Caption="Ngày sinh" Width="69px" />
                                                            </Columns>
                                                            <ValidationSettings RequiredField-IsRequired="true" ErrorDisplayMode="ImageWithText" RequiredField-ErrorText="Yêu cầu chọn người dùng" />
                                                            <ClientSideEvents Init="OnComboBoxInit" />
                                                        </dx:ASPxComboBox>
                                                    </td>
                                                    <td style="width:153px">
                                                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"/>
                                                        <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditForm>
                                    </Templates>
                                </dx:ASPxGridView>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                </TabPages>
            </dx:ASPxPageControl>
        </DetailRow>
    </Templates>
</dx:ASPxGridView>