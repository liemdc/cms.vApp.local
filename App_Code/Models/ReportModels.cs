﻿using Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ReportModels {
    public static IEnumerable ReportTotalList(DateTime RTDateBegin, DateTime RTDateEnd, string Filter) {
        IEnumerable<PM_ProjectTask> ProjectTask = null;
        if (Filter == "Transmit") ProjectTask = LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskTransmit >= RTDateBegin && w.ProjectTaskTransmit <= RTDateEnd);
        else ProjectTask = LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskDeadline >= RTDateBegin && w.ProjectTaskDeadline <= RTDateEnd);
        return ProjectTask.GroupJoin(LINQData.db.PM_ProjectCustomers, pt => pt.ProjectTaskCustomerId, pc => pc.CustomerId, (pt, pc) => new { pt, pc })
            .SelectMany(sm => sm.pc, (sm, pc) => new {sm.pt, pc})
            .GroupJoin(LINQData.db.PM_ProjectMolds, pt => pt.pt.ProjectTaskMoldsId, pm => pm.MoldsId, (pt, pm) => new { pt, pm })
            .SelectMany(sm => sm.pm, (sm, pm) => new { sm.pt, pm })
            .GroupJoin(LINQData.db.PM_ProjectTaskStatus, pt => pt.pt.pt.ProjectTaskStatusID, pts => pts.TaskStatusID, (pt, pts) => new { pt, pts })
            .SelectMany(sm => sm.pts, (sm, pts) => new {
                ProjectTaskID = sm.pt.pt.pt.ProjectTaskID,
                ProjectTaskMoldCode = sm.pt.pt.pt.ProjectTaskMoldCode,
                ProjectTaskOverlayNum = sm.pt.pt.pt.ProjectTaskOverlayNum,
                MoldsName = sm.pt.pm.MoldsName,
                ProjectTaskQuantities = sm.pt.pt.pt.ProjectTaskQuantities,
                ProjectTaskDiameterOut = sm.pt.pt.pt.ProjectTaskDiameterOut,
                ProjectTaskWeight = sm.pt.pt.pt.ProjectTaskWeight,
                CustomerName = sm.pt.pt.pc.CustomerName,
                ProjectTaskTransmit = sm.pt.pt.pt.ProjectTaskTransmit,
                ProjectTaskDeadline = sm.pt.pt.pt.ProjectTaskDeadline,
                ProjectTaskStatusID = sm.pt.pt.pt.ProjectTaskStatusID,
                TaskStatusDisplayName = pts.TaskStatusDisplayName,
                ProjectTaskDescription = sm.pt.pt.pt.ProjectTaskDescription
            }).ToList();
    }
    public static IEnumerable ReportTotalDetailList(int ProjectTaskID) {
        return LINQData.db.PM_ProjectProcesses.Where(w => w.ProcessProjectTaskID == ProjectTaskID)
            .Join(LINQData.db.PM_ProjectProcessLists.OrderBy(p => p.ProcessListOrder), pp => pp.ProcessListId, ppl => ppl.ProcessListId, (pp, ppl) => new { pp, ppl })
            .Select(s => new {
                ProcessListId = s.ppl.ProcessListId,
                ProcessListName = s.ppl.ProcessListName,
                ProcessExpectedTime = s.pp.ProcessExpectedTime,
                ProcessExpectedCompletion = s.pp.ProcessExpectedCompletion,
                ProcessFactTime = s.pp.ProcessFactTime,
                ProcessCompletion = s.pp.ProcessCompletion
            }).ToList();
    }
    public static IEnumerable ReportOrdersList(DateTime RTDateBegin, DateTime RTDateEnd, string Filter) {
        IEnumerable<PM_ProjectTask> ProjectTask = null;
        if (Filter == "Transmit") ProjectTask = LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskTransmit >= RTDateBegin && w.ProjectTaskTransmit <= RTDateEnd);
        else ProjectTask = LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskDeadline >= RTDateBegin && w.ProjectTaskDeadline <= RTDateEnd);
        return ProjectTask.GroupJoin(LINQData.db.PM_ProjectMolds, pt => pt.ProjectTaskMoldsId, pm => pm.MoldsId, (pt, pm) => new { pt, pm })
            .SelectMany(sm => sm.pm, (sm, pm) => new { sm.pt, pm })
            .GroupJoin(LINQData.db.PM_ProjectProcesses, pt => pt.pt.ProjectTaskID, pp => pp.ProcessProjectTaskID, (pt, pp) => new { pt, pp})
            .SelectMany(sm => sm.pp, (sm, pp) => new { sm.pt,pp})
            .GroupJoin(LINQData.db.PM_ProjectProcessLists, pp => pp.pp.ProcessListId, ppl => ppl.ProcessListId, (pp, ppl) => new { pp, ppl })
            .SelectMany(sm => sm.ppl, (sm, ppl) => new { sm.pp.pt, ppl})
            .GroupJoin(LINQData.db.PM_ProjectTaskStatus, pt => pt.pt.pt.ProjectTaskStatusID, pts => pts.TaskStatusID, (pt, pts) => new { pt, pts })
            .SelectMany(sm => sm.pts, (sm, pts) => new {
                ProjectTaskID = sm.pt.pt.pt.ProjectTaskID,
                ProjectTaskMoldCode = sm.pt.pt.pt.ProjectTaskMoldCode,
                ProjectTaskOverlayNum = sm.pt.pt.pt.ProjectTaskOverlayNum,
                MoldsName = sm.pt.pt.pm.MoldsName,
                ProjectTaskQuantities = sm.pt.pt.pt.ProjectTaskQuantities,
                ProjectTaskDiameterOut = sm.pt.pt.pt.ProjectTaskDiameterOut,
                ProjectTaskWeight = sm.pt.pt.pt.ProjectTaskWeight,
                ProjectTaskTransmitVtX = Convert.ToDateTime(sm.pt.pt.pt.ProjectTaskTransmit).ToString("dd/MM/yyyy HH:mm"),
                ProjectTaskDeadlineVtX = Convert.ToDateTime(sm.pt.pt.pt.ProjectTaskDeadline).ToString("dd/MM/yyyy HH:mm"),
                ProjectTaskStatusID = sm.pt.pt.pt.ProjectTaskStatusID,
                TaskStatusDisplayName = pts.TaskStatusDisplayName,
                ProcessListName = sm.pt.ppl.ProcessListName,
                ProcessListOrder = sm.pt.ppl.ProcessListOrder                               
            });
    }
}