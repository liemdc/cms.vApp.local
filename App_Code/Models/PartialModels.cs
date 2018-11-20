using Models;
using System;
using System.Web;

public static class LINQData
{
    public static LINQDataContext db
    {
        get
        {
            if (HttpContext.Current.Items["LINQDataContext"] == null)
                HttpContext.Current.Items["LINQDataContext"] = new LINQDataContext();
            return (LINQDataContext)HttpContext.Current.Items["LINQDataContext"];
        }
    }
}
public static class DateTool
{
    public static DateTime Min(DateTime? x, DateTime? y)
    {
        if (x.GetHashCode() == 0) return Convert.ToDateTime(y);
        if (y.GetHashCode() == 0) return Convert.ToDateTime(x);
        return (Convert.ToDateTime(x).ToUniversalTime() < Convert.ToDateTime(y).ToUniversalTime()) ? Convert.ToDateTime(x) : Convert.ToDateTime(y);
    }
    public static DateTime Max(DateTime? x, DateTime? y)
    {
        if (x.GetHashCode() == 0) return Convert.ToDateTime(y);
        if (y.GetHashCode() == 0) return Convert.ToDateTime(x);
        return (Convert.ToDateTime(x).ToUniversalTime() > Convert.ToDateTime(y).ToUniversalTime()) ? Convert.ToDateTime(x) : Convert.ToDateTime(y);
    }
}
public partial class TaskObject
{
    public int TaskId { get; set; }
    public string TaskName { get; set; }
    public string TaskDescription { get; set; }
    public int HistoryId { get; set; }
    public Nullable<DateTime> HistoryBegin { get; set; }
    public Nullable<DateTime> HistoryEnd { get; set; }
    public Nullable<decimal> HistoryDuration { get; set; }
    public int HistoryTaskId { get; set; }
    public int HistoryEmployeeId { get; set; }
    public string UserModified { get; set; }
    public Nullable<DateTime> ModifiedWhen { get; set; }
}
public partial class EmployeeObject
{
    public int EmployeeId { get; set; }
    public int EmployeeProcessId { get; set; }
    public string EmployeeCode { get; set; }
    public string EmployeeFullName { get; set; }
    public string EmployeeFirstName { get; set; }
    public string EmployeeLastName { get; set; }
    public Nullable<DateTime> EmployeeDateOfBirth { get; set; }
    public Nullable<int> EmployeeGender { get; set; }
    public string EmployeeTel { get; set; }
    public string EmployeeDescription { get; set; }
    public string EmployeeStatus { get; set; }
    public Nullable<decimal> ProcessTotal { get; set; }
    public Nullable<decimal> TaskTotal { get; set; }
    public Nullable<DateTime> DateBegin { get; set; }
    public Nullable<DateTime> DateEnd { get; set; }
    public Nullable<DateTime> OrDateBegin { get; set; }
    public Nullable<DateTime> OrDateEnd { get; set; }
}
public partial class EmployeeTaskObject
{
    public int TaskId { get; set; }
    public string TaskName { get; set; }
    public string EmployeeCode { get; set; }
    public Nullable<int> MachineId { get; set; }
    public string MachineName { get; set; }
    public Nullable<DateTime> DateBegin { get; set; }
    public Nullable<DateTime> DateEnd { get; set; }
    public Nullable<decimal> TaskTime { get; set; }
}
public partial class CustomerObject
{
    public int CustomerId { get; set; }
    public string CustomerName { get; set; }
    public string CustomerPhone { get; set; }
    public string CustomerEmail { get; set; }
    public string CustomerAddress { get; set; }
    public string UserModified { get; set; }
}
public partial class MoldsObject
{
    public int MoldsId { get; set; }
    public string MoldsName { get; set; }
    public Nullable<decimal> MoldsMinScheduledDays { get; set; }
    public Nullable<decimal> MoldsFactor { get; set; }
    public string UserModified { get; set; }
}
public partial class ProcessListObject
{
    public int ProcessListId { get; set; }
    public string ProcessListName { get; set; }
    public string ProcessListGroup { get; set; }
    public string ProcessListIds { get; set; }
    public string ProcessListStatus { get; set; }
    public Nullable<bool> DXNhanDuKien { get; set; }
    public Nullable<int> ProcessListOrder { get; set; }
}
public partial class SubProcessObject
{
    public int SubProcessId { get; set; }
    public string SubProcessName { get; set; }
    public Nullable<bool> SubProcessFinish { get; set; }
}
public partial class MachineriesObject
{
    public int MachineryId { get; set; }
    public string MachineryName { get; set; }
    public string MachinerySymbol { get; set; }
    public string MachineryStatus { get; set; }
    public Nullable<DateTime> DateBegin { get; set; }
    public Nullable<DateTime> DateEnd { get; set; }
    public double SumTG { get; set; }
    public double SumHS { get; set; }
    public double CalcPE { get; set; }
}
public partial class OrdersObject {
    public int ProjectTaskID { get; set; }
    public string ProjectTaskMoldCode { get; set; }
    public string ProjectTaskOverlayNum { get; set; }
    public string ProjectTaskHoleNum { get; set; }
    public Nullable<decimal> ProjectTaskDiameterOut { get; set; }
    public string ProjectTaskMaterialsRequire { get; set; }
    public string ProjectTaskMaterialsCode { get; set; }
    public Nullable<int> ProjectTaskMoldsId { get; set; }
    public string ProjectTaskProcessIds { get; set; }
    public Nullable<int> ProjectTaskThickness { get; set; }
    public string ProjectTaskThicknessTotal { get; set; }
    public Nullable<int> ProjectTaskQuantities { get; set; }
    public string ProjectTaskContainHead { get; set; }
    public string ProjectTaskBottoHob { get; set; }
    public string ProjectTaskChildNote { get; set; }
    public string ProjectTaskHorikomi { get; set; }
    public string ProjectTaskHardness { get; set; }
    public Nullable<int> ProjectTaskCustomerId { get; set; }
    public string ProjectTaskDisplayName { get; set; }
    public int ProjectTaskStatusID { get; set; }
    public Nullable<decimal> ProjectTaskPrice { get; set; }
    public Nullable<decimal> ProjectTaskPriceCalc { get; set; }
    public int ProjectTaskPriorityID { get; set; }
    public Nullable<DateTime> ProjectTaskDeadline { get; set; }
    public Nullable<DateTime> ProjectTaskTransmit { get; set; }
    public string ProjectTaskDescription { get; set; }
    public string UserModified { get; set; }
    public Nullable<DateTime> CreatedWhen { get; set; }
    public Nullable<DateTime> ProjectTaskDuKienThoQuaTinh { get; set; }
    public Nullable<DateTime> ProjectTaskThucTeThoQuaTinh { get; set; }
    public string ProjectTaskKetQuaThoQuaTinh { get; set; }
    public Nullable<DateTime> ProjectTaskDuKienTinhQuaQA { get; set; }
    public Nullable<DateTime> ProjectTaskThucTeTinhQuaQA { get; set; }
    public Nullable<DateTime> ProjectTaskDuKienXuatHang { get; set; }
    public Nullable<DateTime> ProjectTaskThucTeXuatHang { get; set; }
}
public partial class MoldsProcessObject
{
    public int MoldsProcessId { get; set; }
    public int MoldsId { get; set; }
    public int ProcessListId { get; set; }
    public string ProcessListName { get; set; }
    public string UserModified { get; set; }
}
public partial class ProjectProcessObject
{
    public int ProcessId { get; set; }
    public int ProcessListId { get; set; }
    public string ProcessListName { get; set; }
    public string ProcessListgroup { get; set; }
    public Nullable<bool> ProcessGangerBrowse { get; set; }
    public Nullable<decimal> ProcessExpectedTime { get; set; }
    public Nullable<decimal> ProcessFactTime { get; set; }
    public string ProcessNotes { get; set; }
    public string UserModified { get; set; }
    public Nullable<DateTime> DateModified { get; set; }
    public Nullable<DateTime> DXNgayNhanThucTe { get; set; }
}
public partial class OrdersProcessObject
{
    public int ProjectTaskID { get; set; }
    public int ProcessListId { get; set; }
    public string ProjectTaskMoldCode { get; set; }
    public string ProjectTaskOverlayNum { get; set; }
    public string MoldsName { get; set; }
    public Nullable<decimal> ProjectTaskDiameterOut { get; set; }
    public Nullable<int> ProjectTaskQuantities { get; set; }
    public Nullable<int> ProjectTaskThickness { get; set; }
    public Nullable<DateTime> ProjectTaskTransmit { get; set; }
    public Nullable<DateTime> ProjectTaskDeadline { get; set; }
    public int ProcessId { get; set; }
    public Nullable<bool> ProcessGangerBrowse { get; set; }
    public Nullable<decimal> ProcessExpectedTime { get; set; }
    public Nullable<decimal> ProcessFactTime { get; set; }
    public Nullable<int> ProcessPlusBrowse { get; set; }
    public string CustomerName { get; set; }
    public int ProjectTaskPriorityID { get; set; }
    public Nullable<DateTime> ProcessExpectedCompletion { get; set; }
    public int AutoPriority { get; set; }
    public Nullable<DateTime> ProjectTaskDuKienThoQuaTinh { get; set; }
    public Nullable<DateTime> ProjectTaskDuKienTinhQuaQA { get; set; }
    public string ProcessNotes { get; set; }
    public Nullable<DateTime> DXGioBatDauDuKien { get; set; }
    public Nullable<DateTime> DXGioKetThucDuKien { get; set; }
    public string DXMaSanPhamUuTienGiaCong { get; set; }
    public Nullable<decimal> DXThoiGianDieuChinh { get; set; }
    public Nullable<DateTime> DXNgayNhanThucTe { get; set; }
    public Nullable<DateTime> DXGioBatDauThucTe { get; set; }
    public Nullable<DateTime> DXGioKetThucThucTe { get; set; }
    public Nullable<int> DXChuyenQuaCongDoan { get; set; }
}
public partial class OrdersProcessDetailObject
{
    public int DetailId { get; set; }
    public int ProjectTaskID { get; set; }
    public int SubProcessID { get; set; }
    public string ProjectTaskMoldCode { get; set; }    
    public Nullable<int> DetailMachineId { get; set; }
    public Nullable<DateTime> DetailStartTimeM { get; set; }
    public Nullable<DateTime> DetailEndTimeM { get; set; }
    public Nullable<int> DetailOwnerM { get; set; }
    public Nullable<decimal> DetailTotalTimeM { get; set; }
}
public partial class UserInfoObject
{
    public int UserID { get; set; }
    public string FullName { get; set; }
    public string Email { get; set; }
    public Nullable<DateTime> UserDateOfBirth { get; set; }
    public Nullable<DateTime> UserCreated { get; set; }
    public Nullable<DateTime> LastLogon { get; set; }
}
public partial class RoleInfoObject
{
    public int RoleID { get; set; }
    public string RoleName { get; set; }
    public string RoleDisplayName { get; set; }
    public string RoleDescription { get; set; }
}
public partial class PermissionsObject
{
    public int PermissionID { get; set; }
    public string PermissionDisplayName { get; set; }
    public bool PermissionAllow { get; set; }
}
