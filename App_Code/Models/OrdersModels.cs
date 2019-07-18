﻿using CMS.CMSHelper;
using CMS.ProjectManagement;
using Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
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
        return LINQData.db.PM_ProjectTasks
                .GroupJoin(LINQData.db.CMS_Users, t => t.ModifiedByUserId, userc => userc.UserID, (t, userm) => new { t, userm })
                .SelectMany(sm => sm.userm.DefaultIfEmpty(), (sm, userm) => new OrdersObject {
                    ProjectTaskID               = sm.t.ProjectTaskID,
                    ProjectTaskCustomerId       = sm.t.ProjectTaskCustomerId,
                    ProjectTaskDeadline         = sm.t.ProjectTaskDeadline,
                    ProjectTaskDescription      = sm.t.ProjectTaskDescription,
                    ProjectTaskDiameterOut      = sm.t.ProjectTaskDiameterOut,
                    ProjectTaskDisplayName      = sm.t.ProjectTaskDisplayName,
                    ProjectTaskHardness         = sm.t.ProjectTaskHardness,
                    ProjectTaskHoleNum          = sm.t.ProjectTaskHoleNum,
                    ProjectTaskHorikomi         = sm.t.ProjectTaskHorikomi,
                    ProjectTaskMaterialsCode    = sm.t.ProjectTaskMaterialsCode,
                    ProjectTaskMaterialsRequire = sm.t.ProjectTaskMaterialsRequire,
                    ProjectTaskMoldCode         = sm.t.ProjectTaskMoldCode,
                    ProjectTaskMoldsId          = sm.t.ProjectTaskMoldsId,
                    ProjectTaskOverlayNum       = sm.t.ProjectTaskOverlayNum,
                    ProjectTaskPriorityID       = sm.t.ProjectTaskPriorityID,
                    ProjectTaskQuantities       = sm.t.ProjectTaskQuantities,
                    ProjectTaskStatusID         = sm.t.ProjectTaskStatusID,
                    ProjectTaskThickness        = sm.t.ProjectTaskThickness,
                    ProjectTaskThicknessTotal   = sm.t.ProjectTaskThicknessTotal,
                    ProjectTaskTransmit         = sm.t.ProjectTaskTransmit,
                    CreatedWhen                 = sm.t.CreatedWhen,
                    UserModified                = userm.FullName,
                    DX_MaDonHang                = sm.t.DX_MaDonHang,
                    DX_XuatHang_DuKien = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_XuatHang_DuKien"],
                    DX_XuatHang_ThucTe = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_XuatHang_ThucTe"],
                    DX_DuKienGC_EDM = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_EDM"],
                    DX_DuKienHT_EDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_EDM"],
                    DX_ThucTeHT_EDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_EDM"],
                    DX_DuKienGC_Mai = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_Mai"],
                    DX_DuKienHT_Mai = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_Mai"],
                    DX_ThucTeHT_Mai = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_Mai"],
                    DX_DuKienGC_MC = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_MC"],
                    DX_DuKienHT_MC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_MC"],
                    DX_ThucTeHT_MC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_MC"],
                    DX_DuKienGC_NC = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_NC"],
                    DX_DuKienHT_NC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_NC"],
                    DX_ThucTeHT_NC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_NC"],
                    DX_DuKienGC_Nhiet = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_Nhiet"],
                    DX_DuKienHT_Nhiet = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_Nhiet"],
                    DX_ThucTeHT_Nhiet = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_Nhiet"],
                    DX_DuKienGC_PhayTay = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_PhayTay"],
                    DX_DuKienHT_PhayTay = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_PhayTay"],
                    DX_ThucTeHT_PhayTay = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_PhayTay"],
                    DX_DuKienGC_QA = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_QA"],
                    DX_DuKienHT_QA = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_QA"],
                    DX_ThucTeHT_QA = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_QA"],
                    DX_DuKienGC_WEDM = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_WEDM"],
                    DX_DuKienHT_WEDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_WEDM"],
                    DX_ThucTeHT_WEDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_WEDM"],
                    DX_DuKienGC_LapRap = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_LapRap"],
                    DX_DuKienHT_LapRap = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_LapRap"],
                    DX_ThucTeHT_LapRap = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_LapRap"]
                }).OrderBy(o => o.ProjectTaskMoldCode);
    }
    public static IEnumerable<OrdersObject> OrdersListNd(string TaskStatus, string TaskPriority, DateTime DateBeginB, DateTime DateEndB) {
        int[] statusIds = Array.ConvertAll(TaskStatus.Split(';'), s => int.Parse(s));
        int[] priorityIds = Array.ConvertAll(TaskPriority.Split(';'), s => int.Parse(s));
        return LINQData.db.PM_ProjectTasks.Where(w => statusIds.Contains(w.ProjectTaskStatusID) && priorityIds.Contains(w.ProjectTaskPriorityID) && w.DX_XuatHang_DuKien >= DateBeginB && w.DX_XuatHang_DuKien <= DateEndB)
                .GroupJoin(LINQData.db.CMS_Users, t => t.ModifiedByUserId, userc => userc.UserID, (t, userm) => new { t, userm })
                .SelectMany(sm => sm.userm.DefaultIfEmpty(), (sm, userm) => new OrdersObject {
                    ProjectTaskID               = sm.t.ProjectTaskID,
                    ProjectTaskCustomerId       = sm.t.ProjectTaskCustomerId,
                    ProjectTaskDeadline         = sm.t.ProjectTaskDeadline,
                    ProjectTaskDescription      = sm.t.ProjectTaskDescription,
                    ProjectTaskDiameterOut      = sm.t.ProjectTaskDiameterOut,
                    ProjectTaskDisplayName      = sm.t.ProjectTaskDisplayName,
                    ProjectTaskHardness         = sm.t.ProjectTaskHardness,
                    ProjectTaskHoleNum          = sm.t.ProjectTaskHoleNum,
                    ProjectTaskHorikomi         = sm.t.ProjectTaskHorikomi,
                    ProjectTaskMaterialsCode    = sm.t.ProjectTaskMaterialsCode,
                    ProjectTaskMaterialsRequire = sm.t.ProjectTaskMaterialsRequire,
                    ProjectTaskMoldCode         = sm.t.ProjectTaskMoldCode,
                    ProjectTaskMoldsId          = sm.t.ProjectTaskMoldsId,
                    ProjectTaskOverlayNum       = sm.t.ProjectTaskOverlayNum,
                    ProjectTaskPriorityID       = sm.t.ProjectTaskPriorityID,
                    ProjectTaskQuantities       = sm.t.ProjectTaskQuantities,
                    ProjectTaskStatusID         = sm.t.ProjectTaskStatusID,
                    ProjectTaskThickness        = sm.t.ProjectTaskThickness,
                    ProjectTaskThicknessTotal   = sm.t.ProjectTaskThicknessTotal,
                    ProjectTaskTransmit         = sm.t.ProjectTaskTransmit,
                    CreatedWhen                 = sm.t.CreatedWhen,
                    UserModified                = userm.FullName,
                    DX_MaDonHang                = sm.t.DX_MaDonHang,
                    DX_XuatHang_DuKien = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_XuatHang_DuKien"],
                    DX_XuatHang_ThucTe = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_XuatHang_ThucTe"],
                    DX_DuKienGC_EDM = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_EDM"],
                    DX_DuKienHT_EDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_EDM"],
                    DX_ThucTeHT_EDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_EDM"],
                    DX_DuKienGC_Mai = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_Mai"],
                    DX_DuKienHT_Mai = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_Mai"],
                    DX_ThucTeHT_Mai = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_Mai"],
                    DX_DuKienGC_MC = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_MC"],
                    DX_DuKienHT_MC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_MC"],
                    DX_ThucTeHT_MC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_MC"],
                    DX_DuKienGC_NC = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_NC"],
                    DX_DuKienHT_NC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_NC"],
                    DX_ThucTeHT_NC = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_NC"],
                    DX_DuKienGC_Nhiet = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_Nhiet"],
                    DX_DuKienHT_Nhiet = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_Nhiet"],
                    DX_ThucTeHT_Nhiet = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_Nhiet"],
                    DX_DuKienGC_PhayTay = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_PhayTay"],
                    DX_DuKienHT_PhayTay = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_PhayTay"],
                    DX_ThucTeHT_PhayTay = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_PhayTay"],
                    DX_DuKienGC_QA = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_QA"],
                    DX_DuKienHT_QA = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_QA"],
                    DX_ThucTeHT_QA = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_QA"],
                    DX_DuKienGC_WEDM = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_WEDM"],
                    DX_DuKienHT_WEDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_WEDM"],
                    DX_ThucTeHT_WEDM = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_WEDM"],
                    DX_DuKienGC_LapRap = (Decimal?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienGC_LapRap"],
                    DX_DuKienHT_LapRap = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_DuKienHT_LapRap"],
                    DX_ThucTeHT_LapRap = (DateTime?)JObject.Parse(sm.t.DX_CongDoanTG)["DX_ThucTeHT_LapRap"]
                }).OrderByDescending(o => o.ProjectTaskTransmit).ThenBy(o => o.ProjectTaskPriorityID);
    }
    public static void OrdersCreated(string ProjectTaskMoldCode, string ProjectTaskOverlayNum, string ProjectTaskHoleNum, decimal ProjectTaskDiameterOut, string ProjectTaskMaterialsRequire, string ProjectTaskMaterialsCode, int ProjectTaskMoldsId,
                                     int ProjectTaskThickness, string ProjectTaskThicknessTotal, int ProjectTaskQuantities, string ProjectTaskHorikomi, string ProjectTaskHardness, int ProjectTaskCustomerId,
                                     DateTime? DX_XuatHang_DuKien,
                                     DateTime? DX_DuKienHT_EDM,
                                     DateTime? DX_DuKienHT_Mai,
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

                // -----
                DonHang_CongDoanTG data = new DonHang_CongDoanTG { };
                data.DX_DuKienHT_EDM = DX_DuKienHT_EDM;
                data.DX_DuKienHT_Mai = DX_DuKienHT_Mai;
                data.DX_DuKienHT_MC = DX_DuKienHT_MC;
                data.DX_DuKienHT_NC = DX_DuKienHT_NC;
                data.DX_DuKienHT_Nhiet = DX_DuKienHT_Nhiet;
                data.DX_DuKienHT_PhayTay = DX_DuKienHT_PhayTay;
                data.DX_DuKienHT_QA = DX_DuKienHT_QA;
                data.DX_DuKienHT_WEDM = DX_DuKienHT_WEDM;
                data.DX_DuKienHT_LapRap = DX_DuKienHT_LapRap;
                data.DX_XuatHang_DuKien = DX_XuatHang_DuKien;

                JObject oData = (JObject)JToken.FromObject(data);
                pt.DX_CongDoanTG = oData.ToString(Formatting.None);

                //pt.DX_XuatHang_DuKien   = DX_XuatHang_DuKien.HasValue ? DX_XuatHang_DuKien : null;
                //pt.DX_DuKienHT_EDM      = DX_DuKienHT_EDM.HasValue ? DX_DuKienHT_EDM : null;
                //pt.DX_DuKienHT_Mai      = DX_DuKienHT_Mai.HasValue ? DX_DuKienHT_Mai : null;
                //pt.DX_DuKienHT_MC       = DX_DuKienHT_MC.HasValue ? DX_DuKienHT_MC : null;
                //pt.DX_DuKienHT_NC       = DX_DuKienHT_NC.HasValue ? DX_DuKienHT_NC : null;
                //pt.DX_DuKienHT_Nhiet    = DX_DuKienHT_Nhiet.HasValue ? DX_DuKienHT_Nhiet : null;
                //pt.DX_DuKienHT_PhayTay  = DX_DuKienHT_PhayTay.HasValue ? DX_DuKienHT_PhayTay : null;
                //pt.DX_DuKienHT_QA       = DX_DuKienHT_QA.HasValue ? DX_DuKienHT_QA : null;
                //pt.DX_DuKienHT_WEDM     = DX_DuKienHT_WEDM.HasValue ? DX_DuKienHT_WEDM : null;

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
                foreach (var MoldsProcess in ListMoldsProcess) {
                    int dataQA = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListGroup.Equals("dataQA")).ProcessListId;
                    Nullable<Boolean> DXNhanDuKien = LINQData.db.PM_ProjectProcessLists.FirstOrDefault(fod => fod.ProcessListId == MoldsProcess.ProcessListId).DXNhanDuKien;
                    Nullable<DateTime> DXNgayNhanDuKien = (DXNhanDuKien == true ? ProjectTaskTransmit.AddHours(1) : (DateTime?)null);
                    LINQData.db.PM_ProjectProcesses.InsertOnSubmit(new PM_ProjectProcess() {
                        ProcessProjectTaskID = newTask.ProjectTaskID,
                        ProcessListId = MoldsProcess.ProcessListId,
                        ProcessRequired = true,
                        ProcessGangerBrowse = false,
                        ProcessSMGangerBrowse = false,
                        DXChuyenQuaCongDoan = ProcessTo,
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
                                     DateTime? DX_DuKienHT_EDM,
                                     DateTime? DX_DuKienHT_Mai,
                                     DateTime? DX_DuKienHT_MC,
                                     DateTime? DX_DuKienHT_NC,
                                     DateTime? DX_DuKienHT_Nhiet,
                                     DateTime? DX_DuKienHT_PhayTay,
                                     DateTime? DX_DuKienHT_QA,
                                     DateTime? DX_DuKienHT_WEDM,
                                     DateTime? DX_DuKienHT_LapRap, DateTime ProjectTaskDeadline, DateTime ProjectTaskTransmit, string ProjectTaskDescription)
    {
        using (TransactionScope transactionScope = new TransactionScope())
        {
            try
            {
                bool UpdateProcess = false;
                PM_ProjectTask pt = LINQData.db.PM_ProjectTasks.FirstOrDefault(x => x.ProjectTaskID == ProjectTaskID);
                if (pt != null)
                {
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

                    // -----
                    JObject rx = JObject.Parse(pt.DX_CongDoanTG);
                    rx["DX_DuKienHT_EDM"] = DX_DuKienHT_EDM;
                    rx["DX_DuKienHT_Mai"] = DX_DuKienHT_Mai;
                    rx["DX_DuKienHT_MC"] = DX_DuKienHT_MC;
                    rx["DX_DuKienHT_NC"] = DX_DuKienHT_NC;
                    rx["DX_DuKienHT_Nhiet"] = DX_DuKienHT_Nhiet;
                    rx["DX_DuKienHT_PhayTay"] = DX_DuKienHT_PhayTay;
                    rx["DX_DuKienHT_QA"] = DX_DuKienHT_QA;
                    rx["DX_DuKienHT_WEDM"] = DX_DuKienHT_WEDM;
                    rx["DX_DuKienHT_LapRap"] = DX_DuKienHT_LapRap;
                    rx["DX_XuatHang_DuKien"] = DX_XuatHang_DuKien;
                    pt.DX_CongDoanTG = rx.ToString(Formatting.None);
                    //pt.DX_XuatHang_DuKien = DX_XuatHang_DuKien.HasValue ? DX_XuatHang_DuKien : null;
                    //pt.DX_DuKienHT_EDM = DX_DuKienHT_EDM.HasValue ? DX_DuKienHT_EDM : null;
                    //pt.DX_DuKienHT_Mai = DX_DuKienHT_Mai.HasValue ? DX_DuKienHT_Mai : null;
                    //pt.DX_DuKienHT_MC = DX_DuKienHT_MC.HasValue ? DX_DuKienHT_MC : null;
                    //pt.DX_DuKienHT_NC = DX_DuKienHT_NC.HasValue ? DX_DuKienHT_NC : null;
                    //pt.DX_DuKienHT_Nhiet = DX_DuKienHT_Nhiet.HasValue ? DX_DuKienHT_Nhiet : null;
                    //pt.DX_DuKienHT_PhayTay = DX_DuKienHT_PhayTay.HasValue ? DX_DuKienHT_PhayTay : null;
                    //pt.DX_DuKienHT_QA = DX_DuKienHT_QA.HasValue ? DX_DuKienHT_QA : null;
                    //pt.DX_DuKienHT_WEDM = DX_DuKienHT_WEDM.HasValue ? DX_DuKienHT_WEDM : null;

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
                }
                LINQData.db.SubmitChanges();
                transactionScope.Complete();
            }
            catch { }
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
            pt.DX_DuKienHT_EDM = DX_DuKienHT_EDM.HasValue ? DX_DuKienHT_EDM : null;
            pt.DX_DuKienHT_Mai = DX_DuKienHT_Mai.HasValue ? DX_DuKienHT_Mai : null;
            pt.DX_DuKienHT_MC = DX_DuKienHT_MC.HasValue ? DX_DuKienHT_MC : null;
            pt.DX_DuKienHT_NC = DX_DuKienHT_NC.HasValue ? DX_DuKienHT_NC : null;
            pt.DX_DuKienHT_Nhiet = DX_DuKienHT_Nhiet.HasValue ? DX_DuKienHT_Nhiet : null;
            pt.DX_DuKienHT_PhayTay = DX_DuKienHT_PhayTay.HasValue ? DX_DuKienHT_PhayTay : null;
            pt.DX_DuKienHT_QA = DX_DuKienHT_QA.HasValue ? DX_DuKienHT_QA : null;
            pt.DX_DuKienHT_WEDM = DX_DuKienHT_WEDM.HasValue ? DX_DuKienHT_WEDM : null;
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
                DXMoTa = sm.pp.pp.pt.ProjectTaskDescription,
                DXNgayNhanThucTe = sm.pp.pp.pp.DXNgayNhanThucTe,
                DXNgayBatDauDuKien = sm.pp.pp.pp.DXNgayBatDauDuKien,
                DXThoiGianDieuChinh = sm.pp.pp.pp.DXThoiGianDieuChinh,
                DXMaSanPhamUuTienGiaCong = sm.pp.pp.pp.DXMaSanPhamUuTienGiaCong,
                AutoPriority = Convert.ToInt32(((Convert.ToDateTime(sm.pp.pp.pt.ProjectTaskTransmit) - DateTime.Now).Days + (Convert.ToDateTime(sm.pp.pp.pt.ProjectTaskDeadline) - DateTime.Now).Days) - sm.pp.pm.MoldsMinScheduledDays)
            }).OrderBy(o => o.AutoPriority).OrderBy(o1 => o1.ProjectTaskPriorityID).ToList();
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