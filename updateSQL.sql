-- Add Column ProcessListGroup NVARCHAR (255)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcessList') AND name = 'ProcessListGroup' )
BEGIN ALTER TABLE PM_ProjectProcessList
	ADD ProcessListGroup NVARCHAR (255);
	PRINT ('ADD ProcessListGroup NVARCHAR (255);');
END
GO
-- Add Column MachineryStatus NVARCHAR (50)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectMachinery') AND name = 'MachineryStatus' )
BEGIN ALTER TABLE PM_ProjectMachinery
	ADD MachineryStatus NVARCHAR (50);
	PRINT ('ADD MachineryStatus NVARCHAR (50);');
END
GO
-- Add Column ProjectTaskThucTeThoQuaTinh DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskThucTeThoQuaTinh' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD ProjectTaskThucTeThoQuaTinh DATETIME;
	PRINT ('ADD ProjectTaskThucTeThoQuaTinh DATETIME;');
END
GO
-- Add Column ProjectTaskThucTeTinhQuaQA DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskThucTeTinhQuaQA' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD ProjectTaskThucTeTinhQuaQA DATETIME;
	PRINT ('ADD ProjectTaskThucTeTinhQuaQA DATETIME;');
END
GO
-- RENAME Column ProjectTaskExpectedOne +> ProjectTaskDuKienThoQuaTinh
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskExpectedOne' )
BEGIN EXEC sp_rename 'PM_ProjectTask.ProjectTaskExpectedOne', 'ProjectTaskDuKienThoQuaTinh', 'COLUMN'
	PRINT ('RENAME Column ProjectTaskExpectedOne +> ProjectTaskDuKienThoQuaTinh;');
END
GO
-- RENAME Column ProjectTaskExpectedTwo +> ProjectTaskThucTeTinhQuaQA
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskExpectedTwo' )
BEGIN EXEC sp_rename 'PM_ProjectTask.ProjectTaskExpectedTwo', 'ProjectTaskDuKienTinhQuaQA', 'COLUMN'
	PRINT ('RENAME Column ProjectTaskExpectedTwo +> ProjectTaskDuKienTinhQuaQA;');
END
GO
-- Add Column ProjectTaskDuKienXuatHang DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskDuKienXuatHang' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD ProjectTaskDuKienXuatHang DATETIME;
	PRINT ('ADD ProjectTaskDuKienXuatHang DATETIME;');
END
GO
-- Add Column ProjectTaskThucTeXuatHang DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskThucTeXuatHang' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD ProjectTaskThucTeXuatHang DATETIME;
	PRINT ('ADD ProjectTaskThucTeXuatHang DATETIME;');
END
-- Add Column ProcessNotes NVARCHAR (255)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'ProcessNotes' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD ProcessNotes NVARCHAR (255);
	PRINT ('ADD ProcessNotes NVARCHAR (255);');
END
 

 