using CMS.CMSHelper;
using CMS.SiteProvider;
using Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;

public class ProcessListModels {
	public static List<ProcessListObject> MinProcessList() {        
        return LINQData.db.PM_ProjectProcessLists.Select(s => new ProcessListObject { 
            ProcessListId = s.ProcessListId, ProcessListName = s.ProcessListName, ProcessListGroup = s.ProcessListGroup, ProcessListOrder = s.ProcessListOrder
        }).OrderBy(o => o.ProcessListOrder).ToList();
    }
    public static void ProcessListCreated(string ProcessListName, string ProcessListGroup) {
        using (TransactionScope transactionScope = new TransactionScope()) {
            try { 
                PM_ProjectProcessList ProcessList = new PM_ProjectProcessList();
                ProcessList.ProcessListName = ProcessListName;
                ProcessList.ProcessListGroup = ProcessListGroup;
                ProcessList.ProcessListOrder = LINQData.db.PM_ProjectProcessLists.Max(max => max.ProcessListOrder) + 1;
                LINQData.db.PM_ProjectProcessLists.InsertOnSubmit(ProcessList);
                LINQData.db.SubmitChanges();
                if (ProcessList != null && DataUtils.CreatePermission(ProcessList.ProcessListName, "CongDoan" + ProcessList.ProcessListId, "Functions")) {
                    DataUtils.CreateModule(ProcessList.ProcessListName, "CongDoan" + ProcessList.ProcessListId);
                    DataUtils.CreatePermission("Cập nhật loại việc", "CapNhatLoaiViec", "CongDoan" + ProcessList.ProcessListId);
                    DataUtils.CreatePermission("Cập nhật sản phẩm", "CapNhatSanPham", "CongDoan" + ProcessList.ProcessListId);
                }
                transactionScope.Complete();
            } catch { }
        }
    }
    public static void ProcessListUpdated(int ProcessListId, string ProcessListName, string ProcessListGroup) {
        using (TransactionScope transactionScope = new TransactionScope()) {
            try {
                PM_ProjectProcessList ProcessList = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListId == ProcessListId);
                ProcessList.ProcessListName = ProcessListName;
                ProcessList.ProcessListGroup = ProcessListGroup;
                LINQData.db.SubmitChanges();
                if (ProcessList != null) {
                    ResourceInfo rsInfo = ResourceInfoProvider.GetResourceInfo("CongDoan" + ProcessListId.ToString());
                    rsInfo.ResourceDisplayName = ProcessListName;
                    ResourceInfoProvider.SetResourceInfo(rsInfo);
                    PermissionNameInfo pnInfo = PermissionNameInfoProvider.GetPermissionNameInfo("CongDoan" + ProcessListId.ToString(), "Functions", null);
                    pnInfo.PermissionDisplayName = Convert.ToString(ProcessListName);
                    PermissionNameInfoProvider.SetPermissionInfo(pnInfo);
                }
                transactionScope.Complete();
            } catch { }
        }
    }
    public static void ProcessListDeleted(int ProcessListId){
        using (TransactionScope transactionScope = new TransactionScope()) {
            try {
                if (!DataUtils.DeletePermission("CongDoan" + ProcessListId, "Functions"))
                    throw new NotImplementedException();
                if (!DataUtils.DeleteModule("CongDoan" + ProcessListId))
                    throw new NotImplementedException();
                PM_ProjectProcessList ProcessList = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListId == ProcessListId);
                List<PM_ProjectSubProcess> SubProcessList = LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == ProcessList.ProcessListId).ToList();
                List<PM_ProjectProcessDetail> ProjectProcessDetail = LINQData.db.PM_ProjectProcessDetails.Where(w => SubProcessList.Select(s => s.SubProcessId).Contains(w.DetailSubProcessId)).ToList();
                LINQData.db.PM_ProjectProcessDetails.DeleteAllOnSubmit(ProjectProcessDetail);
                LINQData.db.PM_ProjectSubProcesses.DeleteAllOnSubmit(SubProcessList);
                LINQData.db.PM_ProjectProcessLists.DeleteOnSubmit(ProcessList);
                LINQData.db.SubmitChanges();
                transactionScope.Complete();
            } catch (Exception ex ) { System.Diagnostics.Debug.WriteLine(ex.Message); }
        }
    } 
    public static List<OrdersProcessDetailObject> ProjectProcessDetailByMachineId(int MachineryId){
        return LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailMachineId == MachineryId)
            .Join(LINQData.db.PM_ProjectTasks, ppd => ppd.DetailProjectTaskID, pt => pt.ProjectTaskID, (ppd, pt) => new { ppd, pt })
            .Select(s => new OrdersProcessDetailObject {
                DetailId = s.ppd.DetailId, ProjectTaskID = s.ppd.DetailProjectTaskID, DetailStartTimeM = s.ppd.DetailStartTimeM, DetailEndTimeM = s.ppd.DetailEndTimeM, ProjectTaskMoldCode = s.pt.ProjectTaskMoldCode
            }).OrderByDescending(o => o.DetailEndTimeM).ToList();
    } 
    public static List<OrdersProcessDetailObject> ProjectProcessDetailByMachineId(int MachineryId, DateTime DeStartDA, DateTime DeEndDA){
        return LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailMachineId == MachineryId && w.DetailStartTimeM >= DeStartDA && w.DetailEndTimeM <= DeEndDA)
            .Join(LINQData.db.PM_ProjectTasks, ppd => ppd.DetailProjectTaskID, pt => pt.ProjectTaskID, (ppd, pt) => new { ppd, pt })
            .Select(s => new OrdersProcessDetailObject {
                DetailId = s.ppd.DetailId, ProjectTaskID = s.ppd.DetailProjectTaskID, DetailStartTimeM = s.ppd.DetailStartTimeM, DetailEndTimeM = s.ppd.DetailEndTimeM, ProjectTaskMoldCode = s.pt.ProjectTaskMoldCode
            }).OrderByDescending(o => o.DetailEndTimeM).ToList();
    } 
    public static List<ProcessListObject> MinProcessListNotInMoldsId(int MoldsId) {      
        return LINQData.db.PM_ProjectProcessLists
            .Where(w => !LINQData.db.IV_tblMoldsProcesses.Where(w1 => w1.MoldsId == MoldsId).Select(s => s.ProcessListId).ToArray().Contains(w.ProcessListId))
            .Select(s => new ProcessListObject { 
                ProcessListId = s.ProcessListId, ProcessListName = s.ProcessListName, ProcessListOrder = s.ProcessListOrder
            }).OrderBy(o => o.ProcessListOrder).ToList();
    }
    public static List<ProcessListObject> MinProcessListNotInTaskId(int ProjectTaskID) {
        return LINQData.db.PM_ProjectProcessLists
            .Where(w => !LINQData.db.PM_ProjectProcesses.Where(w1 => w1.ProcessProjectTaskID == ProjectTaskID).Select(s => s.ProcessListId).ToArray().Contains(w.ProcessListId))
            .Select(s => new ProcessListObject {
                ProcessListId = s.ProcessListId, ProcessListName = s.ProcessListName, ProcessListOrder = s.ProcessListOrder
            }).OrderBy(o => o.ProcessListOrder).ToList();
    }
    public static List<ProcessListObject> MinProcessListForUserId() {
        List<ProcessListObject> ProcessList = LINQData.db.PM_ProjectProcessLists.Select(s => new ProcessListObject { ProcessListId = s.ProcessListId, ProcessListName = s.ProcessListName, ProcessListGroup = s.ProcessListGroup, ProcessListOrder = s.ProcessListOrder }).OrderBy(o => o.ProcessListOrder).ToList();
        List<ProcessListObject> UsProcessList = new List<ProcessListObject>();
        foreach (ProcessListObject Process in ProcessList) {
            if (CMSContext.CurrentUser.IsAuthorizedPerResource("Functions", "CongDoan" + Process.ProcessListId))
                UsProcessList.Add(Process);
        }
        return UsProcessList;
    }
    public static List<ProcessListObject> MinProcessListIsFinish(int ProjectTaskID, int ProcessListId) {
        List<ProcessListObject> ProcessList = LINQData.db.PM_ProjectProcesses.Where(w => w.ProcessProjectTaskID == ProjectTaskID && w.ProcessGangerBrowse == true && w.ProcessListId != ProcessListId)
            .Join(LINQData.db.PM_ProjectProcessLists, pp => pp.ProcessListId, ppl => ppl.ProcessListId, (pp, ppl) => new { pp, ppl})
            .Select(s => new ProcessListObject { ProcessListId = s.pp.ProcessListId, ProcessListName = s.ppl.ProcessListName }).OrderBy(o => o.ProcessListName).ToList();
        if (LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessProjectTaskID == ProjectTaskID && fod.ProcessPlusBrowse == ProcessListId) != null) {
            ProcessList.RemoveAll(ra => ra.ProcessListId != ProcessListId);
            ProcessList.Add(new ProcessListObject() { ProcessListId = ProcessListId, ProcessListName = "Đang hỗ trợ" });
            ProcessList.Add(new ProcessListObject() { ProcessListId = 0, ProcessListName = "Hoàn thành" });
        }
        return ProcessList;
    }
    public static List<SubProcessObject> SubProcessList(int SubProcessListId) {
        return LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == SubProcessListId)
            .Select(s => new SubProcessObject { 
                SubProcessId = s.SubProcessId, SubProcessName = s.SubProcessName, SubProcessFinish = s.SubProcessFinish
            }).OrderBy(o => o.SubProcessName).ToList();
    }
    public static void SubProcessCreated(int SubProcessListId, bool SubProcessFinish, string SubProcessName) {
        LINQData.db.PM_ProjectSubProcesses.InsertOnSubmit(new PM_ProjectSubProcess() {
            SubProcessListId = SubProcessListId, SubProcessName = SubProcessName, SubProcessFinish = SubProcessFinish
        });
        LINQData.db.SubmitChanges();
    }
    public static void SubProcessUpdated(int SubProcessId, int SubProcessListId, bool SubProcessFinish, string SubProcessName) {
        using (TransactionScope transactionScope = new TransactionScope()) {
            try {
                PM_ProjectSubProcess SubProcess = LINQData.db.PM_ProjectSubProcesses.FirstOrDefault(fod => fod.SubProcessId == SubProcessId);
                if (SubProcessFinish) {
                    LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == SubProcessListId && w.SubProcessId != SubProcessId).ToList().ForEach(fe => fe.SubProcessFinish = false);
                    SubProcess.SubProcessFinish = SubProcessFinish;
                }
                SubProcess.SubProcessName = SubProcessName;
                LINQData.db.SubmitChanges();
                transactionScope.Complete();
            } catch { }
        }
    }
    public static void SubProcessDeleted(int SubProcessId) {
        PM_ProjectSubProcess SubProcess = LINQData.db.PM_ProjectSubProcesses.FirstOrDefault(fod => fod.SubProcessId == SubProcessId);
        if (SubProcess != null) {
            LINQData.db.PM_ProjectSubProcesses.DeleteOnSubmit(SubProcess);
            LINQData.db.SubmitChanges();
        }
    }
    public static List<MachineriesObject> MachineriesList(int SubProcessListID) {        
        return LINQData.db.PM_ProjectMachineries.Where(m => m.MachineryProcessListId == SubProcessListID)
            .Select(s => new MachineriesObject { 
                MachineryId = s.MachineryId, MachineryName = s.MachineryName, MachinerySymbol = s.MachinerySymbol, MachineryStatus = s.MachineryStatus
            }).OrderBy(o => o.MachineryName).ToList();
    }
    public static List<MachineriesObject> MachineriesList(DateTime DeStartD, DateTime DeEndD) {
        double day = (DeEndD - DeStartD).TotalDays;
        if (day == 0) day = 1;
        List<MachineriesObject> ls = LINQData.db.PM_ProjectMachineries
            .Join(LINQData.db.PM_ProjectProcessDetails, pm => pm.MachineryId, ppd => ppd.DetailMachineId, (pm, ppd) => new { pm, ppd })
            .Join(LINQData.db.PM_ProjectTasks, pmppd => pmppd.ppd.DetailProjectTaskID, pt => pt.ProjectTaskID, (pmppd, pt) => new { pmppd, pt })
            .Where(w => w.pmppd.ppd.DetailStartTimeM >= DeStartD && w.pmppd.ppd.DetailEndTimeM <= DeEndD)
            .Select(s => new MachineriesObject{
                MachineryId = s.pmppd.pm.MachineryId,
                MachineryName = s.pmppd.pm.MachineryName,
                MachinerySymbol = s.pmppd.pm.MachinerySymbol,
                MachineryStatus = s.pmppd.pm.MachineryStatus,
                SumTG = (s.pmppd.ppd.DetailEndTimeM - s.pmppd.ppd.DetailStartTimeM).Value.TotalMinutes,
                SumHS = 0, CalcPE = 0,
                DateBegin = DeStartD,
                DateEnd = DeEndD
            }).OrderBy(o => o.MachineryName).ToList();
        return ls.GroupBy(g => g.MachineryId)
            .Select(s => new MachineriesObject {
                MachineryId = s.Key,
                MachineryName = s.Select(w => w.MachineryName).FirstOrDefault(),
                MachinerySymbol = s.Select(w => w.MachinerySymbol).FirstOrDefault(),
                MachineryStatus = s.Select(w => w.MachineryStatus).FirstOrDefault(),
                SumTG = s.Sum(w => w.SumTG) / 60,
                SumHS = (s.Sum(w => w.SumTG) / 60)/(day * 24),
                CalcPE = (s.Sum(w => w.SumTG) / 60) / (day * 24) < 0 ? 0 : ((s.Sum(w => w.SumTG) / 60) / (day * 24)) * 100,
                DateBegin = DeStartD,
                DateEnd = DeEndD
            }).ToList();
    }
    public static void MachineriesCreated(int SubProcessListId, string MachineryName, string MachinerySymbol, string MachineryStatus) {
        LINQData.db.PM_ProjectMachineries.InsertOnSubmit(new PM_ProjectMachinery() {
            MachineryProcessListId = SubProcessListId, MachineryName = MachineryName, MachinerySymbol = MachinerySymbol, MachineryStatus = MachineryStatus
        });
        LINQData.db.SubmitChanges();
    }
    public static void MachineriesUpdated(int MachineryId, string MachineryName, string MachinerySymbol, string MachineryStatus) {
        PM_ProjectMachinery Machinery = LINQData.db.PM_ProjectMachineries.FirstOrDefault(fod => fod.MachineryId == MachineryId);
        Machinery.MachineryName = MachineryName;
        Machinery.MachinerySymbol = MachinerySymbol;
        Machinery.MachineryStatus = MachineryStatus;
        LINQData.db.SubmitChanges();
    }
    public static void MachineriesDeleted(int MachineryId) {
        PM_ProjectMachinery Machinery = LINQData.db.PM_ProjectMachineries.FirstOrDefault(fod => fod.MachineryId == MachineryId);
        if (Machinery != null) {
            LINQData.db.PM_ProjectMachineries.DeleteOnSubmit(Machinery);
            LINQData.db.SubmitChanges();
        }
    }
}