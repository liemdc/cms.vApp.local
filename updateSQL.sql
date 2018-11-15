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
-- 20181101
-- Add Column DXGioBatDauDuKien DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioBatDauDuKien' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXGioBatDauDuKien DATETIME;
	PRINT ('ADD DXGioBatDauDuKien DATETIME;');
END
-- Add Column DXGioKetThucDuKien DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioKetThucDuKien' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXGioKetThucDuKien DATETIME;
	PRINT ('ADD DXGioKetThucDuKien DATETIME;');
END
-- Add Column DXMaSanPhamUuTienGiaCong NVARCHAR (50)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXMaSanPhamUuTienGiaCong' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXMaSanPhamUuTienGiaCong NVARCHAR (50);
	PRINT ('ADD DXMaSanPhamUuTienGiaCong NVARCHAR (50);');
END
-- Add Column DXThoiGianDieuChinh numeric(10, 2)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXThoiGianDieuChinh' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXThoiGianDieuChinh numeric(10, 2);
	PRINT ('ADD DXThoiGianDieuChinh numeric(10, 2);');
END
-- Add Column DXGioNhanThucTe DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioNhanThucTe' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXGioNhanThucTe DATETIME;
	PRINT ('ADD DXGioNhanThucTe DATETIME;');
END
-- Add Column DXGioBatDauThucTe DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioBatDauThucTe' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXGioBatDauThucTe DATETIME;
	PRINT ('ADD DXGioBatDauThucTe DATETIME;');
END
-- Add Column DXGioKetThucThucTe DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioKetThucThucTe' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXGioKetThucThucTe DATETIME;
	PRINT ('ADD DXGioKetThucThucTe DATETIME;');
END
-- Add Column DXChuyenQuaCongDoan INT
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXChuyenQuaCongDoan' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXChuyenQuaCongDoan INT;
	PRINT ('ADD DXChuyenQuaCongDoan INT;');
END
-- 20181107
-- RENAME Column DXGioNhanThucTe +> DXNgayNhanThucTe
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioNhanThucTe' )
BEGIN EXEC sp_rename 'PM_ProjectProcess.DXGioNhanThucTe', 'DXNgayNhanThucTe', 'COLUMN'
	PRINT ('RENAME Column DXGioNhanThucTe +> DXNgayNhanThucTe;');
END
-- 20181114
-- Add Column EmployeeStatus NVARCHAR (25)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectEmployee') AND name = 'EmployeeStatus' )
BEGIN ALTER TABLE PM_ProjectEmployee
	ADD EmployeeStatus NVARCHAR (25);
	PRINT ('ADD EmployeeStatus NVARCHAR (25);');
END
-- 20181115
-- Add Column ProcessListStatus NVARCHAR (25)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcessList') AND name = 'ProcessListStatus' )
BEGIN ALTER TABLE PM_ProjectProcessList
	ADD ProcessListStatus NVARCHAR (25);
	PRINT ('ADD ProcessListStatus NVARCHAR (25);');
END
UPDATE PM_ProjectProcessList SET ProcessListStatus = 'Enable'



 

 