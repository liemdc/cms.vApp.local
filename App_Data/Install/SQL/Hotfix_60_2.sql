/********************* INSERT RESOURCE STRINGS ***********************/
DECLARE @stringId AS int;
DECLARE @cultureId AS int;
DECLARE @cultureCode AS nvarchar(50);

-- Change value of this parameter if your default UI culture is not 'en-US' (see details in hotfix instructions)
SET @cultureCode = 'en-US';

-- Get culture ID
SET @cultureID = (SELECT UICultureID FROM [CMS_UICulture] WHERE UICultureCode=@cultureCode);

-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'activityitemdetail.blogcomment' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('activityitemdetail.blogcomment'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'Blog')
END

-- MVT tests
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'analytics_codename.mvtest' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('analytics_codename.mvtest'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'MVT tests')
END

-- Dashborad no template
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'dashboard.notemplate' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('dashboard.notemplate'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'Page template for this dashboard was not found.')
END


-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'activityitemdetail.blogpostsubscription' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('activityitemdetail.blogpostsubscription'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'Blog')
END

-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'objecttype.om_membershipuser' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('objecttype.om_membershipuser'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'User membership')
END

-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'validation.link.resultinvalidwarning' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('validation.link.resultinvalidwarning'
           ,0
           ,0)

SET @stringId = scope_identity();

-- Insert translation
INSERT INTO [CMS_ResourceTranslation]
           ([TranslationStringID]
           ,[TranslationUICultureID]
           ,[TranslationText])
     VALUES
           (@stringId
           ,@cultureId
           ,'The following links may require your attention.')
END

GO

/*********************  END INSERT RESOURCE STRINGS ***********************/


/********************* UPDATE VIEWS ***********************/
-- Declare helper variables
DECLARE @definition NVARCHAR(MAX);
DECLARE @viewName NVARCHAR(128);
-- Declare cursor
DECLARE updateViewCursor CURSOR FAST_FORWARD FOR 
-- Select all corrupted views
SELECT [TABLE_NAME]	FROM [INFORMATION_SCHEMA].[VIEWS] WHERE [TABLE_NAME] IN (
	'View_PageInfo_Blank',
	'View_Forums_GroupForumPost_Joined',
	'View_CMS_EventLog_Joined',
	'View_Document_Attachment',
	'View_CMS_Tree_Joined_Attachments',
	'View_CMS_Tree_Joined_Versions_Attachments',
	'View_CMS_ACLItem_ItemsAndOperators',
	'View_CMS_WidgetCategoryWidget_Joined',
	'View_CMS_WebPartCategoryWebpart_Joined',
	'View_CMS_WidgetMetafile_Joined',
	'View_CMS_SiteRoleResourceUIElement_Joined',
	'View_CMS_PageTemplateMetafile_Joined',
	'View_CMS_PageTemplateCategoryPageTemplate_Joined',
	'View_CMS_LayoutMetafile_Joined',
	'View_CMS_ResourceTranslated_Joined',
	'View_BookingSystem_Joined',
	'View_Boards_BoardMessage_Joined',
	'View_Community_Friend_RequestedFriends',
	'View_Community_Friend_Friends',
	'View_Poll_AnswerCount',
	'View_CMS_Site_DocumentCount',
	'View_CMS_RoleResourcePermission_Joined',
	'View_PM_ProjectStatus_Joined',
	'View_PM_ProjectTaskStatus_Joined',
	'View_OM_Account_Joined',
	'View_OM_AccountContact_ContactJoined',
	'View_OM_AccountContact_AccountJoined',
	'View_Integration_Task_Joined',
	'View_OM_ContactGroupMember_ContactJoined',
	'View_OM_ContactGroupMember_AccountJoined',
	'View_CMS_DocumentAlias_Joined'
	);

OPEN updateViewCursor 

FETCH NEXT FROM updateViewCursor INTO @viewName
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Get view definition
	SELECT @definition = COALESCE(@definition,'') + TEXT FROM sys.syscomments WHERE OBJECT_NAME(id) = @viewName;
	-- Change CREATE to ALTER
	SET @definition = REPLACE(@definition, 'CREATE VIEW', 'ALTER VIEW');
	-- Remove dbo schema
	SET @definition = REPLACE(@definition, '[dbo].', '');
	SET @definition = REPLACE(@definition, 'dbo.', '');
	
	-- Refresh view
	EXEC (@definition);
	-- Reset view definition
	SET @definition = '';
	-- Continue with next view
	FETCH NEXT FROM updateViewCursor INTO @viewName
END

CLOSE updateViewCursor 
DEALLOCATE updateViewCursor 
/********************* END UPDATE VIEWS ***********************/


UPDATE CMS_Query
SET QueryText = 
'SELECT ActiveContactID AS ContactID FROM OM_Membership m WHERE m.RelatedID=@RelatedID AND m.MemberType=@MemberType AND EXISTS(SELECT ContactID FROM OM_Contact WHERE ContactID=m.ActiveContactID AND ContactSiteID=@SiteID AND ##WHERE##) ORDER BY ActiveContactID' 
WHERE QueryName = N'selectbyrelatedidandtype' AND ClassID = (SELECT ClassID FROM CMS_Class WHERE ClassName=N'OM.Membership')
GO


/********************* UPDATE CONTACT MANAGEMENT ***********************/

UPDATE OM_ActivityType SET [ActivityTypeDetailFormControl]='selectdocument' WHERE ActivityTypeName='blogpostsubscription' AND ActivityTypeDetailFormControl IS NULL
UPDATE OM_ActivityType SET [ActivityTypeDetailFormControl]='selectdocument' WHERE ActivityTypeName='blogcomment' AND ActivityTypeDetailFormControl IS NULL

/********************* END UPDATE CONTACT MANAGEMENT ***********************/


/********************* UPDATE MVT ***********************/
UPDATE CMS_Query
   SET QueryText = 'IF (@MVTVariantDocumentID = 0)
BEGIN
  SET @MVTVariantDocumentID = NULL;
END
   
SELECT *
FROM OM_MVTCombination
WHERE
  (MVTCombinationPageTemplateID = @MVTCombinationPageTemplateID)
  AND 
  ((MVTCombinationDocumentID IS NULL) OR (MVTCombinationDocumentID = COALESCE(@MVTVariantDocumentID, MVTCombinationDocumentID)))
  AND 
  MVTCombinationID NOT IN
  (
    SELECT MVTCombinationID
    FROM OM_MVTCombinationVariation
    WHERE
      MVTVariantID IN
      (
        SELECT MVTVariantID
        FROM OM_MVTVariant
        WHERE
          MVTVariantInstanceGUID = @MVTVariantInstanceGUID
      )
  )'
 WHERE QueryName = 'GetCombinationsWithoutWebpart';

UPDATE CMS_Query
   SET QueryText = 'IF (@MVTVariantDocumentID = 0)
BEGIN
  SET @MVTVariantDocumentID = NULL;
END
   
SELECT *
FROM OM_MVTCombination
WHERE
  (MVTCombinationPageTemplateID = @MVTCombinationPageTemplateID)
  AND
  ((MVTCombinationDocumentID IS NULL) OR (MVTCombinationDocumentID = COALESCE(@MVTVariantDocumentID, MVTCombinationDocumentID)))
  AND
  MVTCombinationID NOT IN
  (
    SELECT MVTCombinationID
    FROM OM_MVTCombinationVariation
    WHERE
      MVTVariantID IN
      (
        SELECT MVTVariantID
        FROM OM_MVTVariant
        WHERE
          (MVTVariantZoneID = @MVTVariantZoneID) AND
          (MVTVariantPageTemplateID= @MVTCombinationPageTemplateID)
      )
  )'
 WHERE QueryName = 'GetCombinationsWithoutZone'; 

/********************* END UPDATE MVT ***********************/


/****** UPDATE DELETE WEB ANALYTICS FUNCTION ****************/

UPDATE CMS_Query SET QueryText = 
'
    DECLARE @Year1Start datetime;
    DECLARE @Year1End datetime;
    DECLARE @Year2Start datetime;
    DECLARE @Year2End datetime;
    
    DECLARE @Week1Start datetime;
    DECLARE @Week1End datetime;
    DECLARE @Week2Start datetime;
    DECLARE @Week2End datetime;
    
    DECLARE @Month1Start datetime;
    DECLARE @Month1End datetime;
    DECLARE @Month2Start datetime;
    DECLARE @Month2End datetime;
    		
	-- Trim years
	SET @Year1Start = dbo.Func_Analytics_DateTrim (@From ,''year'');
	SET @Year1End = dbo.Func_Analytics_EndDateTrim (@From ,''year'');
	SET @Year2Start = dbo.Func_Analytics_DateTrim (@To ,''year'');
	SET @Year2End = dbo.Func_Analytics_EndDateTrim (@To ,''year'');	
	
	-- Trim months
	SET @Month1Start = dbo.Func_Analytics_DateTrim (@From ,''month'');
	SET @Month1End = dbo.Func_Analytics_EndDateTrim (@From ,''month'');
	SET @Month2Start = dbo.Func_Analytics_DateTrim (@To ,''month'');
	SET @Month2End = dbo.Func_Analytics_EndDateTrim (@To ,''month'');	
	
	-- Trim week
	SET @Week1Start = dbo.Func_Analytics_DateTrim (@From ,''week'');
	SET @Week1End = dbo.Func_Analytics_EndDateTrim (@From ,''week'');
	SET @Week2Start = dbo.Func_Analytics_DateTrim (@To ,''week'');
	SET @Week2End = dbo.Func_Analytics_EndDateTrim (@To ,''week'');	


SET NOCOUNT ON;
	DECLARE @HitsStatID int;
	DECLARE @Cnt int;
	DECLARE @CntL int;
	DECLARE @CntM int;
	DECLARE @CntR int;
	DECLARE @hitsID int;
	DECLARE @hitsCount int;
	DECLARE mycursor CURSOR FOR SELECT HitsStatisticsID FROM Analytics_Statistics, Analytics_DayHits
		  WHERE StatisticsSiteID=@SiteID AND  ##WHERE## AND
		  StatisticsID=HitsStatisticsID AND HitsStartTime >= @From AND
		  @To >= HitsEndTime
	OPEN mycursor;
	FETCH NEXT FROM mycursor INTO @HitsStatID
	WHILE @@FETCH_STATUS = 0
	BEGIN

-- WEEKS
    IF (@Week1End < @To)
    BEGIN
        SET @CntL = 0;
		SELECT @CntL = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE## AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @Week1End >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week1Start AND HitsEndTime<=@Week1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Week2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE## AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Week2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week2Start AND HitsEndTime<=@Week2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Week1Start <= @From AND @To <= @Week1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week1Start AND HitsEndTime<=@Week1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntM) WHERE HitsID=@hitsID;
		END;
    END;
-- MONTHS
    IF (@Month1End < @To)
    BEGIN
        SET @CntL = 0;
		SELECT @CntL = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @Month1End >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month1Start AND HitsEndTime<=@Month1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Month2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Month2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month2Start AND HitsEndTime<=@Month2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Month1Start <= @From AND @To <= @Month1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month1Start AND HitsEndTime<=@Month1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntM) WHERE HitsID=@hitsID;
		END;
    END;
-- YEARS
    IF (@Year1End < @To)
    BEGIN
        SET @CntL = 0;
		SELECT @CntL = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @Year1End >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year1Start AND HitsEndTime<=@Year1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Year2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Year2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year2Start AND HitsEndTime<=@Year2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Year1Start <= @From AND @To <= @Year1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year1Start AND HitsEndTime<=@Year1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntM) WHERE HitsID=@hitsID;
		END;
    END;
	    DELETE FROM [Analytics_HourHits] WHERE 
	      HitsStatisticsID=@HitsStatID AND HitsStartTime>=@From AND HitsEndTime<=@To;
	    DELETE FROM [Analytics_DayHits] WHERE 
	      HitsStatisticsID=@HitsStatID AND HitsStartTime>=@From AND HitsEndTime<=@To;
	    IF (@From <= @Week1End AND @Week2Start <= @To)
	    BEGIN
	    DELETE FROM [Analytics_WeekHits] WHERE 
	      HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week1End AND HitsEndTime<=@Week2Start;
	    END;
	    IF (@From <= @Month1End AND @Month2Start <= @To)
	    BEGIN
	    DELETE FROM [Analytics_MonthHits] WHERE 
	      HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month1End AND HitsEndTime<=@Month2Start;
	    END;    
	    IF (@From <= @Year1End AND @Year2Start <= @To)
	    BEGIN
	    DELETE FROM [Analytics_YearHits] WHERE 
	      HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year1End AND HitsEndTime<=@Year2Start;
	    END;    
		FETCH NEXT FROM mycursor INTO @HitsStatID
      END
	DEALLOCATE mycursor;
	-- Delete zero stats
	DELETE FROM [Analytics_HourHits] WHERE HitsCount <= 0
	DELETE FROM [Analytics_DayHits] WHERE HitsCount <= 0
	DELETE FROM [Analytics_MonthHits] WHERE HitsCount <= 0
	DELETE FROM [Analytics_WeekHits] WHERE HitsCount <= 0
	DELETE FROM [Analytics_YearHits] WHERE HitsCount <= 0
	DECLARE @stat TABLE (
	  StatisticsID int
	)
	-- Get stats ID with no stats
	INSERT INTO @stat SELECT StatisticsID FROM (
	(SELECT StatisticsID FROM [Analytics_Statistics] WHERE StatisticsID NOT IN (SELECT HitsStatisticsID FROM [Analytics_HourHits])) UNION
	(SELECT StatisticsID FROM [Analytics_Statistics] WHERE StatisticsID NOT IN (SELECT HitsStatisticsID FROM [Analytics_DayHits])) UNION
	(SELECT StatisticsID FROM [Analytics_Statistics] WHERE StatisticsID NOT IN (SELECT HitsStatisticsID FROM [Analytics_WeekHits])) UNION
	(SELECT StatisticsID FROM [Analytics_Statistics] WHERE StatisticsID NOT IN (SELECT HitsStatisticsID FROM [Analytics_MonthHits])) UNION
	(SELECT StatisticsID FROM [Analytics_Statistics] WHERE StatisticsID NOT IN (SELECT HitsStatisticsID FROM [Analytics_YearHits]))
	) as tab
	-- Remove dependencies
	DELETE FROM [Analytics_HourHits] WHERE HitsStatisticsID IN (SELECT StatisticsID FROM @stat)
	DELETE FROM [Analytics_DayHits] WHERE HitsStatisticsID IN (SELECT StatisticsID FROM @stat)
	DELETE FROM [Analytics_WeekHits] WHERE HitsStatisticsID IN (SELECT StatisticsID FROM @stat)
	DELETE FROM [Analytics_MonthHits] WHERE HitsStatisticsID IN (SELECT StatisticsID FROM @stat)
	DELETE FROM [Analytics_YearHits] WHERE HitsStatisticsID IN (SELECT StatisticsID FROM @stat)
	-- Remove master record
	DELETE FROM [Analytics_Statistics] WHERE StatisticsID IN (SELECT StatisticsID FROM @stat)

'

WHERE QueryNAme = 'removeanalyticsdata'
  AND ClassID IN (SELECT TOP 1 ClassID FROM CMS_Class WHERE ClassName ='analytics.statistics')

/******** END UPDATE DELETE WEB ANALYTICS FUNCTION ******/

/******** BEGIN UPDATE POLLS ******/

UPDATE CMS_Query SET [QueryText]='SELECT * FROM Polls_Poll WHERE (PollID IN (SELECT PollID FROM Polls_PollSite WHERE SiteID=@SiteID) OR PollID IN (SELECT PollID FROM Polls_Poll WHERE PollSiteID=@SiteID)) ORDER BY ##ORDERBY##'
WHERE ClassID IN (SELECT ClassID FROM CMS_Class WHERE ClassName LIKE 'polls.poll') AND QueryName='selectallofsite'

/******** END UPDATE POLLS ******/

/* ----------------------------------------------------------------------------*/
/* This SQL command must be at the end and must contain current hotfix version */
/* ----------------------------------------------------------------------------*/
UPDATE [CMS_SettingsKey] SET KeyValue = '2' WHERE KeyName = N'CMSHotfixVersion'
GO
