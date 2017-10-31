using CMS.CMSHelper;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;

public class TaskModels {
	public static List<TaskObject> TaskList() {        
        return LINQData.db.IV_tblTasks
                .GroupJoin(LINQData.db.CMS_Users, task => task.ModifiedByUserId, userc => userc.UserID, (task, userm) => new { task, userm })
                .SelectMany(sm => sm.userm.DefaultIfEmpty(), (sm, userm) => new TaskObject { 
                    TaskId = sm.task.TaskId, TaskName = sm.task.TaskName, TaskDescription = sm.task.TaskDescription, UserModified = userm.FullName
                }).OrderBy(o => o.TaskName).ToList();
    }
    public static List<TaskObject> MinTaskList() {        
        return LINQData.db.IV_tblTasks.Select(s => new TaskObject { 
            TaskId = s.TaskId, TaskName = s.TaskName
        }).OrderBy(o => o.TaskName).ToList();
    }
    public static void TaskCreated(string TaskName, string TaskDescription) {
        LINQData.db.IV_tblTasks.InsertOnSubmit(new IV_tblTask() { 
            TaskName = TaskName, TaskDescription = TaskDescription, CreatedWhen = DateTime.Now, CreatedByUserId = CMSContext.CurrentUser.UserID, ModifiedWhen = DateTime.Now, ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }
    public static void TaskUpdated(int TaskId, string TaskName, string TaskDescription) {
        IV_tblTask Task = LINQData.db.IV_tblTasks.FirstOrDefault(fod => fod.TaskId == TaskId);
        if (Task != null) {
            Task.TaskName = TaskName;
            Task.TaskDescription = TaskDescription;
            Task.ModifiedWhen = DateTime.Now;
            Task.ModifiedByUserId = CMSContext.CurrentUser.UserID;
            LINQData.db.SubmitChanges();
        }
    }
    public static void TaskDeleted(int TaskId) {
        IV_tblTask Task = LINQData.db.IV_tblTasks.FirstOrDefault(fod => fod.TaskId == TaskId);
        if (Task != null) {
            LINQData.db.IV_tblTasks.DeleteOnSubmit(Task);
            LINQData.db.SubmitChanges();
        }
    }
    public static int TaskHistoryCount() {
        return LINQData.db.IV_tblTaskHistories.Count();
    }
    public static List<TaskObject> TaskHistoryList() {        
        return LINQData.db.IV_tblTaskHistories.Select(s => new TaskObject {
            HistoryId = s.HistoryId, HistoryEmployeeId = s.HistoryEmployeeId, HistoryTaskId = s.HistoryTaskId, HistoryBegin = s.HistoryBegin, HistoryEnd = s.HistoryEnd, HistoryDuration = s.HistoryDuration, ModifiedWhen = s.ModifiedWhen
        }).OrderByDescending(o => o.ModifiedWhen).ToList();
    }
    public static void TaskHistoryCreated(int HistoryEmployeeId, int HistoryTaskId, DateTime HistoryBegin, DateTime HistoryEnd, decimal HistoryDuration) {
        LINQData.db.IV_tblTaskHistories.InsertOnSubmit(new IV_tblTaskHistory() { 
            HistoryEmployeeId = HistoryEmployeeId, HistoryTaskId = HistoryTaskId, HistoryBegin = HistoryBegin, HistoryEnd = HistoryEnd, HistoryDuration = HistoryDuration,
            CreatedWhen = DateTime.Now, CreatedByUserId = CMSContext.CurrentUser.UserID, ModifiedWhen = DateTime.Now, ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }
    public static void TaskHistoryUpdated(int HistoryId, int HistoryEmployeeId, int HistoryTaskId, DateTime HistoryBegin, DateTime HistoryEnd, decimal HistoryDuration) {
        IV_tblTaskHistory TaskHistory = LINQData.db.IV_tblTaskHistories.FirstOrDefault(fod => fod.HistoryId == HistoryId);
        if (TaskHistory != null) {
            TaskHistory.HistoryEmployeeId = HistoryEmployeeId;
            TaskHistory.HistoryTaskId = HistoryTaskId;
            TaskHistory.HistoryBegin = HistoryBegin;
            TaskHistory.HistoryEnd = HistoryEnd;
            TaskHistory.HistoryDuration = HistoryDuration;
            TaskHistory.ModifiedWhen = DateTime.Now;
            TaskHistory.ModifiedByUserId = CMSContext.CurrentUser.UserID;
            LINQData.db.SubmitChanges();
        }
    }
    public static void TaskHistoryDeleted(int HistoryId) {
        IV_tblTaskHistory TaskHistory = LINQData.db.IV_tblTaskHistories.FirstOrDefault(fod => fod.HistoryId == HistoryId);
        if (TaskHistory != null) {
            LINQData.db.IV_tblTaskHistories.DeleteOnSubmit(TaskHistory);
            LINQData.db.SubmitChanges();
        }
    }
}