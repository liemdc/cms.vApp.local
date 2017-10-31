using CMS.CMSHelper;
using CMS.UIControls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DevExpress.Web;
using System.Diagnostics;

public partial class CMSTemplates_Default : TemplateMasterPage {
    #region "Methods"
    protected override void OnInit(EventArgs e) {
        base.OnInit(e);
    }
    protected override void OnPreRender(EventArgs e) {
        base.OnPreRender(e);
        this.ltlTags.Text = this.HeaderTags;
    }    
    #endregion
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack)
            LoadMenu();
    }  
    //protected string GetMemory() {
    //    return ((GC.GetTotalMemory(false) / 1024) / 1024).ToString();
    //}
    protected void LoadMenu() {
        if (!CMSContext.IsAuthenticated())
            Response.Redirect("~/Login");
        else {
            NBMenuRight.Items.Add(new MenuItem("Xin chào: " + CMSContext.CurrentUser.FullName, null, "~/App_Themes/VMMP/images/icon_people.png"));
            NBMenuRight.Items.Add(new MenuItem("Đổi mật khẩu", null, "~/App_Themes/VMMP/images/icon_keys.png", "/Change-password"));
            NBMenuRight.Items.Add(new MenuItem("Hỗ trợ", "HoTro", "~/App_Themes/VMMP/images/icon_help.png"));
            NBMenuRight.Items.Add(new MenuItem("Thoát", null, "~/App_Themes/VMMP/images/icon_exit.png", "/LogOut"));
        }
        MenuItem FMIMenu = null;
        #region "Hệ thống"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DanhMucChucNang"))
            NBMenuLeft.Items.Add(new MenuItem("Hệ thống", "DanhMucChucNang", "~/App_Themes/VMMP/images/icon_system.png", "/SystemConfig"));
        #endregion
        #region "Danh mục"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongDoan"))
            NBMenuLeft.Items.Add(new MenuItem("Quản lý", "Manager", "~/App_Themes/VMMP/images/icon_list.png", "/Manager"));
        #endregion
        #region "Nghiệp vụ"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "ManHinhDungChungDonHang")
           || CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "TaskHistory"))
        {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Nghiệp vụ";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_business.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "ManHinhDungChungDonHang"))
                FMIMenu.Items.Add(new MenuItem("Công đoạn đơn hàng", "CongDoanDonHang", "~/App_Themes/VMMP/images/icon_processlist.png", "/OrdersProcess"));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "TaskHistory"))
                FMIMenu.Items.Add(new MenuItem("Nhật ký làm việc", "TaskHistory", "~/App_Themes/VMMP/images/icon_processlist.png", "/TaskHistory"));
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        #region "Báo cáo"
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoTongHop") ||
            CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoDonHang")) {
            FMIMenu = new MenuItem();
            FMIMenu.Text = "Báo cáo";
            FMIMenu.Image.Url = "../App_Themes/VMMP/images/icon_report.png";
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoTongHop"))
                FMIMenu.Items.Add(new MenuItem("Báo cáo tổng hợp", "BaoCaoTongHop", "~/App_Themes/VMMP/images/icon_display.png", "/ReportTotal"));
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "BaoCaoDonHang"))
                FMIMenu.Items.Add(new MenuItem("Báo cáo đơn hàng", "BaoCaoDonHang", "~/App_Themes/VMMP/images/icon_display.png", "/ReportOrders"));
            NBMenuLeft.Items.Add(FMIMenu);
        }
        #endregion
        if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "DonHang"))
            NBMenuLeft.Items.Add(new MenuItem("Đơn hàng", "DonHang", "~/App_Themes/VMMP/images/icon_order.png", "/OrdersList"));
    }
}
