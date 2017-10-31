using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Collections.Specialized;
using System.Collections;

using DevExpress.Web;

using CMS.CMSHelper;
using CMS.UIControls;
using CMS.ExtendedControls;
public partial class CMSTemplates_desk : TemplatePage
{    
    protected void Page_Init(object sender, EventArgs e)
    {
        if (!IsPostBack){
            ClearTabs();
            //AddTab("TheoDoiTinhHinhSanXuat");
        }else
            RestoreTabs();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        SplitterContentControl SCCMenu = SMain.FindControl("SCCMenu") as SplitterContentControl;
        ASPxMenu NBMenuLeft = SCCMenu.FindControl("NBMenuLeft") as ASPxMenu;
        ASPxMenu NBMenuRight = SCCMenu.FindControl("NBMenuRight") as ASPxMenu;
        MenuItem FMIMenu = null;
        MenuItem CMIMenu = null;
        #region "Hệ thống"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "QuanLyNguoiDung")
            || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhomNguoiDung")
            || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DanhMucChucNang"))
        {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Hệ thống";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_system.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "QuanLyNguoiDung"))
                FMIMenu.Items.Add(new MenuItem("Quản lý người dùng", "QuanLyNguoiDung", "~/App_Themes/VMMP/images/icon_people.png"));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhomNguoiDung"))
                FMIMenu.Items.Add(new MenuItem("Nhóm người dùng", "NhomNguoiDung", "~/App_Themes/VMMP/images/icon_group.png"));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DanhMucChucNang"))
                FMIMenu.Items.Add(new MenuItem("Danh mục chức năng", "DanhMucChucNang", "~/App_Themes/VMMP/images/icon_role.png"));
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        #region "Danh mục"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhanVien")
            || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongDoan")
            || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "KhachHang"))
        {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Danh mục";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_list.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "NhanVien"))
                FMIMenu.Items.Add(new MenuItem("Nhân viên", "NhanVien", "~/App_Themes/VMMP/images/icon_employee.png"));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongDoan"))
                FMIMenu.Items.Add(new MenuItem("Công đoạn", "CongDoan", "~/App_Themes/VMMP/images/icon_process.png"));
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        #region "Nghiệp vụ"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "ManHinhDungChungDonHang")
           || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongViecDangChiuTrachNhiem"))
        {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Nghiệp vụ";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_business.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "ManHinhDungChungDonHang"))
            {
                CMIMenu = new MenuItem();
                CMIMenu.Name = "CongDoanDonHang";
                CMIMenu.Text = "Công đoạn đơn hàng";
                CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_processlist.png";
                FMIMenu.Items.Add(CMIMenu);
            }
            CMIMenu = new MenuItem();
            CMIMenu.Name = null;
            CMIMenu.Text = "Nhật ký làm việc";
            CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_processlist.png";
            CMIMenu.NavigateUrl = "/TaskHistory";
            FMIMenu.Items.Add(CMIMenu);
            CMIMenu = new MenuItem();
            CMIMenu.Name = "DuKienThoiGianHoanThanh";
            CMIMenu.Text = "Dự kiến thời gian hoàn thành";
            CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_info.png";
            FMIMenu.Items.Add(CMIMenu);
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        #region "Báo cáo"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "TheoDoiTinhHinhSanXuat")
           || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoSoLuongSanXuat")
           || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoTongHop"))
        {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Báo cáo";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_report.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoTongHop")){
                CMIMenu = new MenuItem();
                CMIMenu.Name = "BaoCaoTongHop";
                CMIMenu.Text = "Báo cáo tổng hợp";
                CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_display.png";
                FMIMenu.Items.Add(CMIMenu);
            }
            //if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "TheoDoiTinhHinhSanXuat"))
            //{
            //    CMIMenu = new MenuItem();
            //    CMIMenu.Name = "TheoDoiTinhHinhSanXuat";
            //    CMIMenu.Text = "Theo dõi tình hình sản xuât";
            //    CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_display.png";
            //    FMIMenu.Items.Add(CMIMenu);
            //}
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoSoLuongSanXuat"))
            {
                CMIMenu = new MenuItem();
                CMIMenu.Name = "BaoCaoSoLuongSanXuat";
                CMIMenu.Text = "Báo cáo số lượng sản xuất";
                CMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_count.png";
                FMIMenu.Items.Add(CMIMenu);
            }            
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DonHang"))
            NBMenuLeft.Items.Add(new MenuItem("Đơn hàng", "DonHang", "~/App_Themes/VMMP/images/icon_order.png"));

        if (!CMSContext.IsAuthenticated())
            Response.Redirect("~/Login");
        else {
            NBMenuRight.Items.Add(new MenuItem("Xin chào: " + CMSContext.CurrentUser.FullName, null, "~/App_Themes/VMMP/images/icon_people.png"));
            NBMenuRight.Items.Add(new MenuItem("Đổi mật khẩu", null, "~/App_Themes/VMMP/images/icon_keys.png", "/Change-password"));
            NBMenuRight.Items.Add(new MenuItem("Hỗ trợ", "HoTro", "~/App_Themes/VMMP/images/icon_help.png"));
            NBMenuRight.Items.Add(new MenuItem("Thoát", null, "~/App_Themes/VMMP/images/icon_exit.png", "/LogOut"));
        }
    }
    protected void CallbackHandler(object sender, CallbackEventArgsBase e)
    {
        string[] parameters = e.Parameter.Split(':');
        string action = parameters[0];
        string target = parameters[1];
        if (action == "remove")
            RemoveTab(int.Parse(target));
        else if (action == "add")
            AddTab(target); 
    }

    void ClearTabs()
    {
        Session.Remove("tabs");
        Session.Remove("uid");
    }
    void AddTab(string tabType)
    {
        try
        {
            var tabsInfo = Session["tabs"] as OrderedDictionary;
            if (tabsInfo != null)
            {
                foreach (DictionaryEntry tabInfo in tabsInfo)
                    if ((string)tabInfo.Value == tabType)
                        RemoveTab(PageControl.TabPages.IndexOfName((string)tabInfo.Key));
            }
        }
        catch { }
        string tabId = GenUID();
        CreateTab(tabId, tabType);
        PageControl.ActiveTabIndex = PageControl.TabPages.Count - 1;
        SaveTabInfo(tabId, tabType);
    }
    void RestoreTabs()
    {
        var tabsInfo = Session["tabs"] as OrderedDictionary;
        if (tabsInfo != null)
        {
            foreach (DictionaryEntry tabInfo in tabsInfo)
                CreateTab((string)tabInfo.Key, (string)tabInfo.Value);
        }
    }
    void RemoveTab(int index)
    {
        var tabsInfo = Session["tabs"] as OrderedDictionary;
        if (tabsInfo != null)
        {
            tabsInfo.Remove(PageControl.TabPages[index].Name);
            Session["tabs"] = tabsInfo;
        }
        if (index < PageControl.ActiveTabIndex)
            PageControl.ActiveTabIndex--;
        PageControl.TabPages.RemoveAt(index);
    }

    string GenUID()
    {
        int uid = (int)(Session["uid"] ?? 0);
        Session["uid"] = ++uid;
        return "TabPageUID" + uid;
    }
    void CreateTab(string id, string tabType)
    {
        if (tabType != "")
        {
            TabPage tab = new TabPage();
            tab.Text = tabName(tabType);
            tab.Name = id;
            Control ctrl = LoadControl("/CMSTemplates/Controls/" + tabType + ".ascx");
            ctrl.ID = id;
            tab.Controls.Add(ctrl);
            PageControl.TabPages.Add(tab);
        }
    }
    void SaveTabInfo(string id, string tabType)
    {
        var tabsInfo = Session["tabs"] as OrderedDictionary;
        if (tabsInfo == null)
            tabsInfo = new OrderedDictionary();
        tabsInfo.Add(id, tabType);
        Session["tabs"] = tabsInfo;
    }

    string tabName(string tabType)
    {
        string result = tabType;
        switch (tabType)
        {
            case "BaoCaoTongHop":
                result = "Báo cáo tổng hợp";
                break;
            case "NguyenVatLieu":
                result = "Nguyên vật liệu";
                break;
            case "QuanLyNguoiDung":
                result = "Quản lý người dùng";
                break;
            case "NhomNguoiDung":
                result = "Nhóm người dùng";
                break;
            case "DanhMucChucNang":
                result = "Danh mục chức năng";
                break;
            case "CongDoanDonHang":
                result = "Công đoạn đơn hàng";
                break;
            case "TheoDoiTinhHinhSanXuat":
                result = "Theo dõi tình hình sản xuất";
                break;
            case "BaoCaoSoLuongSanXuat":
                result = "Báo cáo số lượng sản xuất";
                break;
            case "CongDoan":
                result = "Công đoạn";
                break;
            case "KhachHang":
                result = "Khách hàng";
                break;
            case "NhanVien":
                result = "Nhân viên";
                break;
            case "SettingDoCung":
                result = "Setting độ cứng";
                break;
            case "DuKienThoiGianHoanThanh":
                result = "Dự kiến thời gian hoàn thành";
                break;
            case "DonHang":
                result = "Đơn hàng";
                break;
            default: break;
        }
        return result;
    }
}