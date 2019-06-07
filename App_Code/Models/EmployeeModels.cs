using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class EmployeeModels {
    public static List<EmployeeObject> EmployeeList() {        
        return LINQData.db.PM_ProjectEmployees.Select(s => new EmployeeObject {
            EmployeeId = s.EmployeeID, EmployeeCode = s.EmployeeCode, EmployeeLastName = s.EmployeeLastName, EmployeeFirstName = s.EmployeeFirstName, EmployeeTel = s.EmployeeTel, EmployeeDateOfBirth = s.EmployeeDateOfBirth, EmployeeGender = s.EmployeeGender, EmployeeStatus = s.EmployeeStatus, EmployeeDescription = s.EmployeeDescription
        }).OrderBy(o => o.EmployeeCode).ToList();
    }
	public static List<EmployeeObject> MinEmployeeList() {        
        return LINQData.db.PM_ProjectEmployees
            .Select(s => new EmployeeObject {
                EmployeeId = s.EmployeeID, EmployeeCode = s.EmployeeCode, EmployeeFullName = s.EmployeeFullName
            }).OrderBy(o => o.EmployeeFullName).ToList();
    }

    public static void EmployeeCreated(string EmployeeCode, string EmployeeLastName, string EmployeeFirstName, string EmployeeTel, DateTime EmployeeDateOfBirth, int EmployeeGender, string EmployeeStatus, string EmployeeDescription) {
        LINQData.db.PM_ProjectEmployees.InsertOnSubmit(new PM_ProjectEmployee() { 
            EmployeeCode = EmployeeCode, EmployeeLastName = EmployeeLastName, EmployeeFirstName = EmployeeFirstName, EmployeeFullName = string.Format("{0} {1}", EmployeeLastName, EmployeeFirstName), EmployeeTel = EmployeeTel, EmployeeDateOfBirth = EmployeeDateOfBirth, EmployeeGender = EmployeeGender, EmployeeStatus = EmployeeStatus, EmployeeDescription = EmployeeDescription
        });
        LINQData.db.SubmitChanges();
    }
    public static void EmployeeUpdated(int EmployeeId, string EmployeeCode, string EmployeeLastName, string EmployeeFirstName, string EmployeeTel, DateTime EmployeeDateOfBirth, int EmployeeGender, string EmployeeStatus, string EmployeeDescription) {
        PM_ProjectEmployee Employee = LINQData.db.PM_ProjectEmployees.FirstOrDefault(fod => fod.EmployeeID == EmployeeId);
        if (Employee != null) {
            Employee.EmployeeCode = EmployeeCode;
            Employee.EmployeeLastName = EmployeeLastName;
            Employee.EmployeeFirstName = EmployeeFirstName;
            Employee.EmployeeFullName = string.Format("{0} {1}", EmployeeLastName, EmployeeFirstName);
            Employee.EmployeeTel = EmployeeTel;
            Employee.EmployeeDateOfBirth = EmployeeDateOfBirth;
            Employee.EmployeeGender = EmployeeGender;
            Employee.EmployeeStatus = EmployeeStatus;
            Employee.EmployeeDescription = EmployeeDescription;
            LINQData.db.SubmitChanges();
        }
    }
    public static void EmployeeDeleted(int EmployeeId) {
        PM_ProjectEmployee Employee = LINQData.db.PM_ProjectEmployees.FirstOrDefault(fod => fod.EmployeeID == EmployeeId);
        if (Employee != null) {
            LINQData.db.PM_ProjectEmployees.DeleteOnSubmit(Employee);
            LINQData.db.SubmitChanges();
        }
    }
    public static List<EmployeeObject> MinEmployeeListByProcessListId(int ProcessListId) {
        return LINQData.db.PM_ProjectEmployeeProcesses.Where(w => w.ProcessListID == ProcessListId)
                          .Join(LINQData.db.PM_ProjectEmployees, pep => pep.EmployeeID, pe => pe.EmployeeID, (pep, pe) => new {pep, pe})
                          .Select(s => new EmployeeObject {
                            EmployeeId = s.pe.EmployeeID, EmployeeCode = s.pe.EmployeeCode, EmployeeFullName = s.pe.EmployeeFullName
                          }).OrderBy(o => o.EmployeeFullName).ToList();
    }
    public static List<EmployeeObject> EmployeeListTask(DateTime PRDateBegin, DateTime PRDateEnd) {
        return LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailStartTimeM >= PRDateBegin && w.DetailEndTimeM <= PRDateEnd).GroupBy(g => g.DetailOwnerM).Select(s => new { DetailOwnerM = s.Key, ppd = s })
                   .GroupJoin(LINQData.db.IV_tblTaskHistories.Where(w => w.HistoryBegin >= PRDateBegin && w.HistoryEnd <= PRDateEnd).GroupBy(g => g.HistoryEmployeeId).Select(s => new { HistoryEmployeeId = s.Key, th = s }), ppd => ppd.DetailOwnerM, th => th.HistoryEmployeeId, (ppd, th) => new { ppd, th })
                   .SelectMany(sm => sm.th.DefaultIfEmpty(), (sm, th) => new { sm.ppd, th})
                   .GroupJoin(LINQData.db.PM_ProjectEmployees, ppd => ppd.ppd.DetailOwnerM, pe => pe.EmployeeID, (ppd, pe) => new {ppd, pe})
                   .SelectMany(sm => sm.pe, (sm, pe) => new EmployeeObject{
                       EmployeeId = pe.EmployeeID, EmployeeFullName = pe.EmployeeFullName, ProcessTotal = sm.ppd.ppd.ppd.Sum(sum => sum.DetailTotalTimeM), TaskTotal = sm.ppd.th.th.Sum(sum => sum.HistoryDuration),
                       DateBegin = sm.ppd.ppd.ppd.Min(min => min.DetailStartTimeM), OrDateBegin = sm.ppd.th.th.Min(min => min.HistoryBegin),
                       DateEnd = sm.ppd.ppd.ppd.Max(max => max.DetailEndTimeM), OrDateEnd = sm.ppd.th.th.Max(max => max.HistoryEnd)
                   }).ToList();
    }
    public static List<EmployeeTaskObject> EmployeeTaskTaskDetail(int EmployeeId, DateTime PRDateBegin, DateTime PRDateEnd, bool Machine) {
        List<EmployeeTaskObject> EmployeeTask = new List<EmployeeTaskObject>();
        EmployeeTask = LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailOwnerM == EmployeeId && w.DetailEndTimeM <= PRDateEnd && w.DetailStartTimeM >= PRDateBegin)
            .Join(LINQData.db.PM_ProjectSubProcesses, ppd => ppd.DetailSubProcessId, psd => psd.SubProcessId, (ppd, psd) => new {ppd, psd})
            .Select(s => new EmployeeTaskObject {
                TaskId = s.ppd.DetailOwnerM, DateBegin = s.ppd.DetailStartTimeM, DateEnd = s.ppd.DetailEndTimeM, TaskName = s.psd.SubProcessName, TaskTime = s.ppd.DetailTotalTimeM, MachineId = s.ppd.DetailMachineId == null ? 0 : s.ppd.DetailMachineId
            }).ToList();
        EmployeeTask.AddRange(LINQData.db.IV_tblTaskHistories.Where(w => w.HistoryEmployeeId == EmployeeId && w.HistoryEnd <= PRDateEnd && w.HistoryBegin >= PRDateBegin)
            .Join(LINQData.db.IV_tblTasks, th => th.HistoryTaskId, t => t.TaskId, (th, t) => new {th, t})
            .Select(s => new EmployeeTaskObject { 
                TaskId = s.th.HistoryEmployeeId, DateBegin = s.th.HistoryBegin, DateEnd = s.th.HistoryEnd, TaskName = s.t.TaskName, TaskTime = s.th.HistoryDuration, MachineId = 0
            }).ToList());
        EmployeeTask = EmployeeTask.GroupJoin(LINQData.db.PM_ProjectMachineries, e => e.MachineId, m => m.MachineryId, (e, m) => new { e, m})
                                   .SelectMany(sm => sm.m.DefaultIfEmpty(), (sm, m) => new EmployeeTaskObject { 
                                        TaskId = sm.e.TaskId, DateBegin = sm.e.DateBegin, DateEnd = sm.e.DateEnd, TaskName = sm.e.TaskName, TaskTime = sm.e.TaskTime, MachineName = sm.e.MachineId == 0 ? "Không" : m.MachineryName
                                   }).ToList();
        EmployeeTask = EmployeeTask.Join(LINQData.db.PM_ProjectEmployees, e => e.TaskId, pe => pe.EmployeeID, (e, pe) => new {e, pe})
                                   .Select(s => new EmployeeTaskObject { 
                                       EmployeeCode = s.pe.EmployeeCode, TaskId = s.e.TaskId, DateBegin = s.e.DateBegin, DateEnd = s.e.DateEnd, TaskName = s.e.TaskName, TaskTime = s.e.TaskTime, MachineName = s.e.MachineName
                                   }).ToList();
        if (!Machine) EmployeeTask = EmployeeTask.Where(w => w.MachineName.ToUpper() == "KHÔNG").ToList();
        return EmployeeTask;
    }
    public static List<EmployeeObject> MinEmployeeListBySubListId(int SubProcessListID) {
        List<int> NotIn = LINQData.db.PM_ProjectEmployeeProcesses.Where(w => w.ProcessListID == SubProcessListID).Select(s => s.EmployeeID).ToList();
        return LINQData.db.PM_ProjectEmployees.Where(w => !NotIn.Contains(w.EmployeeID) && !w.EmployeeStatus.Equals("Đã Nghỉ việc")).Select(s => new EmployeeObject {
            EmployeeId = s.EmployeeID, EmployeeCode = s.EmployeeCode, EmployeeFullName = s.EmployeeFullName, EmployeeStatus = s.EmployeeStatus
        }).OrderBy(o => o.EmployeeFullName).ToList();
    }
    public static List<EmployeeObject> EmployeeProcessList(int SubProcessListID) {
        return LINQData.db.PM_ProjectEmployeeProcesses.Where(w => w.ProcessListID == SubProcessListID).OrderBy(o => o.EmployeeID)
            .Join(LINQData.db.PM_ProjectEmployees, pep => pep.EmployeeID, pe => pe.EmployeeID, (pep, pe) => new { pep, pe})
            .Select(s => new EmployeeObject {
                EmployeeProcessId = s.pep.EmpProID,
                EmployeeId = s.pep.EmployeeID,
                EmployeeCode = s.pe.EmployeeCode,
                EmployeeFullName = s.pe.EmployeeFullName,
                EmployeeGender = s.pe.EmployeeGender,
                EmployeeDescription = s.pe.EmployeeDescription
            }).OrderBy(o => o.EmployeeCode).ToList();
    }
    public static void EmployeeProcessCreated(int SubProcessListID, int EmployeeId) {
        LINQData.db.PM_ProjectEmployeeProcesses.InsertOnSubmit(new PM_ProjectEmployeeProcess() { 
            ProcessListID = SubProcessListID, EmployeeID = EmployeeId
        });
        LINQData.db.SubmitChanges();
    }
    public static void EmployeeProcessDeleted(int EmployeeProcessId) {
        PM_ProjectEmployeeProcess pepdel = LINQData.db.PM_ProjectEmployeeProcesses.FirstOrDefault(fod => fod.EmpProID == EmployeeProcessId);
        if (pepdel != null) {
            LINQData.db.PM_ProjectEmployeeProcesses.DeleteOnSubmit(pepdel);
            LINQData.db.SubmitChanges();
        }
    }
}