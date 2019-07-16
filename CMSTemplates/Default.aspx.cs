using CMS.UIControls;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_Default : TemplatePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //List<PM_ProjectTask> listPt = LINQData.db.PM_ProjectTasks.ToList();
        //foreach (var item in listPt) {
            //item.DX_MaDonHang = SystemModels.Fn_Get_MaDinhDanh(item.ProjectTaskLastModified.Year.ToString(), "DH", 6, "Mã đơn hàng");
        //}
        //LINQData.db.SubmitChanges();
    }
}