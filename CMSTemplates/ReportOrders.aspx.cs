using CMS.UIControls;
using DevExpress.Web.ASPxPivotGrid;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSTemplates_ReportOrders : TemplatePage {
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            DeStart.Date = Convert.ToDateTime("01/01/" + DateTime.Now.Year + " 00:00");
            DeEnd.Date = Convert.ToDateTime("31/12/" + DateTime.Now.Year + " 00:00");
        }
        PGReportOrders.CellTemplate = new CellTemplate();
    }
    protected class CellTemplate : ITemplate {
        void ITemplate.InstantiateIn(Control container) {
            PivotGridCellTemplateContainer templateContainer = (PivotGridCellTemplateContainer)container;
            DevExpress.Web.ASPxPivotGrid.PivotGridField field = templateContainer.DataField;
            Table table = new Table();
            table.Width = Unit.Pixel(110);
            templateContainer.Controls.Add(table);

            TableRow row = new TableRow();
            table.Controls.Add(row);

            TableCell cell = new TableCell();
            cell.Style.Add(HtmlTextWriterStyle.Padding, "0");
            cell.Width = Unit.Pixel(88);
            cell.Height = Unit.Pixel(16);
            if (templateContainer.Item.Value == null)
                cell.BackColor = Color.FromArgb(255, 0, 0);
            if (Convert.ToInt32(templateContainer.Item.Value) == 7)
                cell.BackColor = Color.FromArgb(15, 170, 21);
            if (Convert.ToInt32(templateContainer.Item.Value) == 3)
                cell.BackColor = Color.FromArgb(247, 126, 14);
            row.Controls.Add(cell);

            cell = new TableCell();
            cell.Text = templateContainer.Item.Text;
            cell.Wrap = false;
            row.Controls.Add(cell);
        }
    }
    protected void PGReportOrders_CustomCellDisplayText(object sender, PivotCellDisplayTextEventArgs e) {
        if (e.DisplayText == "3")
            e.DisplayText = "Đang chạy";
        if (e.DisplayText == "7")
            e.DisplayText = "Hoàn thành";
        if (e.DisplayText.Length <= 0)
            e.DisplayText = "Không dùng";
    }
}