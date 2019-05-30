using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.SettingsProvider;
using CMS.SiteProvider;
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