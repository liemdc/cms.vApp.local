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

-- Tools - web analytics - visitors
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'tools.ui.webanalyticsviewvisits' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('tools.ui.webanalyticsviewvisits'
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
           ,'View statistics of visitors')
END

-- Hier. footer
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'hiertransf.footer' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('hiertransf.footer'
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
           ,'Footer transformation')
END


-- Hier. footer
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'hiertransf.header' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('hiertransf.header'
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
           ,'Header transformation')
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

-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'analyt.settings.deleterinprogress' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('analyt.settings.deleterinprogress'
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
           ,'Deletion of data is in progress.')
END

-- Check if resource string exists
SET @stringId = (SELECT StringID FROM [CMS_ResourceString] LEFT JOIN [CMS_ResourceTranslation] ON StringID=TranslationStringID WHERE StringKey = N'importobjects.selectallconfirm' AND TranslationUICultureID = @cultureID);
IF  @stringId IS NULL
BEGIN
-- Insert resource string
INSERT INTO [CMS_ResourceString]
           ([StringKey]
           ,[StringIsCustom]
           ,[StringLoadGeneration])
     VALUES
           ('importobjects.selectallconfirm'
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
           ,'Are you sure you want to select all objects? Definitions of objects, such as Inline controls, Form controls, Web parts, Widgets and others, as well as files belonging to these objects, will be overwritten. You can lose your custom changes made to these objects.')
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


/********************* UPDATE CONTACT MANAGEMENT ***********************/

UPDATE CMS_Query
SET QueryText = 
'SELECT ActiveContactID AS ContactID FROM OM_Membership m WHERE m.RelatedID=@RelatedID AND m.MemberType=@MemberType AND EXISTS(SELECT ContactID FROM OM_Contact WHERE ContactID=m.ActiveContactID AND ContactSiteID=@SiteID AND ##WHERE##) ORDER BY ActiveContactID' 
WHERE QueryName = N'selectbyrelatedidandtype' AND ClassID = (SELECT ClassID FROM CMS_Class WHERE ClassName=N'OM.Membership')
GO

UPDATE CMS_Query
SET QueryText = 
'SELECT ##TOPN## ##COLUMNS## FROM (
SELECT ContactID, MembershipID, ActiveContactID, OriginalContactID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerCompany, 
ContactMergedWithContactID, OM_Contact.ContactSiteID,
ISNULL(OM_Contact.ContactFirstName,'''') +
CASE OM_Contact.ContactFirstName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactMiddleName,'''') +
CASE OM_Contact.ContactMiddleName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactLastName, '''') AS ContactFullNameJoined
FROM OM_Membership
	INNER JOIN OM_Contact ON OM_Membership.OriginalContactID=OM_Contact.ContactID
	INNER JOIN COM_Customer ON OM_Membership.RelatedID=COM_Customer.CustomerID
WHERE ActiveContactID=@ContactID AND MemberType=1) as tab
WHERE ##WHERE## ORDER BY ##ORDERBY##' 
WHERE QueryName = N'selectcustomers' AND ClassID = (SELECT ClassID FROM CMS_Class WHERE ClassName=N'OM.Membership')
GO

UPDATE CMS_Query
SET QueryText = 
'SELECT ##TOPN## ##COLUMNS## FROM (
SELECT ContactID, MembershipID, ActiveContactID, OriginalContactID, ContactMergedWithContactID, CustomerCompany, 
CustomerFirstName, CustomerLastName, CustomerEmail, OM_Contact.ContactSiteID,
ISNULL(OM_Contact.ContactFirstName,'''') +
CASE OM_Contact.ContactFirstName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactMiddleName,'''') +
CASE OM_Contact.ContactMiddleName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactLastName, '''') AS ContactFullNameJoined
FROM OM_Membership
INNER JOIN OM_Contact ON OM_Membership.OriginalContactID=OM_Contact.ContactID
INNER JOIN COM_Customer ON OM_Membership.RelatedID=COM_Customer.CustomerID
WHERE MemberType=1 AND OriginalContactID IN (SELECT * FROM Func_OM_Contact_GetChildren(@ContactID, 1))) as tab
WHERE ##WHERE## ORDER BY ##ORDERBY##' 
WHERE QueryName = N'selectmergedcustomers' AND ClassID = (SELECT ClassID FROM CMS_Class WHERE ClassName=N'OM.Membership')
GO

UPDATE CMS_Query
SET QueryText = 
'SELECT ##TOPN## ##COLUMNS## FROM (
SELECT ContactID, MembershipID, ActiveContactID, OriginalContactID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerCompany,
ContactMergedWithContactID, OM_Contact.ContactSiteID, ISNULL(OM_Contact.ContactFirstName,'''') +
CASE OM_Contact.ContactFirstName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactMiddleName,'''') +
CASE OM_Contact.ContactMiddleName
  WHEN '''' THEN ''''
  WHEN NULL THEN ''''
  ELSE '' ''
END
+ ISNULL(OM_Contact.ContactLastName, '''') AS ContactFullNameJoined
FROM OM_Membership
INNER JOIN OM_Contact ON OM_Membership.OriginalContactID=OM_Contact.ContactID
INNER JOIN COM_Customer ON OM_Membership.RelatedID=COM_Customer.CustomerID
WHERE ContactID IN (SELECT * FROM Func_OM_Contact_GetChildren_Global(@ContactID, 1)) AND MemberType=1) as tab
WHERE ##WHERE## ORDER BY ##ORDERBY##' 
WHERE QueryName = N'selectglobalcustomers' AND ClassID = (SELECT ClassID FROM CMS_Class WHERE ClassName=N'OM.Membership')
GO




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
	SET @Year1Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@From ,''year'');
	SET @Year1End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@From ,''year'');
	SET @Year2Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@To ,''year'');
	SET @Year2End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@To ,''year'');	
	
	-- Trim months
	SET @Month1Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@From ,''month'');
	SET @Month1End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@From ,''month'');
	SET @Month2Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@To ,''month'');
	SET @Month2End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@To ,''month'');	
	
	-- Trim week
	SET @Week1Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@From ,''week'');
	SET @Week1End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@From ,''week'');
	SET @Week2Start = {%DatabaseSchema%}.Func_Analytics_DateTrim (@To ,''week'');
	SET @Week2End = {%DatabaseSchema%}.Func_Analytics_EndDateTrim (@To ,''week'');	


SET NOCOUNT ON;
	DECLARE @HitsStatID int;
	DECLARE @Cnt int;
	DECLARE @CntL int;
	DECLARE @CntM int;
	DECLARE @CntR int;
       	DECLARE @ValL int;
	DECLARE @ValM int;
	DECLARE @ValR int;
	DECLARE @hitsID int;
	DECLARE @hitsCount int;
        DECLARE @hitsValue int;
	DECLARE mycursor CURSOR FOR SELECT HitsStatisticsID FROM Analytics_Statistics, Analytics_DayHits
		  WHERE (StatisticsSiteID=@SiteID OR @SiteID = 0) AND  ##WHERE## AND
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
		SELECT @CntL = SUM(HitsCount),@ValL = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE## AND StatisticsID=HitsStatisticsID AND
		              HitsStartTime >= @From AND @Week1End >= HitsEndTime AND StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week1Start AND HitsEndTime<=@Week1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntL), HitsValue=(@hitsValue-@ValL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Week2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount),@ValR = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE## AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Week2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week2Start AND HitsEndTime<=@Week2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntR),HitsValue=(@hitsValue-@ValR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Week1Start <= @From AND @To <= @Week1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount),@ValM = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue  FROM [Analytics_WeekHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Week1Start AND HitsEndTime<=@Week1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_WeekHits] SET HitsCount=(@hitsCount-@CntM),HitsValue=(@hitsValue-@ValM) WHERE HitsID=@hitsID;
		END;
    END;
-- MONTHS
    IF (@Month1End < @To)
    BEGIN
        SET @CntL = 0;
		SELECT @CntL = SUM(HitsCount),@ValL = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @Month1End >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month1Start AND HitsEndTime<=@Month1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntL),HitsValue=(@hitsValue-@ValL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Month2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount),@ValR = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Month2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month2Start AND HitsEndTime<=@Month2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntR),HitsValue=(@hitsValue-@ValR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Month1Start <= @From AND @To <= @Month1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount),@ValM = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_MonthHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Month1Start AND HitsEndTime<=@Month1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_MonthHits] SET HitsCount=(@hitsCount-@CntM),HitsValue=(@hitsValue-@ValM) WHERE HitsID=@hitsID;
		END;
    END;
-- YEARS
    IF (@Year1End < @To)
    BEGIN
        SET @CntL = 0;
		SELECT @CntL = SUM(HitsCount),@ValL = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @Year1End >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year1Start AND HitsEndTime<=@Year1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntL),HitsValue=(@hitsValue-@ValL) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Year2Start > @From)
    BEGIN
        SET @CntR = 0;
		SELECT @CntR = SUM(HitsCount),@ValR = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @Year2Start AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year2Start AND HitsEndTime<=@Year2End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntR),HitsValue=(@hitsValue-@ValR) WHERE HitsID=@hitsID;
		END;
    END
    IF (@Year1Start <= @From AND @To <= @Year1End)
    BEGIN
        SET @CntM = 0;
		SELECT @CntM = SUM(HitsCount),@ValM = SUM(HitsValue) FROM Analytics_Statistics, Analytics_DayHits
			  WHERE ##WHERE##  AND StatisticsID=HitsStatisticsID AND
              HitsStartTime >= @From AND @To >= HitsEndTime AND
              StatisticsID = @HitsStatID
		GROUP BY StatisticsID, StatisticsObjectName, StatisticsObjectID, StatisticsObjectCulture, HitsStatisticsID
		SET @hitsID = 0;
		SELECT @hitsID = HitsID, @hitsCount = HitsCount,@hitsValue = HitsValue FROM [Analytics_YearHits]
		WHERE HitsStatisticsID=@HitsStatID AND HitsStartTime>=@Year1Start AND HitsEndTime<=@Year1End;
		IF @hitsID > 0
		BEGIN
			UPDATE [Analytics_YearHits] SET HitsCount=(@hitsCount-@CntM),HitsValue=(@hitsValue-@ValM) WHERE HitsID=@hitsID;
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

/**** UPDATE TOOLS WEB ANALYTICS VISITORS LINK *****/

UPDATE [CMS_UIElement] 
SET ElementTargetURL = '~/CMSModules/WebAnalytics/Tools/default.aspx?node=visitfirst'
where elementname = 'WebAnalytics.ViewVisits'

/**** END UPDATE TOOLS WEB ANALYTICS VISITORS LINK *****/

/******** BEGIN UPDATE POLLS ******/

UPDATE CMS_Query SET [QueryText]='SELECT * FROM Polls_Poll WHERE (PollID IN (SELECT PollID FROM Polls_PollSite WHERE SiteID=@SiteID) OR PollID IN (SELECT PollID FROM Polls_Poll WHERE PollSiteID=@SiteID)) ORDER BY ##ORDERBY##'
WHERE ClassID IN (SELECT ClassID FROM CMS_Class WHERE ClassName LIKE 'polls.poll') AND QueryName='selectallofsite'

/******** END UPDATE POLLS ******/

/******** BEGIN UPDATE FORM CONTROLS ******/

DECLARE @resourceId AS int;

-- Get 'Community' resource ID
SET @resourceId = (SELECT ResourceID FROM [CMS_Resource] WHERE ResourceName = N'CMS.Community');
IF  @resourceId IS NOT NULL
BEGIN
-- Update form controls
UPDATE [CMS_FormUserControl] SET [UserControlResourceID]=@resourceId WHERE UserControlCodeName IN ('DepartmentSectionsManager', 'DepartmentRolesSelector')
END

GO

/******** END UPDATE FORM CONTROLS ******/


/****** UPDATE WRONG ORDER BY STATEMENT IN TABLE QUERIES *******/
UPDATE Reporting_ReportTable SET TableQuery = REPLACE (TableQuery,'ORDER BY ''{$om.total$}''','ORDER BY [{$om.total$}]')
WHERE TableQuery LIKE '%ORDER BY ''%'

UPDATE Reporting_ReportTable SET TableQuery = REPLACE (TableQuery,'ORDER BY ''{%ColumnName|(default)Hits%}''','ORDER BY [{%ColumnName|(default)Hits%}]')
WHERE TableQuery LIKE '%ORDER BY ''%'

/******* END UPDATE WRONG ORDER BY STATEMENT ********/

/****** UPDATE PROCEDURE FOR BACKWARD COMPATIBILITY OF UI ELEMENTS *******/


GO

ALTER PROCEDURE [Proc_CMS_UIElement_UpdateAfterImport] 
	@siteId INT,
	@packageVersion NVARCHAR(16),
	@topLevelElements bit
AS
BEGIN
	/* Declare the table of UI Elements */
	DECLARE @elementTable TABLE (
		ElementID INT NOT NULL,
		ElementParentID INT,
		ElementResourceID INT
	);

	/* Get UI elements newer than imported package */
	INSERT INTO @elementTable 
		SELECT ElementID, ElementParentID, ElementResourceID
		FROM CMS_UIElement 
		WHERE ElementFromVersion > @packageVersion AND ((@topLevelElements = 1 AND ElementLevel = 1) OR (@topLevelElements = 0 AND ElementLevel > 1))
		ORDER BY ElementLevel


	DECLARE @elementID INT; 
	DECLARE @elementParentID INT; 
	DECLARE @elementResourceID INT; 

	DECLARE @elementCursor CURSOR;
	SET @elementCursor = CURSOR FOR SELECT ElementID, ElementParentID, ElementResourceID FROM @elementTable

	OPEN @elementCursor
	FETCH NEXT FROM @elementCursor INTO @elementID, @elementParentID, @elementResourceID;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @elementID IS NOT NULL BEGIN
		
			DECLARE @readPermissionID int;
		
			/* Declare the selection table */
			DECLARE @rolesTable TABLE (
				RoleID INT NOT NULL
			);
			
			DELETE FROM @rolesTable;
			
			IF @topLevelElements = 1 BEGIN
				/* Get 'Read' permission ID for current element's resource */
				SET @readPermissionID = (SELECT [PermissionID] FROM CMS_Permission WHERE PermissionName = 'Read' AND ResourceID = @elementResourceID);
				
				/* When module does not have 'Read' permission */
				IF @readPermissionID IS NULL BEGIN
					/* Get the list of site roles */
					INSERT INTO @rolesTable SELECT RoleID FROM CMS_Role 
					WHERE SiteID = @siteId AND
						  RoleID NOT IN (SELECT RoleID FROM CMS_RoleUIElement WHERE ElementID = @elementID) AND
						  RoleName NOT IN ('cmsopenidusers', 'CMSFacebookUsers', 'CMSLiveIDUsers', '_everyone_', '_authenticated_', '_notauthenticated_')
				END
				ELSE BEGIN
					/* Get the list of site roles having 'Read' permission for element's resource and NOT having current element assigned */
					INSERT INTO @rolesTable SELECT RoleID FROM CMS_RolePermission
					WHERE RoleID IN (SELECT RoleID FROM CMS_Role WHERE SiteID = @siteId AND RoleName NOT IN ('cmsopenidusers', 'CMSFacebookUsers', 'CMSLiveIDUsers', '_everyone_', '_authenticated_', '_notauthenticated_')) AND
						  PermissionID = @readPermissionID AND
						  RoleID NOT IN (SELECT RoleID FROM CMS_RoleUIElement WHERE ElementID = @elementID) 
				END				
			END
			ELSE BEGIN
				/* Get the list of site roles having current element's parent assigned and NOT having CURRENT element assigned */
				INSERT INTO @rolesTable SELECT RoleID FROM CMS_RoleUIElement 
				WHERE RoleID IN (SELECT RoleID FROM CMS_Role WHERE SiteID = @siteId AND RoleName NOT IN ('cmsopenidusers', 'CMSFacebookUsers', 'CMSLiveIDUsers', '_everyone_', '_authenticated_', '_notauthenticated_')) AND
					  ElementID = @elementParentID AND
					  RoleID NOT IN (SELECT RoleID FROM CMS_RoleUIElement WHERE ElementID = @elementID)
			END
			
			/* Declare the cursor to loop through the roles */
			DECLARE @cursor CURSOR;
			SET @cursor = CURSOR FOR SELECT RoleID FROM @rolesTable;

			DECLARE @currentRoleID int;

			/* Loop through the table and assign elements to roles */
			OPEN @cursor
			FETCH NEXT FROM @cursor INTO @currentRoleID;
			WHILE @@FETCH_STATUS = 0
			BEGIN
				INSERT INTO CMS_RoleUIElement (RoleID, ElementID) VALUES (@currentRoleID, @elementID);
				FETCH NEXT FROM @cursor INTO @currentRoleID;
			END
			CLOSE @cursor;
			DEALLOCATE @cursor;
		END
		FETCH NEXT FROM @elementCursor INTO @elementID, @elementParentID, @elementResourceID;
	END
	CLOSE @elementCursor;
	DEALLOCATE @elementCursor; 
END

GO

/****** END PROCEDURE FOR BACKWARD COMPATIBILITY OF UI ELEMENTS *******/


/******** UPDATE WEB ANALYTICS REPORTS ******/

DECLARE @newDefaultSiteID varchar(100);
SET @newDefaultSiteID = '<field column="SiteID" visible="false" defaultvalue="{%CurrentSite.SiteID%}"';

UPDATE Reporting_Report
SET ReportParameters = REPLACE(
							REPLACE(
								ReportParameters,
								'<field column="SiteID" visible="false" columntype',
								@newDefaultSiteID + ' columntype'),
							'<field column="SiteID" visible="false" defaultvalue="0"',
							@newDefaultSiteID)
WHERE
	(ReportName IN (
		'campaigncompare.dayreport',
		'campaigncompare.hourreport',
		'campaigncompare.monthreport',
		'campaigncompare.weekreport',
		'campaigncompare.yearreport')
	)
	
GO

/******** END UPDATE WEB ANALYTICS REPORTS ******/

/******** BEGIN INSERT REMOVE ALL ANALYTICS DATA ********/

DECLARE @AnalyticsClassID INT;
DECLARE @RemoveAllID INT;
SELECT @AnalyticsClassID =  ClassID FROM CMS_Class WHERE ClassName = 'analytics.statistics'

SELECT @RemoveAllID = QueryID FROM CMS_Query WHERE ClassID = @AnalyticsClassID AND @AnalyticsClassID <> 0 AND QueryName = 'removeAllSiteAnalyticsData'

IF (@RemoveAllID IS NULL)
BEGIN
INSERT INTO CMS_Query (QueryName,QueryTypeID,QueryText,QueryRequiresTransaction,ClassID,QueryIsLocked,QueryLastModified,QueryGUID,
QueryLoadGeneration,QueryIsCustom) VALUES 
('removeAllSiteAnalyticsData',0,
'
DELETE FROM Analytics_HourHits  WHERE HitsStatisticsID IN (
SELECT StatisticsID FROM Analytics_Statistics WHERE ##WHERE## AND (StatisticsSiteID = @SiteID OR @SiteID = 0))    

DELETE FROM Analytics_DayHits  WHERE HitsStatisticsID IN (
SELECT StatisticsID FROM Analytics_Statistics WHERE ##WHERE## AND (StatisticsSiteID = @SiteID OR @SiteID = 0))    

DELETE FROM Analytics_WeekHits  WHERE  HitsStatisticsID IN (
SELECT StatisticsID FROM Analytics_Statistics WHERE ##WHERE## AND (StatisticsSiteID = @SiteID OR @SiteID = 0))    

DELETE FROM Analytics_MonthHits  WHERE HitsStatisticsID IN (
SELECT StatisticsID FROM Analytics_Statistics WHERE ##WHERE## AND (StatisticsSiteID = @SiteID OR @SiteID = 0))    

DELETE FROM Analytics_YearHits  WHERE HitsStatisticsID IN (
SELECT StatisticsID FROM Analytics_Statistics WHERE ##WHERE## AND (StatisticsSiteID = @SiteID OR @SiteID = 0))    

DELETE FROM Analytics_Statistics WHERE 
    StatisticsID NOT IN (SELECT HitsStatisticsID FROM Analytics_YearHits)   
AND StatisticsID NOT IN (SELECT HitsStatisticsID FROM Analytics_MonthHits)  
AND StatisticsID NOT IN (SELECT HitsStatisticsID FROM Analytics_WeekHits)   
AND StatisticsID NOT IN (SELECT HitsStatisticsID FROM Analytics_DayHits)  
AND StatisticsID NOT IN (SELECT HitsStatisticsID FROM Analytics_HourHits)
',
0,@AnalyticsClassID,0,getdate(),newid(),0,NULL);

END 


/******** END INSERT REMOVE ALL ANALYTICS DATA ********/

/******** BEGIN UPDATE FORM CONTROLS ******/

UPDATE [CMS_FormUserControl] SET [UserControlType]=0 WHERE UserControlCodeName IN ('AllowedExtensionsSelector', 'PasswordStrength')
UPDATE [CMS_FormUserControl] SET [UserControlType]=2 WHERE UserControlCodeName IN ('CategorySelector', 'DateIntervalSelector')
UPDATE [CMS_FormUserControl] SET [UserControlDisplayName]='Date & time filter', [UserControlShowInCustomTables] = 1, [UserControlShowInBizForms] = 1, [UserControlDefaultDataType] = 'DateTime' WHERE UserControlCodeName = N'DateTimeFilter'

GO

/******** END UPDATE FORM CONTROLS ******/


/******** BEGIN UPDATE QUERIES ******/

UPDATE [CMS_Query]
   SET [QueryText] = 'SELECT ##TOPN## ##COLUMNS## FROM CMS_VersionHistory LEFT JOIN CMS_Class ON CMS_Class.ClassID = VersionClassID
WHERE (VersionDeletedWhen IS NOT NULL) AND (NodeSiteID=@SiteID OR NodeSiteID IS NULL OR @SiteID = 0) AND ##WHERE## 
ORDER BY ##ORDERBY##'
 WHERE [QueryName] = 'selectrecyclebin' AND [ClassID] IN (SELECT [ClassID] FROM [CMS_Class] WHERE [ClassName] = 'cms.versionhistory')

/******** END UPDATE QUERIES ******/


/* ----------------------------------------------------------------------------*/
/* This SQL command must be at the end and must contain current hotfix version */
/* ----------------------------------------------------------------------------*/
UPDATE [CMS_SettingsKey] SET KeyValue = '4' WHERE KeyName = N'CMSHotfixVersion'
GO
