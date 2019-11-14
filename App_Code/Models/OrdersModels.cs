using CMS.CMSHelper;
using CMS.ProjectManagement;
using Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Transactions;
using System.Web;

public class OrdersModels
{
    public static IEnumerable<OrdersObject> OrdersList() {
        IEnumerable<DX_View_DonHang_Joined> DonHang_Joined = null;
        DonHang_Joined = LINQData.db.DX_View_DonHang_Joineds.Where(w => w.ProjectTaskStatusID != 7);
        return DonHang_Joined.Select(s => new OrdersObject {
                ProjectTaskID               = (int)s.ProcessProjectTaskID,
                ProjectTaskCustomerId       = s.ProjectTaskCustomerId,
                ProjectTaskDeadline         = s.ProjectTaskDeadline,
                ProjectTaskDescription      = s.ProjectTaskDescription,
                ProjectTaskDiameterOut      = s.ProjectTaskDiameterOut,
                ProjectTaskDisplayName      = s.ProjectTaskDisplayName,
                ProjectTaskHardness         = s.ProjectTaskHardness,
                ProjectTaskHoleNum          = s.ProjectTaskHoleNum,
                ProjectTaskHorikomi         = s.ProjectTaskHorikomi,
                ProjectTaskMaterialsCode    = s.ProjectTaskMaterialsCode,
                ProjectTaskMaterialsRequire = s.ProjectTaskMaterialsRequire,
                ProjectTaskMoldCode         = s.ProjectTaskMoldCode,
                ProjectTaskMoldsId          = s.ProjectTaskMoldsId,
                ProjectTaskOverlayNum       = s.ProjectTaskOverlayNum,
                ProjectTaskPriorityID       = s.ProjectTaskPriorityID,
                ProjectTaskQuantities       = s.ProjectTaskQuantities,
                ProjectTaskStatusID         = s.ProjectTaskStatusID,
                ProjectTaskThickness        = s.ProjectTaskThickness,
                ProjectTaskThicknessTotal   = s.ProjectTaskThicknessTotal,
                ProjectTaskTransmit         = s.ProjectTaskTransmit,
                DX_MaDonHang                = s.DX_MaDonHang,
                DX_XuatHang_DuKien = s.DX_XuatHang_DuKien,
                DX_XuatHang_ThucTe = s.DX_XuatHang_ThucTe,
                DX_DuKienGC_MaiSNK = s.GC081,
                DX_DuKienHT_MaiSNK = s.DK081,
                DX_ThucTeHT_MaiSNK = s.TT081,
                DX_DuKienGC_EDM = s.GC082,
                DX_DuKienHT_EDM = s.DK082,
                DX_ThucTeHT_EDM = s.TT082,
                DX_DuKienGC_Mai = s.GC108,
                DX_DuKienHT_Mai = s.DK108,
                DX_ThucTeHT_Mai = s.TT108,
                DX_DuKienGC_MC = s.GC074,
                DX_DuKienHT_MC = s.DK074,
                DX_ThucTeHT_MC = s.TT074,
                DX_DuKienGC_NC = s.GC085,
                DX_DuKienHT_NC = s.DK085,
                DX_ThucTeHT_NC = s.TT085,
                DX_DuKienGC_Nhiet = s.GC091,
                DX_DuKienHT_Nhiet = s.DK091,
                DX_ThucTeHT_Nhiet = s.TT091,
                DX_DuKienGC_PhayTay = s.GC076,
                DX_DuKienHT_PhayTay = s.DK076,
                DX_ThucTeHT_PhayTay = s.TT076,
                DX_DuKienGC_QA = s.GC077,
                DX_DuKienHT_QA = s.DK077,
                DX_ThucTeHT_QA = s.TT077,
                DX_DuKienGC_WEDM = s.GC083,
                DX_DuKienHT_WEDM = s.DK083,
                DX_ThucTeHT_WEDM = s.TT083,
                DX_DuKienGC_LapRap = s.GC100,
                DX_DuKienHT_LapRap = s.DK100,
                DX_ThucTeHT_LapRap = s.TT100                
            }).OrderBy(o => o.ProjectTaskMoldCode);
    }
    public static IEnumerable<OrdersObject> OrdersListNd(string TaskStatus, string TaskPriority, DateTime DateBeginB, DateTime DateEndB) {
        int[] statusIds = Array.ConvertAll(TaskStatus.Split(';'), s => int.Parse(s));
        int[] priorityIds = Array.ConvertAll(TaskPriority.Split(';'), s => int.Parse(s));
        IEnumerable<DX_View_DonHang_Joined> DonHang_Joined = null;
        DonHang_Joined = LINQData.db.DX_View_DonHang_Joineds.Where(w => w.ProjectTaskStatusID != 7);
        return DonHang_Joined.Where(w => statusIds.Contains(w.ProjectTaskStatusID) && priorityIds.Contains(w.ProjectTaskPriorityID) && !w.DX_XuatHang_DuKien.HasValue ? w.DX_XuatHang_DuKien == null : w.DX_XuatHang_DuKien >= DateBeginB && !w.DX_XuatHang_DuKien.HasValue ? w.DX_XuatHang_DuKien == null : w.DX_XuatHang_DuKien <= DateEndB)
            .Select(s => new OrdersObject {
                ProjectTaskID = (int)s.ProcessProjectTaskID,
                ProjectTaskCustomerId = s.ProjectTaskCustomerId,
                ProjectTaskDeadline = s.ProjectTaskDeadline,
                ProjectTaskDescription = s.ProjectTaskDescription,
                ProjectTaskDiameterOut = s.ProjectTaskDiameterOut,
                ProjectTaskDisplayName = s.ProjectTaskDisplayName,
                ProjectTaskHardness = s.ProjectTaskHardness,
                ProjectTaskHoleNum = s.ProjectTaskHoleNum,
                ProjectTaskHorikomi = s.ProjectTaskHorikomi,
                ProjectTaskMaterialsCode = s.ProjectTaskMaterialsCode,
                ProjectTaskMaterialsRequire = s.ProjectTaskMaterialsRequire,
                ProjectTaskMoldCode = s.ProjectTaskMoldCode,
                ProjectTaskMoldsId = s.ProjectTaskMoldsId,
                ProjectTaskOverlayNum = s.ProjectTaskOverlayNum,
                ProjectTaskPriorityID = s.ProjectTaskPriorityID,
                ProjectTaskQuantities = s.ProjectTaskQuantities,
                ProjectTaskStatusID = s.ProjectTaskStatusID,
                ProjectTaskThickness = s.ProjectTaskThickness,
                ProjectTaskThicknessTotal = s.ProjectTaskThicknessTotal,
                ProjectTaskTransmit = s.ProjectTaskTransmit,
                DX_MaDonHang = s.DX_MaDonHang,
                DX_XuatHang_DuKien = s.DX_XuatHang_DuKien,
                DX_XuatHang_ThucTe = s.DX_XuatHang_ThucTe,
                DX_DuKienGC_MaiSNK = s.GC081,
                DX_DuKienHT_MaiSNK = s.DK081,
                DX_ThucTeHT_MaiSNK = s.TT081,
                DX_DuKienGC_EDM = s.GC082,
                DX_DuKienHT_EDM = s.DK082,
                DX_ThucTeHT_EDM = s.TT082,
                DX_DuKienGC_Mai = s.GC108,
                DX_DuKienHT_Mai = s.DK108,
                DX_ThucTeHT_Mai = s.TT108,
                DX_DuKienGC_MC = s.GC074,
                DX_DuKienHT_MC = s.DK074,
                DX_ThucTeHT_MC = s.TT074,
                DX_DuKienGC_NC = s.GC085,
                DX_DuKienHT_NC = s.DK085,
                DX_ThucTeHT_NC = s.TT085,
                DX_DuKienGC_Nhiet = s.GC091,
                DX_DuKienHT_Nhiet = s.DK091,
                DX_ThucTeHT_Nhiet = s.TT091,
                DX_DuKienGC_PhayTay = s.GC076,
                DX_DuKienHT_PhayTay = s.DK076,
                DX_ThucTeHT_PhayTay = s.TT076,
                DX_DuKienGC_QA = s.GC077,
                DX_DuKienHT_QA = s.DK077,
                DX_ThucTeHT_QA = s.TT077,
                DX_DuKienGC_WEDM = s.GC083,
                DX_DuKienHT_WEDM = s.DK083,
                DX_ThucTeHT_WEDM = s.TT083,
                DX_DuKienGC_LapRap = s.GC100,
                DX_DuKienHT_LapRap = s.DK100,
                DX_ThucTeHT_LapRap = s.TT100
            }).OrderByDescending(o => o.ProjectTaskTransmit).ThenBy(o => o.ProjectTaskPriorityID);
    }
    public static void OrdersCreated(string ProjectTaskMoldCode, string ProjectTaskOverlayNum, string ProjectTaskHoleNum, decimal ProjectTaskDiameterOut, string ProjectTaskMaterialsRequire, string ProjectTaskMaterialsCode, int ProjectTaskMoldsId,
                                     int ProjectTaskThickness, string ProjectTaskThicknessTotal, int ProjectTaskQuantities, string ProjectTaskHorikomi, string ProjectTaskHardness, int ProjectTaskCustomerId,
                                     DateTime? DX_XuatHang_DuKien,
                                     DateTime? DX_DuKienHT_EDM,
                                     DateTime? DX_DuKienHT_Mai,
                                     DateTime? DX_DuKienHT_MaiSNK,
                                     DateTime? DX_DuKienHT_MC,
                                     DateTime? DX_DuKienHT_NC,
                                     DateTime? DX_DuKienHT_Nhiet,
                                     DateTime? DX_DuKienHT_PhayTay,
                                     DateTime? DX_DuKienHT_QA,
                                     DateTime? DX_DuKienHT_WEDM,
                                     DateTime? DX_DuKienHT_LapRap,
                                     DateTime ProjectTaskDeadline, DateTime ProjectTaskTransmit, string ProjectTaskDescription)
    {
        using (TransactionScope transactionScope = new TransactionScope())
        {
            try
            {
                ProjectTaskInfo newTask = new ProjectTaskInfo();
                newTask.ProjectTaskDisplayName = "NewOrders";
                newTask.ProjectTaskCreatedByID = CMSContext.CurrentUser.UserID;
                newTask.ProjectTaskOwnerID = CMSContext.CurrentUser.UserID;
                newTask.ProjectTaskAssignedToUserID = CMSContext.CurrentUser.UserID;
                newTask.ProjectTaskDeadline = ProjectTaskDeadline;
                newTask.ProjectTaskDescription = ProjectTaskDescription;
                newTask.ProjectTaskStatusID = 2;
                newTask.ProjectTaskPriorityID = 3;
                ProjectTaskInfoProvider.SetProjectTaskInfo(newTask);

                PM_ProjectTask pt = LINQData.db.PM_ProjectTasks.FirstOrDefault(x => x.ProjectTaskID == newTask.ProjectTaskID);
                pt.ProjectTaskMoldCode = ProjectTaskMoldCode;
                pt.ProjectTaskOverlayNum = ProjectTaskOverlayNum;
                pt.ProjectTaskHoleNum = ProjectTaskHoleNum;
                pt.ProjectTaskDiameterOut = ProjectTaskDiameterOut;
                pt.ProjectTaskMaterialsRequire = ProjectTaskMaterialsRequire;
                pt.ProjectTaskMaterialsCode = ProjectTaskMaterialsCode;
                pt.ProjectTaskMoldsId = ProjectTaskMoldsId;
                pt.ProjectTaskThickness = ProjectTaskThickness;
                pt.ProjectTaskThicknessTotal = ProjectTaskThicknessTotal;
                pt.ProjectTaskQuantities = ProjectTaskQuantities;
                pt.ProjectTaskHorikomi = ProjectTaskHorikomi;
                pt.ProjectTaskHardness = ProjectTaskHardness;
                pt.ProjectTaskCustomerId = ProjectTaskCustomerId;
                pt.ProjectTaskTransmit = ProjectTaskTransmit;
                pt.DX_MaDonHang         = SystemModels.Fn_Get_MaDinhDanh(null, "DH", 6, "Mã đơn hàng");
                pt.DX_XuatHang_DuKien   = DX_XuatHang_DuKien.HasValue ? DX_XuatHang_DuKien : null;

                Nullable<decimal> factor = LINQData.db.PM_ProjectMolds.Where(w => w.MoldsId == ProjectTaskMoldsId).Select(s => s.MoldsFactor).FirstOrDefault();
                if (factor != null)
                {
                    pt.ProjectTaskMoldsFactor = factor;
                    pt.ProjectTaskWeight = Convert.ToDecimal(Convert.ToDouble(ProjectTaskDiameterOut) * Convert.ToDouble(ProjectTaskDiameterOut) * 0.785 * 7.8 * Convert.ToDouble(ProjectTaskThickness) * Convert.ToDouble(factor)) / 1000000;
                }

                List<MoldsProcessObject> ListMoldsProcess = LINQData.db.IV_tblMoldsProcesses.Where(w => w.MoldsId == ProjectTaskMoldsId)
                                                                    .GroupJoin(LINQData.db.PM_ProjectProcessLists, mp => mp.ProcessListId, pl => pl.ProcessListId, (mp, pl) => new { mp, pl })
                                                                    .SelectMany(sm => sm.pl.DefaultIfEmpty(), (sm, pl) => new MoldsProcessObject {
                                                                        MoldsProcessId = sm.mp.MoldsProcessId,
                                                                        MoldsId = sm.mp.MoldsId,
                                                                        ProcessListId = sm.mp.ProcessListId,
                                                                        ProcessListName = pl.ProcessListName,
                                                                        ProcessListGroup = pl.ProcessListGroup,
                                                                        ItemPos = pl.ProcessListOrder
                                                                    }).OrderByDescending(o => o.ItemPos).ToList();
                int ProcessTo = 0;
                // -----   
                int[] ids = new int[] { 74, 76, 77, 81, 82, 83, 85, 91, 100, 108 };
                DateTime?[] dataDK = new DateTime?[] { DX_DuKienHT_MC, DX_DuKienHT_PhayTay, DX_DuKienHT_QA, DX_DuKienHT_MaiSNK, DX_DuKienHT_EDM, DX_DuKienHT_WEDM, DX_DuKienHT_NC, DX_DuKienHT_Nhiet, DX_DuKienHT_LapRap, DX_DuKienHT_Mai };
                foreach (var MoldsProcess in ListMoldsProcess) {
                    int dataQA = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListGroup.Equals("dataQA")).ProcessListId;
                    Nullable<Boolean> DXNhanDuKien = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListId == MoldsProcess.ProcessListId).DXNhanDuKien;
                    Nullable<DateTime> DXNgayNhanDuKien = (DXNhanDuKien == true ? ProjectTaskTransmit.AddHours(1) : (DateTime?)null);
                    Nullable<DateTime> HoanThanhDuKien = (DateTime?)null;
                    for (int i = 0; i < ids.Length; i++) {
                        if (ids[i] == MoldsProcess.ProcessListId)
                            HoanThanhDuKien = dataDK[i] != null ? dataDK[i] : (DateTime?)null;
                    }
                    LINQData.db.PM_ProjectProcesses.InsertOnSubmit(new PM_ProjectProcess() {
                        ProcessProjectTaskID = newTask.ProjectTaskID,
                        ProcessListId = MoldsProcess.ProcessListId,
                        ProcessRequired = true,
                        ProcessGangerBrowse = false,
                        ProcessSMGangerBrowse = false,
                        DXChuyenQuaCongDoan = ProcessTo,
                        DX_HoanThanhDuKien = HoanThanhDuKien,
                        CreatedWhen = DateTime.Now,
                        CreatedByUserId = CMSContext.CurrentUser.UserID,
                        ModifiedWhen = DateTime.Now,
                        ModifiedByUserId = CMSContext.CurrentUser.UserID
                    });
                    ProcessTo = MoldsProcess.ProcessListId;
                }

                LINQData.db.SubmitChanges();
                transactionScope.Complete();
            }
            catch { }
        }
    }
    public static void OrdersUpdated(int ProjectTaskID, string ProjectTaskMoldCode, string ProjectTaskOverlayNum, string ProjectTaskHoleNum, decimal ProjectTaskDiameterOut, string ProjectTaskMaterialsRequire, string ProjectTaskMaterialsCode, int ProjectTaskMoldsId,
                                     int ProjectTaskThickness, string ProjectTaskThicknessTotal, int ProjectTaskQuantities, string ProjectTaskHorikomi, string ProjectTaskHardness, int ProjectTaskCustomerId,
                                     DateTime? DX_XuatHang_DuKien,
                                     DateTime? DX_DuKienHT_EDM, DateTime? DX_DuKienHT_Mai,
                                     DateTime? DX_DuKienHT_MaiSNK, DateTime? DX_DuKienHT_MC,
                                     DateTime? DX_DuKienHT_NC, DateTime? DX_DuKienHT_Nhiet,
                                     DateTime? DX_DuKienHT_PhayTay, DateTime? DX_DuKienHT_QA,
                                     DateTime? DX_DuKienHT_WEDM, DateTime? DX_DuKienHT_LapRap, 
                                     DateTime ProjectTaskDeadline, DateTime ProjectTaskTransmit, string ProjectTaskDescription) {        
        using (TransactionScope transactionScope = new TransactionScope()){
            try{
                bool UpdateProcess = false;
                PM_ProjectTask pt = LINQData.db.PM_ProjectTasks.FirstOrDefault(x => x.ProjectTaskID == ProjectTaskID);
                
                if (pt != null){
                    if (pt.ProjectTaskMoldsId != ProjectTaskMoldsId)
                        UpdateProcess = true;
                    pt.ProjectTaskMoldCode = ProjectTaskMoldCode;
                    pt.ProjectTaskOverlayNum = ProjectTaskOverlayNum;
                    pt.ProjectTaskHoleNum = ProjectTaskHoleNum;
                    pt.ProjectTaskDiameterOut = ProjectTaskDiameterOut;
                    pt.ProjectTaskMaterialsRequire = ProjectTaskMaterialsRequire;
                    pt.ProjectTaskMaterialsCode = ProjectTaskMaterialsCode;
                    pt.ProjectTaskMoldsId = ProjectTaskMoldsId;
                    pt.ProjectTaskThickness = ProjectTaskThickness;
                    pt.ProjectTaskThicknessTotal = ProjectTaskThicknessTotal;
                    pt.ProjectTaskQuantities = ProjectTaskQuantities;
                    pt.ProjectTaskHorikomi = ProjectTaskHorikomi;
                    pt.ProjectTaskHardness = ProjectTaskHardness;
                    pt.ProjectTaskCustomerId = ProjectTaskCustomerId;
                    pt.ProjectTaskTransmit = ProjectTaskTransmit;
                    pt.ProjectTaskDeadline = ProjectTaskDeadline;
                    pt.ProjectTaskDescription = ProjectTaskDescription;
                    pt.DX_XuatHang_TruocDuKien = DX_XuatHang_DuKien.Value < pt.DX_XuatHang_DuKien.Value ? true : false;
                    pt.DX_XuatHang_DuKien = DX_XuatHang_DuKien.HasValue ? DX_XuatHang_DuKien : null;
                    
                    if (UpdateProcess)
                    {
                        Nullable<decimal> factor = LINQData.db.PM_ProjectMolds.Where(w => w.MoldsId == ProjectTaskMoldsId).Select(s => s.MoldsFactor).FirstOrDefault();
                        if (factor != null)
                        {
                            pt.ProjectTaskMoldsFactor = factor;
                            pt.ProjectTaskWeight = Convert.ToDecimal(Convert.ToDouble(ProjectTaskDiameterOut) * Convert.ToDouble(ProjectTaskDiameterOut) * 0.785 * 7.8 * Convert.ToDouble(ProjectTaskThickness) * Convert.ToDouble(factor)) / 1000000;
                        }

                        LINQData.db.PM_ProjectProcesses.DeleteAllOnSubmit(LINQData.db.PM_ProjectProcesses.Where(w => w.ProcessProjectTaskID == ProjectTaskID && !LINQData.db.IV_tblMoldsProcesses.Where(w1 => w1.MoldsId == ProjectTaskMoldsId).Select(s => s.ProcessListId).ToArray().Contains(w.ProcessListId)));

                        List<IV_tblMoldsProcess> ListMoldsProcess = LINQData.db.IV_tblMoldsProcesses.Where(w => w.MoldsId == ProjectTaskMoldsId).ToList();
                        foreach (var MoldsProcess in ListMoldsProcess)
                        {
                            if (LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessProjectTaskID == ProjectTaskID && fod.ProcessListId == MoldsProcess.ProcessListId) == null)
                                LINQData.db.PM_ProjectProcesses.InsertOnSubmit(new PM_ProjectProcess()
                                {
                                    ProcessProjectTaskID = ProjectTaskID,
                                    ProcessListId = MoldsProcess.ProcessListId,
                                    ProcessRequired = true,
                                    ProcessGangerBrowse = false,
                                    ProcessSMGangerBrowse = false,
                                    CreatedWhen = DateTime.Now,
                                    CreatedByUserId = CMSContext.CurrentUser.UserID,
                                    ModifiedWhen = DateTime.Now,
                                    ModifiedByUserId = CMSContext.CurrentUser.UserID
                                });
                        }
                    }

                    // -----  
                    int[] ids = new int[] { 74, 76, 77, 81, 82, 83, 85, 91, 100, 108 };
                    DateTime?[] dataDK = new DateTime?[] { DX_DuKienHT_MC, DX_DuKienHT_PhayTay, DX_DuKienHT_QA, DX_DuKienHT_MaiSNK, DX_DuKienHT_EDM, DX_DuKienHT_WEDM, DX_DuKienHT_NC, DX_DuKienHT_Nhiet, DX_DuKienHT_LapRap, DX_DuKienHT_Mai };
                    for (int i = 0; i < ids.Length; i++) {
                        PM_ProjectProcess pp = LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessProjectTaskID == ProjectTaskID && fod.ProcessListId == ids[i]);
                        if (pp != null)
                            pp.DX_HoanThanhDuKien = dataDK[i] != null ? dataDK[i] : (DateTime?)null;
                    }

                }
                LINQData.db.SubmitChanges();
                transactionScope.Complete();
            } catch (Exception ex) {
                DataUtils.WriteLog("Error: Update đơn hàng!");
                DataUtils.WriteLog(ex.ToString());
            }
        }
    }
    public static void OrdersUpdatedNd(int ProjectTaskID, int ProjectTaskStatusID, int ProjectTaskPriorityID, DateTime ProjectTaskDeadline, DateTime ProjectTaskTransmit, string ProjectTaskDescription,
        DateTime? DX_XuatHang_ThucTe,
        DateTime? DX_XuatHang_DuKien,
        DateTime? DX_DuKienHT_EDM,
        DateTime? DX_DuKienHT_Mai,
        DateTime? DX_DuKienHT_MC,
        DateTime? DX_DuKienHT_NC,
        DateTime? DX_DuKienHT_Nhiet,
        DateTime? DX_DuKienHT_PhayTay,
        DateTime? DX_DuKienHT_QA,
        DateTime? DX_DuKienHT_WEDM)
    {
        PM_ProjectTask pt = LINQData.db.PM_ProjectTasks.FirstOrDefault(x => x.ProjectTaskID == ProjectTaskID);
        if (pt != null)
        {
            pt.ProjectTaskStatusID = ProjectTaskStatusID;
            pt.ProjectTaskPriorityID = ProjectTaskPriorityID;
            pt.ProjectTaskDeadline = ProjectTaskDeadline;
            pt.ProjectTaskTransmit = ProjectTaskTransmit;
            pt.ProjectTaskDescription = ProjectTaskDescription;
            pt.DX_XuatHang_ThucTe = DX_XuatHang_ThucTe.HasValue ? DX_XuatHang_ThucTe : null;
            pt.DX_XuatHang_DuKien = DX_XuatHang_DuKien.HasValue ? DX_XuatHang_DuKien : null;
            //pt.DX_DuKienHT_EDM = DX_DuKienHT_EDM.HasValue ? DX_DuKienHT_EDM : null;
            //pt.DX_DuKienHT_Mai = DX_DuKienHT_Mai.HasValue ? DX_DuKienHT_Mai : null;
            //pt.DX_DuKienHT_MC = DX_DuKienHT_MC.HasValue ? DX_DuKienHT_MC : null;
            //pt.DX_DuKienHT_NC = DX_DuKienHT_NC.HasValue ? DX_DuKienHT_NC : null;
            //pt.DX_DuKienHT_Nhiet = DX_DuKienHT_Nhiet.HasValue ? DX_DuKienHT_Nhiet : null;
            //pt.DX_DuKienHT_PhayTay = DX_DuKienHT_PhayTay.HasValue ? DX_DuKienHT_PhayTay : null;
            //pt.DX_DuKienHT_QA = DX_DuKienHT_QA.HasValue ? DX_DuKienHT_QA : null;
            //pt.DX_DuKienHT_WEDM = DX_DuKienHT_WEDM.HasValue ? DX_DuKienHT_WEDM : null;
            LINQData.db.SubmitChanges();
        }
    }
    public static void OrdersDeleted(int ProjectTaskID)
    {
        ProjectTaskInfoProvider.DeleteProjectTaskInfo(ProjectTaskID);
    }
    public static IEnumerable MaterialInOrders()
    {
        return LINQData.db.PM_ProjectTasks.Select(s => new { ProjectTaskMaterialsCode = s.ProjectTaskMaterialsCode }).Distinct();
    }
    public static IEnumerable HardnessInOrders()
    {
        return LINQData.db.PM_ProjectTasks.Select(s => new { ProjectTaskHardness = s.ProjectTaskHardness }).Distinct();
    }
    public static List<ProjectProcessObject> ProjectProcessListByProjectTaskID(int ProjectTaskID) {
        return LINQData.db.PM_ProjectProcesses.Where(w => w.ProcessProjectTaskID == ProjectTaskID)
                .GroupJoin(LINQData.db.PM_ProjectProcessLists, mp => mp.ProcessListId, pl => pl.ProcessListId, (mp, pl) => new { mp, pl })
                .SelectMany(sm => sm.pl.DefaultIfEmpty(), (sm, pl) => new { sm, pl })                
                .GroupJoin(LINQData.db.CMS_Users, mp1 => mp1.sm.mp.ModifiedByUserId, userc => userc.UserID, (mp1, userm) => new { mp1, userm })
                .SelectMany(sm1 => sm1.userm.DefaultIfEmpty(), (sm1, userm) => new ProjectProcessObject {
                    ProcessId = sm1.mp1.sm.mp.ProcessId,
                    ProcessListId = sm1.mp1.sm.mp.ProcessListId,
                    ProcessListIds = string.Format("PL-{0}", sm1.mp1.sm.mp.ProcessListId),
                    ProcessListName = sm1.mp1.pl.ProcessListName,
                    ProcessListgroup = sm1.mp1.pl.ProcessListGroup,
                    ItemPos = sm1.mp1.sm.mp.ProcessId,
                    //ItemPos = sm1.mp1.pl.ProcessListOrder,
                    DXChuyenCongDoan = string.IsNullOrEmpty(LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fd => fd.ProcessListId == sm1.mp1.sm.mp.DXChuyenQuaCongDoan).ProcessListName) ? "Không xác định" : LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fd => fd.ProcessListId == sm1.mp1.sm.mp.DXChuyenQuaCongDoan).ProcessListName,
                    ProcessExpectedTime = sm1.mp1.sm.mp.ProcessExpectedTime,
                    ProcessFactTime = sm1.mp1.sm.mp.ProcessFactTime,
                    ProcessNotes = sm1.mp1.sm.mp.ProcessNotes,
                    UserModified = userm.FullName,
                    DateModified = sm1.mp1.sm.mp.ModifiedWhen,
                    ProcessExpectedCompletion = sm1.mp1.sm.mp.ProcessExpectedCompletion,
                    DXNgayNhanThucTe = sm1.mp1.sm.mp.DXNgayNhanThucTe,
                    DXNgayBatDauDuKien = sm1.mp1.sm.mp.DXNgayBatDauDuKien,
                    DXNgayKetThucDuKien = Convert.ToDateTime(sm1.mp1.sm.mp.DXNgayBatDauDuKien).AddHours(Convert.ToDouble(sm1.mp1.sm.mp.ProcessExpectedTime)).AddHours(Convert.ToDouble(sm1.mp1.sm.mp.DXThoiGianDieuChinh)),
                    DXThoiGianDieuChinh = sm1.mp1.sm.mp.DXThoiGianDieuChinh,
                    DXMaSanPhamUuTienGiaCong = sm1.mp1.sm.mp.DXMaSanPhamUuTienGiaCong,
                    DXTrangThai = sm1.mp1.sm.mp.ProcessGangerBrowse == true ? "Hoàn thành" : "Chưa hoàn thành",
                    DXNgayBatDauThucTe = sm1.mp1.sm.mp.DXGioBatDauThucTe,
                    DXNgayKetThucThucTe = sm1.mp1.sm.mp.ProcessCompletion
                }).OrderByDescending(o => o.ItemPos).ToList();
    }
    public static void ProjectProcessCreated(int ProjectTaskID, int ProcessListId)
    {
        LINQData.db.PM_ProjectProcesses.InsertOnSubmit(new PM_ProjectProcess()
        {
            ProcessProjectTaskID = ProjectTaskID,
            ProcessListId = ProcessListId,
            ProcessRequired = true,
            ProcessGangerBrowse = false,
            ProcessSMGangerBrowse = false,
            CreatedWhen = DateTime.Now,
            CreatedByUserId = CMSContext.CurrentUser.UserID,
            ModifiedWhen = DateTime.Now,
            ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }
    public static void ProjectProcessDeleted(int ProcessId)
    {
        PM_ProjectProcess ProjectProcess = LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessId == ProcessId);
        if (ProjectProcess != null)
        {
            LINQData.db.PM_ProjectProcesses.DeleteOnSubmit(ProjectProcess);
            LINQData.db.SubmitChanges();
        }
    }
    public static IEnumerable TaskStatusList()
    {
        return LINQData.db.PM_ProjectTaskStatus.Where(w => w.TaskStatusEnabled == true).Select(s => new { TaskStatusID = s.TaskStatusID, TaskStatusDisplayName = s.TaskStatusDisplayName }).ToList();
    }
    public static IEnumerable TaskPriorityList()
    {
        return LINQData.db.PM_ProjectTaskPriorities.Select(s => new { TaskPriorityID = s.TaskPriorityID, TaskPriorityDisplayName = s.TaskPriorityDisplayName }).ToList();
    }
    public static List<OrdersProcessObject> OrdersProcessList(int ProcessListId) {
        return LINQData.db.PM_ProjectProcesses.Where(w => (w.ProcessListId == ProcessListId || w.ProcessPlusBrowse == ProcessListId) && w.ProcessGangerBrowse == false)
            .GroupJoin(LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskStatusID == 3), pp => pp.ProcessProjectTaskID, pt => pt.ProjectTaskID, (pp, pt) => new { pp, pt })
            .SelectMany(sm => sm.pt, (sm, pt) => new { sm.pp, pt })
            .GroupJoin(LINQData.db.PM_ProjectMolds, pp => pp.pt.ProjectTaskMoldsId, pm => pm.MoldsId, (pp, pm) => new { pp, pm })
            .SelectMany(sm => sm.pm, (sm, pm) => new { sm.pp, pm })
            .GroupJoin(LINQData.db.PM_ProjectCustomers, pp => pp.pp.pt.ProjectTaskCustomerId, pc => pc.CustomerId, (pp, pc) => new { pp, pc })
            .SelectMany(sm => sm.pc.DefaultIfEmpty(), (sm, pc) => new OrdersProcessObject
            {
                ProjectTaskID = sm.pp.pp.pt.ProjectTaskID,
                ProcessListId = sm.pp.pp.pp.ProcessListId,
                ProjectTaskMoldCode = sm.pp.pp.pt.ProjectTaskMoldCode,
                ProjectTaskOverlayNum = sm.pp.pp.pt.ProjectTaskOverlayNum,
                MoldsName = sm.pp.pm.MoldsName,
                ProjectTaskDiameterOut = sm.pp.pp.pt.ProjectTaskDiameterOut,
                ProjectTaskQuantities = sm.pp.pp.pt.ProjectTaskQuantities,
                ProjectTaskThickness = sm.pp.pp.pt.ProjectTaskThickness,
                ProjectTaskTransmit = sm.pp.pp.pt.ProjectTaskTransmit,
                ProjectTaskDeadline = sm.pp.pp.pt.ProjectTaskDeadline,
                ProcessId = sm.pp.pp.pp.ProcessId,
                ProcessGangerBrowse = sm.pp.pp.pp.ProcessGangerBrowse,
                ProcessExpectedTime = sm.pp.pp.pp.ProcessExpectedTime,
                ProcessFactTime = sm.pp.pp.pp.ProcessFactTime,
                ProcessPlusBrowse = sm.pp.pp.pp.ProcessPlusBrowse,
                CustomerName = pc.CustomerName,
                ProjectTaskPriorityID = sm.pp.pp.pt.ProjectTaskPriorityID,
                ProcessExpectedCompletion = sm.pp.pp.pp.ProcessExpectedCompletion,
                ProcessNotes = sm.pp.pp.pp.ProcessNotes,
                DX_HoanThanhDuKien = sm.pp.pp.pp.DX_HoanThanhDuKien,
                DXMoTa = sm.pp.pp.pt.ProjectTaskDescription,
                DXNgayNhanThucTe = sm.pp.pp.pp.DXNgayNhanThucTe,
                DXNgayBatDauDuKien = sm.pp.pp.pp.DXNgayBatDauDuKien,
                DXThoiGianDieuChinh = sm.pp.pp.pp.DXThoiGianDieuChinh,
                DXMaSanPhamUuTienGiaCong = sm.pp.pp.pp.DXMaSanPhamUuTienGiaCong,
                DX_XuatHang_DuKien = sm.pp.pp.pt.DX_XuatHang_DuKien,
                DX_XuatHang_ThucTe = sm.pp.pp.pt.DX_XuatHang_ThucTe,
                DX_XuatHang_TruocDuKien = sm.pp.pp.pt.DX_XuatHang_TruocDuKien != null ? sm.pp.pp.pt.DX_XuatHang_TruocDuKien : false,
                AutoPriority = Convert.ToInt32(((Convert.ToDateTime(sm.pp.pp.pt.ProjectTaskTransmit) - DateTime.Now).Days + (Convert.ToDateTime(sm.pp.pp.pt.ProjectTaskDeadline) - DateTime.Now).Days) - sm.pp.pm.MoldsMinScheduledDays)
            }).OrderBy(o => o.AutoPriority).OrderBy(o1 => o1.ProjectTaskPriorityID).OrderByDescending(o => o.DX_XuatHang_TruocDuKien).ToList();
    }
    public static void OrdersProcessUpdated(int ProjectTaskID, int ProcessListId, bool ProcessGangerBrowse, decimal ProcessExpectedTime, decimal DXThoiGianDieuChinh, DateTime ProcessExpectedCompletion, DateTime? DXNgayNhanThucTe, DateTime DXNgayBatDauDuKien, int ProcessPlusBrowse, string DXMaSanPhamUuTienGiaCong, string ProcessNotes) {
        using (TransactionScope transactionScope = new TransactionScope()) {
            try {
                bool finish = true;
                bool finishTho = true;
                bool finishTinh = true;
                PM_ProjectProcess pp = LINQData.db.PM_ProjectProcesses.FirstOrDefault(x => x.ProcessProjectTaskID == ProjectTaskID && x.ProcessListId == ProcessListId);                
                List<PM_ProjectProcess> ppl = LINQData.db.PM_ProjectProcesses.Where(w => w.ProcessProjectTaskID == ProjectTaskID).ToList();
                if (pp != null) {
                    pp.ProcessExpectedTime = ProcessExpectedTime;
                    //pp.ProcessExpectedCompletion = ProcessExpectedCompletion;
                    if (DXNgayNhanThucTe.HasValue)
                        pp.DXNgayNhanThucTe = DXNgayNhanThucTe;
                    //pp.DXNgayBatDauDuKien = DXNgayBatDauDuKien;
                    pp.DXThoiGianDieuChinh = DXThoiGianDieuChinh;
                    //pp.DXNgayKetThucDuKien = Convert.ToDateTime(DXNgayBatDauDuKien).AddHours(Convert.ToDouble(ProcessExpectedTime)).AddHours(Convert.ToDouble(DXThoiGianDieuChinh));     
                    pp.DXMaSanPhamUuTienGiaCong = DXMaSanPhamUuTienGiaCong;
                    pp.ProcessNotes = ProcessNotes;
                    pp.ModifiedWhen = DateTime.Now;
                    pp.ModifiedByUserId = CMSContext.CurrentUser.UserID;
                    //DataUtils.WriteLog(pp.ProcessListId + "|" + pp.ProcessPlusBrowse + "|" + ProcessPlusBrowse);
                    if (pp.ProcessPlusBrowse == null)
                        pp.ProcessGangerBrowse = ProcessGangerBrowse;
                    if (pp.ProcessListId == pp.ProcessPlusBrowse && ProcessPlusBrowse == 0)
                        ppl.ForEach(fe => fe.ProcessPlusBrowse = null);
                    else if (pp.ProcessListId != pp.ProcessPlusBrowse && pp.ProcessPlusBrowse == null && ProcessPlusBrowse > 0) {
                        PM_ProjectProcess ppb = LINQData.db.PM_ProjectProcesses.FirstOrDefault(x => x.ProcessProjectTaskID == ProjectTaskID && x.ProcessListId == ProcessPlusBrowse);
                        if (ppb != null && ppb.ProcessGangerBrowse == true) {
                            pp.ProcessPlusBrowse = ProcessPlusBrowse;
                            ppb.ProcessPlusBrowse = ProcessPlusBrowse;
                        }
                    }
                    if (ProcessGangerBrowse) {
                        pp.ProcessFactTime = LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailProjectTaskID == ProjectTaskID)
                                                        .Join(LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == ProcessListId), ppd => ppd.DetailSubProcessId, psp => psp.SubProcessId, (ppd, psp) => new { ppd, psp })
                                                        .Sum(s => s.ppd.DetailTotalTimeM);
                        if(!pp.ProcessCompletion.HasValue)
                            pp.ProcessCompletion = DateTime.Now;
                    }
                    PM_ProjectProcess ppTo = LINQData.db.PM_ProjectProcesses.FirstOrDefault(x => x.ProcessProjectTaskID == ProjectTaskID && x.ProcessListId == pp.DXChuyenQuaCongDoan);
                    //if (ppTo != null)
                        //ppTo.ProcessExpectedCompletion = Convert.ToDateTime(pp.DXNgayBatDauDuKien).AddHours(Convert.ToDouble(pp.ProcessExpectedTime)).AddHours(Convert.ToDouble(pp.DXThoiGianDieuChinh));
                }
                if (ppl.FirstOrDefault(fod => fod.ProcessGangerBrowse == false) != null)
                    finish = false;
                List<ProjectProcessObject> lsTho = ppl.Join(LINQData.db.PM_ProjectProcessLists.Where(w => w.ProcessListGroup == "dataTho"), ppll => ppll.ProcessListId, ppls => ppls.ProcessListId, (ppll, ppls) => new { ppll, ppls })
                                                      .Select(s => new ProjectProcessObject { ProcessGangerBrowse = s.ppll.ProcessGangerBrowse,  }).ToList();
                if (lsTho.FirstOrDefault(fod => fod.ProcessGangerBrowse == false) != null)
                    finishTho = false;
                List<ProjectProcessObject> lsTinh = ppl.Join(LINQData.db.PM_ProjectProcessLists.Where(w => w.ProcessListGroup == "dataTinh"), ppll => ppll.ProcessListId, ppls => ppls.ProcessListId, (ppll, ppls) => new { ppll, ppls })
                                                      .Select(s => new ProjectProcessObject { ProcessGangerBrowse = s.ppll.ProcessGangerBrowse, }).ToList();
                if (lsTinh.FirstOrDefault(fod => fod.ProcessGangerBrowse == false) != null)
                    finishTinh = false;
                PM_ProjectTask pt = LINQData.db.PM_ProjectTasks.Where(w => w.ProjectTaskID == ProjectTaskID).FirstOrDefault();
                if (pt != null && finish) {
                    pt.ProjectTaskStatusID = 7;
                    pt.DX_XuatHang_ThucTe = DateTime.Now;
                }
                LINQData.db.SubmitChanges();
                transactionScope.Complete();                
            }
            catch (TransactionAbortedException ex) { DataUtils.WriteLog(ex.Message); }
        }
    }
    public static List<OrdersProcessDetailObject> OrdersProcessListDetail(int ProjectTaskID, int ProcessListId)
    {
        return LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailProjectTaskID == ProjectTaskID)
            .Join(LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == ProcessListId), ppd => ppd.DetailSubProcessId, psp => psp.SubProcessId, (ppd, psp) => new { ppd, psp })
            .Select(s => new OrdersProcessDetailObject
            {
                DetailId = s.ppd.DetailId,
                ProjectTaskID = s.ppd.DetailProjectTaskID,
                DetailMachineId = s.ppd.DetailMachineId,
                SubProcessID = s.psp.SubProcessId,
                DetailStartTimeM = s.ppd.DetailStartTimeM,
                DetailEndTimeM = s.ppd.DetailEndTimeM,
                DetailOwnerM = s.ppd.DetailOwnerM,
                DetailTotalTimeM = s.ppd.DetailTotalTimeM
            }).ToList();
    }
    public static void OrdersProcessDetailCreated(int ProjectTaskID, int SubProcessID, int DetailMachineId, DateTime DetailStartTimeM, DateTime DetailEndTimeM, decimal DetailTotalTimeM, int DetailOwnerM)
    {
        LINQData.db.PM_ProjectProcessDetails.InsertOnSubmit(new PM_ProjectProcessDetail()
        {
            DetailProjectTaskID = ProjectTaskID,
            DetailSubProcessId = SubProcessID,
            DetailMachineId = DetailMachineId,
            DetailStartTimeM = DetailStartTimeM,
            DetailEndTimeM = DetailEndTimeM,
            DetailTotalTimeM = DetailTotalTimeM,
            DetailOwnerM = DetailOwnerM,
            DetailOwnerP = DetailOwnerM
        });
        PM_ProjectSubProcess psp = LINQData.db.PM_ProjectSubProcesses.FirstOrDefault(fod => fod.SubProcessId == SubProcessID);
        if (psp != null) {
            PM_ProjectProcess pp = LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessListId == psp.SubProcessListId && fod.ProcessProjectTaskID == ProjectTaskID);
            if(!pp.DXGioBatDauThucTe.HasValue)
                pp.DXGioBatDauThucTe = DetailStartTimeM;
            if (psp.SubProcessFinish == true && !pp.ProcessCompletion.HasValue)                
                pp.ProcessCompletion = DetailEndTimeM;
            if (pp.ProcessCompletion.HasValue && pp.ProcessCompletion < DetailEndTimeM)
                pp.ProcessCompletion = DetailEndTimeM;
        }
        LINQData.db.SubmitChanges();
    }
    public static void OrdersProcessDetailUpdated(int DetailId, int SubProcessID, int DetailMachineId, DateTime DetailStartTimeM, DateTime DetailEndTimeM, decimal DetailTotalTimeM, int DetailOwnerM)
    {
        PM_ProjectProcessDetail ppd = LINQData.db.PM_ProjectProcessDetails.FirstOrDefault(fod => fod.DetailId == DetailId);
        if (ppd != null)
        {
            ppd.DetailSubProcessId = SubProcessID;
            ppd.DetailMachineId = DetailMachineId;
            ppd.DetailStartTimeM = DetailStartTimeM;
            ppd.DetailEndTimeM = DetailEndTimeM;
            ppd.DetailTotalTimeM = DetailTotalTimeM;
            ppd.DetailOwnerM = DetailOwnerM;
            PM_ProjectSubProcess psp = LINQData.db.PM_ProjectSubProcesses.FirstOrDefault(fod => fod.SubProcessId == SubProcessID);
            if (psp != null && psp.SubProcessFinish == true)
            {
                PM_ProjectProcess pp = LINQData.db.PM_ProjectProcesses.FirstOrDefault(fod => fod.ProcessListId == psp.SubProcessListId && fod.ProcessProjectTaskID == ppd.DetailProjectTaskID);
                if (pp.ProcessCompletion.HasValue && pp.ProcessCompletion < DetailEndTimeM)
                    pp.ProcessCompletion = DetailEndTimeM;
            }
            LINQData.db.SubmitChanges();
        }
    }
    public static void OrdersProcessDetailDeleted(int DetailId)
    {
        PM_ProjectProcessDetail ProjectProcessDetail = LINQData.db.PM_ProjectProcessDetails.Where(w => w.DetailId == DetailId).FirstOrDefault();
        if (ProjectProcessDetail != null)
        {
            LINQData.db.PM_ProjectProcessDetails.DeleteOnSubmit(ProjectProcessDetail);
            LINQData.db.SubmitChanges();
        }
    }
    public static IEnumerable MinOrdersSubProcessList(int ProcessListId)
    {
        return LINQData.db.PM_ProjectSubProcesses.Where(w => w.SubProcessListId == ProcessListId)
                          .Select(s => new { SubProcessID = s.SubProcessId, SubProcessName = s.SubProcessName, SubProcessFinish = s.SubProcessFinish }).OrderBy(x => x.SubProcessName).ToList();
    }
    public static IEnumerable MinOrdersMachineryList(int ProcessListId)
    {
        return LINQData.db.PM_ProjectMachineries.Where(w => w.MachineryProcessListId == ProcessListId)
                          .Select(s => new { MachineryID = s.MachineryId, MachineryName = s.MachineryName, MachinerySymbol = s.MachinerySymbol }).OrderBy(x => x.MachineryName).ToList();
    }
}