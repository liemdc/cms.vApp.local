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
-- 20181120
-- Add Column DXNhanDuKien BIT
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcessList') AND name = 'DXNhanDuKien' )
BEGIN ALTER TABLE PM_ProjectProcessList
	ADD DXNhanDuKien BIT;
	PRINT ('ADD DXNhanDuKien BIT;');
END
UPDATE PM_ProjectProcessList SET DXNhanDuKien = 0
-- RENAME Column DXGioBatDauDuKien +> DXNgayNhanDuKien
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioBatDauDuKien' )
BEGIN EXEC sp_rename 'PM_ProjectProcess.DXGioBatDauDuKien', 'DXNgayNhanDuKien', 'COLUMN'
	PRINT ('RENAME Column DXGioBatDauDuKien +> DXNgayNhanDuKien;');
END
-- 20181217
-- RENAME Column DXGioKetThucDuKien +> DXNgayBatDauDuKien
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXGioKetThucDuKien' )
BEGIN EXEC sp_rename 'PM_ProjectProcess.DXGioKetThucDuKien', 'DXNgayBatDauDuKien', 'COLUMN'
	PRINT ('RENAME Column DXGioKetThucDuKien +> DXNgayBatDauDuKien;');
END
-- 20190224
CREATE VIEW TimeCongDoan AS
SELECT DISTINCT
	pt.ProjectTaskID, 
	ps1.DXNgayKetThucDuKien AS PhayMCDK, 
	ps1.ProcessCompletion AS PhayMCHT,
	--ps2.DXNgayKetThucDuKien AS Ex2, 
	--ps2.ProcessCompletion AS Co2,
	ps3.DXNgayKetThucDuKien AS PhayTayDK,
	ps3.ProcessCompletion AS PhayTayHT,
	ps4.DXNgayKetThucDuKien AS BoPhanQADK,
	ps4.ProcessCompletion AS BoPhanQAHT,
	--ps5.ProcessExpectedCompletion AS Ex5,
	--ps5.ProcessCompletion AS Co5,
	ps6.DXNgayKetThucDuKien AS EDMDK,
	ps6.ProcessCompletion AS EDMHT,
	ps7.DXNgayKetThucDuKien AS WEDMDK,
	ps7.ProcessCompletion AS WEDMHT,
	ps8.DXNgayKetThucDuKien AS TienNCDK,
	ps8.ProcessCompletion AS TienNCHT,
	ps9.DXNgayKetThucDuKien AS NhietLuyenDK,
	ps9.ProcessCompletion AS NhietLuyenHT,
	--ps10.ProcessExpectedCompletion AS Ex10,
	--ps10.ProcessCompletion AS Co10,
	--ps11.ProcessExpectedCompletion AS Ex11,
	--ps11.ProcessCompletion AS Co11,
	--ps12.ProcessExpectedCompletion AS Ex12,
	--ps12.ProcessCompletion AS Co12,
	--ps13.ProcessExpectedCompletion AS Ex13,
	--ps13.ProcessCompletion AS Co13,
	--ps14.ProcessExpectedCompletion AS Ex14,
	--ps14.ProcessCompletion AS Co14,
	ps15.DXNgayKetThucDuKien AS MaiBongVaLapRapDK,
	ps15.ProcessCompletion AS MaiBongVaLapRapHT,
	ps16.DXNgayKetThucDuKien AS TienTinhNCDK,
	ps16.ProcessCompletion AS TienTinhNCHT,
	--ps17.ProcessExpectedCompletion AS Ex17,
	--ps17.ProcessCompletion AS Co17,
	--ps18.ProcessExpectedCompletion AS Ex18,
	--ps18.ProcessCompletion AS Co18,
	ps19.DXNgayKetThucDuKien AS MaiPhangKhuonDapDK,
	ps19.ProcessCompletion AS MaiPhangKhuonDapHT
	--ps20.ProcessExpectedCompletion AS Ex20,
	--ps20.ProcessCompletion AS Co20
FROM PM_ProjectTask pt
LEFT JOIN PM_ProjectProcess ps1
ON pt.ProjectTaskID = ps1.ProcessProjectTaskID and ps1.ProcessListId = 74
--LEFT JOIN PM_ProjectProcess ps2
--ON pt.ProjectTaskID = ps2.ProcessProjectTaskID and ps2.ProcessListId = 75
LEFT JOIN PM_ProjectProcess ps3
ON pt.ProjectTaskID = ps3.ProcessProjectTaskID and ps3.ProcessListId = 76
LEFT JOIN PM_ProjectProcess ps4
ON pt.ProjectTaskID = ps4.ProcessProjectTaskID and ps4.ProcessListId = 77
--LEFT JOIN PM_ProjectProcess ps5
--ON pt.ProjectTaskID = ps5.ProcessProjectTaskID and ps5.ProcessListId = 81
LEFT JOIN PM_ProjectProcess ps6
ON pt.ProjectTaskID = ps6.ProcessProjectTaskID and ps6.ProcessListId = 82
LEFT JOIN PM_ProjectProcess ps7
ON pt.ProjectTaskID = ps7.ProcessProjectTaskID and ps7.ProcessListId = 83
LEFT JOIN PM_ProjectProcess ps8
ON pt.ProjectTaskID = ps8.ProcessProjectTaskID and ps8.ProcessListId = 85
LEFT JOIN PM_ProjectProcess ps9
ON pt.ProjectTaskID = ps9.ProcessProjectTaskID and ps9.ProcessListId = 91
--LEFT JOIN PM_ProjectProcess ps10
--ON pt.ProjectTaskID = ps10.ProcessProjectTaskID and ps10.ProcessListId = 94
--LEFT JOIN PM_ProjectProcess ps11
--ON pt.ProjectTaskID = ps11.ProcessProjectTaskID and ps11.ProcessListId = 95
--LEFT JOIN PM_ProjectProcess ps12
--ON pt.ProjectTaskID = ps12.ProcessProjectTaskID and ps12.ProcessListId = 96
--LEFT JOIN PM_ProjectProcess ps13
--ON pt.ProjectTaskID = ps13.ProcessProjectTaskID and ps13.ProcessListId = 97
--LEFT JOIN PM_ProjectProcess ps14
--ON pt.ProjectTaskID = ps14.ProcessProjectTaskID and ps14.ProcessListId = 98
LEFT JOIN PM_ProjectProcess ps15
ON pt.ProjectTaskID = ps15.ProcessProjectTaskID and ps15.ProcessListId = 100
LEFT JOIN PM_ProjectProcess ps16
ON pt.ProjectTaskID = ps16.ProcessProjectTaskID and ps16.ProcessListId = 101
--LEFT JOIN PM_ProjectProcess ps17
--ON pt.ProjectTaskID = ps17.ProcessProjectTaskID and ps17.ProcessListId = 102
--LEFT JOIN PM_ProjectProcess ps18
--ON pt.ProjectTaskID = ps18.ProcessProjectTaskID and ps18.ProcessListId = 103
LEFT JOIN PM_ProjectProcess ps19
ON pt.ProjectTaskID = ps19.ProcessProjectTaskID and ps19.ProcessListId = 108
--LEFT JOIN PM_ProjectProcess ps20
--ON pt.ProjectTaskID = ps20.ProcessProjectTaskID and ps20.ProcessListId = 111


-- Add Column DXNgayKetThucDuKien DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectProcess') AND name = 'DXNgayKetThucDuKien' )
BEGIN ALTER TABLE PM_ProjectProcess
	ADD DXNgayKetThucDuKien DATETIME;
	PRINT ('ADD DXNgayKetThucDuKien DATETIME;');
END






--- ///
-- Add Column DX_DuKienHT_NC DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_NC' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_NC DATETIME;
	PRINT ('ADD DX_DuKienHT_NC DATETIME;');
END
GO
-- Add Column DX_DuKienHT_MC DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_MC' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_MC DATETIME;
	PRINT ('ADD DX_DuKienHT_MC DATETIME;');
END
GO
-- Add Column DX_DuKienHT_PhayTay DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_PhayTay' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_PhayTay DATETIME;
	PRINT ('ADD DX_DuKienHT_PhayTay DATETIME;');
END
GO
-- Add Column DX_DuKienHT_Nhiet DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_Nhiet' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_Nhiet DATETIME;
	PRINT ('ADD DX_DuKienHT_Nhiet DATETIME;');
END
GO
-- Add Column DX_DuKienHT_Mai DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_Mai' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_Mai DATETIME;
	PRINT ('ADD DX_DuKienHT_Mai DATETIME;');
END
GO
-- Add Column DX_DuKienHT_WEDM DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_WEDM' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_WEDM DATETIME;
	PRINT ('ADD DX_DuKienHT_WEDM DATETIME;');
END
GO
-- Add Column DX_DuKienHT_EDM DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_EDM' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_EDM DATETIME;
	PRINT ('ADD DX_DuKienHT_EDM DATETIME;');
END
GO
-- Add Column DX_DuKienHT_QA DATETIME
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_DuKienHT_QA' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_DuKienHT_QA DATETIME;
	PRINT ('ADD DX_DuKienHT_QA DATETIME;');
END
GO
-- Add Column DX_MaDonHang NVARCHAR(12)
IF NOT EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'DX_MaDonHang' )
BEGIN ALTER TABLE PM_ProjectTask
	ADD DX_MaDonHang NVARCHAR(12);
	PRINT ('ADD DX_MaDonHang NVARCHAR(12);');
END
GO
-- RENAME Column ProjectTaskDuKienXuatHang +> DX_XuatHang_DuKien
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskDuKienXuatHang' )
BEGIN EXEC sp_rename 'PM_ProjectTask.ProjectTaskDuKienXuatHang', 'DX_XuatHang_DuKien', 'COLUMN'
	PRINT ('RENAME Column ProjectTaskDuKienXuatHang +> DX_XuatHang_DuKien;');
END
GO
-- RENAME Column ProjectTaskThucTeXuatHang +> DX_XuatHang_ThucTe
IF EXISTS ( SELECT object_id FROM sys.columns WHERE object_id = OBJECT_ID(N'PM_ProjectTask') AND name = 'ProjectTaskThucTeXuatHang' )
BEGIN EXEC sp_rename 'PM_ProjectTask.ProjectTaskThucTeXuatHang', 'DX_XuatHang_ThucTe', 'COLUMN'
	PRINT ('RENAME Column ProjectTaskThucTeXuatHang +> DX_XuatHang_ThucTe;');
END
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskDuKienThoQuaTinh;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskDuKienTinhQuaQA;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskThucTeThoQuaTinh;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskThucTeTinhQuaQA;
-----
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskBottoHob;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskChildNote;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskContainHead;
GO
ALTER TABLE PM_ProjectTask
DROP COLUMN ProjectTaskPrice;