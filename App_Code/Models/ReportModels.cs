using Models;
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
            .SelectMany(sm => sm.pc, (sm, pc) => new { sm.pt, pc })
            .GroupJoin(LINQData.db.PM_ProjectMolds, pt => pt.pt.ProjectTaskMoldsId, pm => pm.MoldsId, (pt, pm) => new { pt, pm })
            .SelectMany(sm => sm.pm, (sm, pm) => new { sm.pt, pm })
            .GroupJoin(LINQData.db.PM_ProjectTaskStatus, pt => pt.pt.pt.ProjectTaskStatusID, pts => pts.TaskStatusID, (pt, pts) => new { pt, pts })
            .SelectMany(sm => sm.pts, (sm, pts) => new { sm.pt, pts })
            .GroupJoin(LINQData.db.TimeCongDoans, pt => pt.pt.pt.pt.ProjectTaskID, tcd => tcd.ProjectTaskID, (pt, tcd) => new { pt, tcd })
            .SelectMany(sm => sm.tcd, (sm, tcd) => new {
                ProjectTaskID = sm.pt.pt.pt.pt.ProjectTaskID,
                ProjectTaskMoldCode = sm.pt.pt.pt.pt.ProjectTaskMoldCode,
                ProjectTaskOverlayNum = sm.pt.pt.pt.pt.ProjectTaskOverlayNum,
                MoldsName = sm.pt.pt.pm.MoldsName,
                ProjectTaskQuantities = sm.pt.pt.pt.pt.ProjectTaskQuantities,
                ProjectTaskDiameterOut = sm.pt.pt.pt.pt.ProjectTaskDiameterOut,
                ProjectTaskWeight = sm.pt.pt.pt.pt.ProjectTaskWeight,
                CustomerName = sm.pt.pt.pt.pc.CustomerName,
                ProjectTaskTransmit = sm.pt.pt.pt.pt.ProjectTaskTransmit,
                ProjectTaskDeadline = sm.pt.pt.pt.pt.ProjectTaskDeadline,
                ProjectTaskStatusID = sm.pt.pt.pt.pt.ProjectTaskStatusID,
                TaskStatusDisplayName = sm.pt.pts.TaskStatusDisplayName,
                ProjectTaskDescription = sm.pt.pt.pt.pt.ProjectTaskDescription,
                TienNCDK = tcd.TienNCDK,
                TienNCHT = tcd.TienNCHT,
                TienNCKQ = (tcd.TienNCHT <= tcd.TienNCDK) ? "Đạt" : !tcd.TienNCHT.HasValue ? "" : "Không đạt",
                EDMDK = tcd.EDMDK,
                EDMHT = tcd.EDMHT,
                EDMKQ = (tcd.EDMHT <= tcd.EDMDK) ? "Đạt" : !tcd.EDMHT.HasValue ? "" : "Không đạt",
                MaiBongVaLapRapDK = tcd.MaiBongVaLapRapDK,
                MaiBongVaLapRapHT = tcd.MaiBongVaLapRapHT,
                MaiBongVaLapRapKQ = (tcd.MaiBongVaLapRapHT <= tcd.MaiBongVaLapRapDK) ? "Đạt" : !tcd.MaiBongVaLapRapHT.HasValue ? "" : "Không đạt",
                MaiPhangKhuonDapDK = tcd.MaiPhangKhuonDapDK,
                MaiPhangKhuonDapHT = tcd.MaiPhangKhuonDapHT,
                MaiPhangKhuonDapKQ = (tcd.MaiPhangKhuonDapHT <= tcd.MaiPhangKhuonDapDK) ? "Đạt" : !tcd.MaiPhangKhuonDapHT.HasValue ? "" : "Không đạt",
                NhietLuyenDK = tcd.NhietLuyenDK,
                NhietLuyenHT = tcd.NhietLuyenHT,
                NhietLuyenKQ = (tcd.NhietLuyenHT <= tcd.NhietLuyenDK) ? "Đạt" : !tcd.NhietLuyenHT.HasValue ? "" : "Không đạt",
                PhayMCDK = tcd.PhayMCDK,
                PhayMCHT = tcd.PhayMCHT,
                PhayMCKQ = (tcd.PhayMCHT <= tcd.PhayMCDK) ? "Đạt" : !tcd.PhayMCHT.HasValue ? "" : "Không đạt",
                PhayTayDH = tcd.PhayTayDK,
                PhayTayHT = tcd.PhayTayHT,
                PhayTayKQ = (tcd.PhayTayHT <= tcd.PhayTayDK) ? "Đạt" : !tcd.PhayTayHT.HasValue ? "" : "Không đạt",
                TienTinhNCDK = tcd.TienTinhNCDK,
                TienTinhNCHT = tcd.TienTinhNCHT,
                TienTinhNCKQ = (tcd.TienTinhNCHT <= tcd.TienTinhNCDK) ? "Đạt" : !tcd.TienTinhNCHT.HasValue ? "" : "Không đạt",
                WEDMDK = tcd.WEDMDK,
                WEDMHT = tcd.WEDMHT,
                WEDMKQ = (tcd.WEDMHT <= tcd.WEDMDK) ? "Đạt" : !tcd.WEDMHT.HasValue ? "" : "Không đạt",
                BoPhanQADK = tcd.BoPhanQADK,
                BoPhanQAHT = tcd.BoPhanQAHT,
                BoPhanQAKQ = (tcd.BoPhanQAHT <= tcd.BoPhanQADK) ? "Đạt" : !tcd.BoPhanQAHT.HasValue ? "" : "Không đạt",
                ProjectTaskDuKienXuatHang = sm.pt.pt.pt.pt.DX_XuatHang_DuKien,
                ProjectTaskThucTeXuatHang = sm.pt.pt.pt.pt.DX_XuatHang_ThucTe,
                ProjectTaskXuatHangKQ = (sm.pt.pt.pt.pt.DX_XuatHang_ThucTe <= sm.pt.pt.pt.pt.DX_XuatHang_DuKien) ? "Đạt" : !sm.pt.pt.pt.pt.DX_XuatHang_ThucTe.HasValue ? "" : "Không đạt"
            }).ToList();
    }
    public static IEnumerable DuKienHoanThanh(DateTime RTDateBegin, DateTime RTDateEnd, string Filter) {
        IEnumerable<DX_View_DonHang_Joined> DonHang_Joined = null;
        if (Filter == "Transmit") DonHang_Joined = LINQData.db.DX_View_DonHang_Joineds.Where(w => w.ProjectTaskTransmit >= RTDateBegin && w.ProjectTaskTransmit <= RTDateEnd);
        else DonHang_Joined = LINQData.db.DX_View_DonHang_Joineds.Where(w => w.ProjectTaskDeadline >= RTDateBegin && w.ProjectTaskDeadline <= RTDateEnd);
        return DonHang_Joined.Select(s => new {
                ProjectTaskID = (int)s.ProcessProjectTaskID,
                ProjectTaskCustomerId = s.ProjectTaskCustomerId,
                ProjectTaskDeadline = s.ProjectTaskDeadline,
                ProjectTaskDescription = s.ProjectTaskDescription,
                ProjectTaskDisplayName = s.ProjectTaskDisplayName,
                ProjectTaskMaterialsCode = s.ProjectTaskMaterialsCode,
                ProjectTaskMoldCode = s.ProjectTaskMoldCode,
                ProjectTaskMoldsId = s.ProjectTaskMoldsId,
                ProjectTaskOverlayNum = s.ProjectTaskOverlayNum,
                ProjectTaskQuantities = s.ProjectTaskQuantities,
                ProjectTaskTransmit = s.ProjectTaskTransmit,
                DX_DuKienHT_EDM = s.DK082,
                DX_DuKienHT_Mai = s.DK108,
                DX_DuKienHT_MC = s.DK074,
                DX_DuKienHT_NC = s.DK085,
                DX_DuKienHT_Nhiet = s.DK091,
                DX_DuKienHT_PhayTay = s.DK076,
                DX_DuKienHT_QA = s.DK077,
                DX_DuKienHT_WEDM = s.DK083,
                DX_DuKienHT_LapRap = s.DK100,
            }).OrderByDescending(o => o.ProjectTaskID);
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