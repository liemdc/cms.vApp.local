using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.SettingsProvider;
using CMS.SiteProvider;
using Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_DevNext : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //List<PM_ProjectTask> listPt = LINQData.db.PM_ProjectTasks.ToList();
        //foreach (var item in listPt) {
        //    //item.DX_MaDonHang = SystemModels.Fn_Get_MaDinhDanh(item.ProjectTaskLastModified.Year.ToString(), "DH", 6, "Mã đơn hàng");
        //    DonHang_CongDoanTG data = new DonHang_CongDoanTG{};
        //    data.DX_DuKienHT_EDM = item.DX_DuKienHT_EDM;
        //    data.DX_DuKienHT_Mai = item.DX_DuKienHT_Mai;
        //    data.DX_DuKienHT_MC = item.DX_DuKienHT_MC;
        //    data.DX_DuKienHT_NC = item.DX_DuKienHT_NC;
        //    data.DX_DuKienHT_Nhiet = item.DX_DuKienHT_Nhiet;
        //    data.DX_DuKienHT_PhayTay = item.DX_DuKienHT_PhayTay;
        //    data.DX_DuKienHT_QA = item.DX_DuKienHT_QA;
        //    data.DX_DuKienHT_WEDM = item.DX_DuKienHT_WEDM;
        //    data.DX_XuatHang_DuKien = item.DX_XuatHang_DuKien;
        //    data.DX_XuatHang_ThucTe = item.DX_XuatHang_ThucTe;

        //    JObject o = (JObject)JToken.FromObject(data);

        //    item.DX_CongDoanTG = o.ToString(Formatting.None);
        //    //DataUtils.WriteLog(o.ToString(Formatting.None));
        //}
        //LINQData.db.SubmitChanges();
        //foreach (var item in listPt)
        //{
        //    DataUtils.WriteLog(item.DX_MaDonHang);
        //}
        //CustomTableItemProvider customTableProvider = new CustomTableItemProvider(CMSContext.CurrentUser);
        //string MaLuuTru = "DX.MaLuuTru";
        //DataClassInfo DX_MaLuuTru = DataClassInfoProvider.GetDataClass(MaLuuTru);

        //if (DX_MaLuuTru != null) {
        //    DataSet dataSet = customTableProvider.GetItems(MaLuuTru, null, null);
        //    var IList = dataSet.Tables[0].AsEnumerable().ToList();
        //    for (int i = 0; i < IList.Count; i++)
        //    {
        //        DataUtils.WriteLog(IList[i].Field<string>("MaTXT").ToString());
        //    }
        //}
        DataUtils.WriteLog(Convert.ToDateTime("2019-07-21T00:00:00").ToString());
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        // Create new Custom table item provider
        CustomTableItemProvider customTableProvider = new CustomTableItemProvider(CMSContext.CurrentUser);

        // Prepares the code name (class name) of the custom table
        string MaLuuTru = "DX.MaLuuTru";

        // Check if Custom table 'Sample table' exists
        DataClassInfo DX_MaLuuTru = DataClassInfoProvider.GetDataClass(MaLuuTru);

        if (DX_MaLuuTru != null)
        {
            // Prepare the parameters
            string where = string.Format("MaDinhDanh = N'ĐH{0}'", DateTime.Now.Year.ToString().Substring(2, 2));
            int topN = 1;
            string columns = "ItemID";

            // Get the data set according to the parameters
            DataSet dataSet = customTableProvider.GetItems(MaLuuTru, where, null, topN, columns);
            if (!DataHelper.DataSourceIsEmpty(dataSet)) {

                // Get the custom table item ID
                int itemID = ValidationHelper.GetInteger(dataSet.Tables[0].Rows[0][0], 0);

                // Get the custom table item
                CustomTableItem DX_MaLuuTru_Item = customTableProvider.GetItem(itemID, MaLuuTru);

                if (DX_MaLuuTru_Item != null) {

                    string item1 = ValidationHelper.GetString(DX_MaLuuTru_Item.GetValue("MaDinhDanh"), "");
                    int item2 = ValidationHelper.GetInteger(DX_MaLuuTru_Item.GetValue("SoDinhDanh"), 0);
                    item2 = item2 + 1;

                    StringBuilder sb = new StringBuilder();

                    string newText = sb.Append('0', 8 - item2.ToString().Length).ToString() + item2;

                    txtOut.Text = item1 + newText;

                    // Set new values
                    DX_MaLuuTru_Item.SetValue("SoDinhDanh", newText);

                    // Save the changes
                    DX_MaLuuTru_Item.Update();

                    //// Create new custom table item
                    //CustomTableItem newItem = new CustomTableItem(MaLuuTru, customTableProvider);

                    //// Set the ItemText field value
                    //newItem.SetValue("MaDinhDanh", "ĐH" + DateTime.Now.Year.ToString().Substring(2,2));
                    //newItem.SetValue("SoDinhDanh", "00000000");

                    //// Insert the custom table item into database
                    //newItem.Insert();

                }

            }
        }
    }
}