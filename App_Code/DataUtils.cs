using CMS.SiteProvider;
using DevExpress.Web;
using DevExpress.Utils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

public class DataUtils {
    public static DataTable LINQToDataTable<T>(IEnumerable<T> varlist){
        DataTable dtReturn = new DataTable();
        System.Reflection.PropertyInfo[] oProps = null;
        if (varlist == null) return dtReturn;
        foreach (T rec in varlist){
            if (oProps == null){
                oProps = ((Type)rec.GetType()).GetProperties();
                foreach (System.Reflection.PropertyInfo pi in oProps){
                    Type colType = pi.PropertyType;
                    if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition() == typeof(Nullable<>))){
                        colType = colType.GetGenericArguments()[0];
                    }
                    dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
                }
            }
            DataRow dr = dtReturn.NewRow();
            foreach (System.Reflection.PropertyInfo pi in oProps){
                dr[pi.Name] = pi.GetValue(rec, null) == null ? DBNull.Value : pi.GetValue
                (rec, null);
            }
            dtReturn.Rows.Add(dr);
        }
        return dtReturn;
    }
    public static GridViewDataTextColumn GvDataTextColumn(string fieldName, string caption, int width = 100, int index = 1, int eIndex = 1, 
        GridViewColumnFixedStyle fixedStyle = GridViewColumnFixedStyle.None, bool isRequired = true, string errorText = "auto", Display display = Display.Dynamic, int columnSpan = 1, bool visible = true, DefaultBoolean eVisible = DefaultBoolean.True, string strFormat = null) {
        GridViewDataTextColumn nDataTextColumn = new GridViewDataTextColumn();
        nDataTextColumn.FieldName = fieldName;
        nDataTextColumn.Caption = caption;
        nDataTextColumn.Width = width;
        nDataTextColumn.Visible = visible;
        nDataTextColumn.VisibleIndex = index;
        nDataTextColumn.PropertiesTextEdit.DisplayFormatString = strFormat;
        nDataTextColumn.EditFormSettings.VisibleIndex = eIndex;
        nDataTextColumn.EditFormSettings.ColumnSpan = columnSpan;
        nDataTextColumn.EditFormSettings.Visible = eVisible;
        nDataTextColumn.FixedStyle = fixedStyle;
        nDataTextColumn.PropertiesTextEdit.ValidationSettings.RequiredField.IsRequired = isRequired;
        nDataTextColumn.PropertiesTextEdit.ValidationSettings.RequiredField.ErrorText = errorText == "auto" ? caption + " không được bỏ trống!" : errorText;
        nDataTextColumn.PropertiesTextEdit.ValidationSettings.Display = display;        
        return nDataTextColumn;
    }
    public static GridViewDataComboBoxColumn GvDataComboBoxColumn(string fieldName, string caption, int width = 100, int index = 1, int eIndex = 1, 
        string dataSourceID = null, string textField = null, string valueField = null, string type = null,
        GridViewColumnFixedStyle fixedStyle = GridViewColumnFixedStyle.None, bool isRequired = true, string errorText = "auto", Display display = Display.Dynamic){
        GridViewDataComboBoxColumn nDataComboBoxColumn = new GridViewDataComboBoxColumn();
        nDataComboBoxColumn.FieldName = fieldName;
        nDataComboBoxColumn.Caption = caption;
        nDataComboBoxColumn.Width = width;
        nDataComboBoxColumn.VisibleIndex = index;
        nDataComboBoxColumn.EditFormSettings.VisibleIndex = eIndex;
        nDataComboBoxColumn.FixedStyle = fixedStyle;        
        nDataComboBoxColumn.PropertiesComboBox.DataSourceID = dataSourceID;
        nDataComboBoxColumn.PropertiesComboBox.TextField = textField;
        nDataComboBoxColumn.PropertiesComboBox.ValueField = valueField;
        if (type == null) nDataComboBoxColumn.PropertiesComboBox.ValueType = typeof(Int32);
        else nDataComboBoxColumn.PropertiesComboBox.ValueType = typeof(String);
        nDataComboBoxColumn.PropertiesComboBox.DropDownStyle = DropDownStyle.DropDown;
        nDataComboBoxColumn.PropertiesComboBox.IncrementalFilteringMode = IncrementalFilteringMode.StartsWith;
        nDataComboBoxColumn.PropertiesComboBox.ValidationSettings.RequiredField.IsRequired = isRequired;
        nDataComboBoxColumn.PropertiesComboBox.ValidationSettings.RequiredField.ErrorText = errorText == "auto" ? caption + " không được bỏ trống!" : errorText;
        nDataComboBoxColumn.PropertiesComboBox.ValidationSettings.Display = display;
        return nDataComboBoxColumn;
    }
    public static bool CreateModule(string displayName, string Name){
        try {
            ResourceInfo newModule = new ResourceInfo();
            newModule.ResourceDisplayName = displayName;
            newModule.ResourceName = Name;
            ResourceInfoProvider.SetResourceInfo(newModule);
            return true;
        } catch { return false; }
    }
    public static bool DeleteModule(string resourceName){
        ResourceInfo deleteModule = ResourceInfoProvider.GetResourceInfo(resourceName);
        ResourceInfoProvider.DeleteResourceInfo(deleteModule);
        return (deleteModule != null);
    }
    public static bool CreatePermission(string displayName, string Name, string resourceName){
        ResourceInfo module = ResourceInfoProvider.GetResourceInfo(resourceName);
        if (module != null){
            PermissionNameInfo newPermission = new PermissionNameInfo();
            newPermission.PermissionDisplayName = displayName;
            newPermission.PermissionName = Name;
            newPermission.ResourceId = module.ResourceId;
            PermissionNameInfoProvider.SetPermissionInfo(newPermission);
            return true;
        } return false;
    }
    public static bool DeletePermission(string permissionName, string resourceName){
        PermissionNameInfo deletePermission = PermissionNameInfoProvider.GetPermissionNameInfo(permissionName, resourceName, null);
        PermissionNameInfoProvider.DeletePermissionInfo(deletePermission);
        return (deletePermission != null);
    }
}