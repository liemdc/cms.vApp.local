using CMS.CMSHelper;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class MoldsModels {
    public static List<MoldsObject> MoldsList() {        
        return LINQData.db.PM_ProjectMolds
                .GroupJoin(LINQData.db.CMS_Users, m => m.ModifiedByUserId, userc => userc.UserID, (m, userm) => new { m, userm })
                .SelectMany(sm => sm.userm.DefaultIfEmpty(), (sm, userm) => new MoldsObject { 
                    MoldsId = sm.m.MoldsId, MoldsName = sm.m.MoldsName, MoldsMinScheduledDays = sm.m.MoldsMinScheduledDays, MoldsFactor = sm.m.MoldsFactor, UserModified = userm.FullName
                }).OrderBy(o => o.MoldsName).ToList();
    }	
    public static List<MoldsObject> MinMoldsList() {        
        return LINQData.db.PM_ProjectMolds.Select(s => new MoldsObject { 
            MoldsId = s.MoldsId, MoldsName = s.MoldsName, MoldsFactor = s.MoldsFactor
        }).OrderBy(o => o.MoldsName).ToList();
    }    
    public static void MoldsCreated(string MoldsName, decimal MoldsMinScheduledDays, decimal MoldsFactor) {
        LINQData.db.PM_ProjectMolds.InsertOnSubmit(new PM_ProjectMold() { 
            MoldsName = MoldsName, MoldsMinScheduledDays = MoldsMinScheduledDays, MoldsFactor = MoldsFactor, CreatedWhen = DateTime.Now, CreatedByUserId = CMSContext.CurrentUser.UserID, ModifiedWhen = DateTime.Now, ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }    
    public static void MoldsUpdated(int MoldsId, string MoldsName, decimal MoldsMinScheduledDays, decimal MoldsFactor) {
        PM_ProjectMold Molds = LINQData.db.PM_ProjectMolds.FirstOrDefault(fod => fod.MoldsId == MoldsId);
        if (Molds != null) {
            Molds.MoldsName = MoldsName;
            Molds.MoldsMinScheduledDays = MoldsMinScheduledDays;
            Molds.MoldsFactor = MoldsFactor;
            Molds.ModifiedWhen = DateTime.Now;
            Molds.ModifiedByUserId = CMSContext.CurrentUser.UserID;
            LINQData.db.SubmitChanges();
        }
    }
    public static void MoldsDeleted(int MoldsId) {
        PM_ProjectMold Molds = LINQData.db.PM_ProjectMolds.FirstOrDefault(fod => fod.MoldsId == MoldsId);
        if (Molds != null) {
            LINQData.db.PM_ProjectMolds.DeleteOnSubmit(Molds);
            LINQData.db.SubmitChanges();
        }
    }
    public static List<MoldsProcessObject> MoldsProcessListByMoldsId(int MoldsId) {        
        return LINQData.db.IV_tblMoldsProcesses.Where(w => w.MoldsId == MoldsId)
                .GroupJoin(LINQData.db.PM_ProjectProcessLists, mp => mp.ProcessListId, pl => pl.ProcessListId, (mp, pl) => new {mp, pl})
                .SelectMany(sm => sm.pl.DefaultIfEmpty(), (sm, pl) => new { sm, pl })
                .GroupJoin(LINQData.db.CMS_Users, mp1 => mp1.sm.mp.ModifiedByUserId, userc => userc.UserID, (mp1, userm) => new { mp1, userm })
                .SelectMany(sm1 => sm1.userm.DefaultIfEmpty(), (sm1, userm) => new MoldsProcessObject { 
                    MoldsProcessId = sm1.mp1.sm.mp.MoldsProcessId, MoldsId = sm1.mp1.sm.mp.MoldsId, ProcessListId = sm1.mp1.sm.mp.ProcessListId, ProcessListName = sm1.mp1.pl.ProcessListName, UserModified = userm.FullName
                }).ToList();
    }
    public static void MoldsProcessCreated(int MoldsId, int ProcessListId) {
        LINQData.db.IV_tblMoldsProcesses.InsertOnSubmit(new IV_tblMoldsProcess() { 
            MoldsId = MoldsId, ProcessListId = ProcessListId, CreatedWhen = DateTime.Now, CreatedByUserId = CMSContext.CurrentUser.UserID, ModifiedWhen = DateTime.Now, ModifiedByUserId = CMSContext.CurrentUser.UserID
        });
        LINQData.db.SubmitChanges();
    }
    public static void MoldsProcessDeleted(int MoldsProcessId) {
        IV_tblMoldsProcess MoldsProcess = LINQData.db.IV_tblMoldsProcesses.FirstOrDefault(fod => fod.MoldsProcessId == MoldsProcessId);
        if (MoldsProcess != null) {
            LINQData.db.IV_tblMoldsProcesses.DeleteOnSubmit(MoldsProcess);
            LINQData.db.SubmitChanges();
        }
    }
}