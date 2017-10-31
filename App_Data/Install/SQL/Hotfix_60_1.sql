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
   SET QueryText = 'SELECT *
FROM OM_MVTCombination
WHERE
  (MVTCombinationPageTemplateID = @MVTCombinationPageTemplateID)
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
   SET QueryText = 'SELECT *
FROM OM_MVTCombination
WHERE
  (MVTCombinationPageTemplateID = @MVTCombinationPageTemplateID)
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


/* ----------------------------------------------------------------------------*/
/* This SQL command must be at the end and must contain current hotfix version */
/* ----------------------------------------------------------------------------*/
UPDATE [CMS_SettingsKey] SET KeyValue = '1' WHERE KeyName = N'CMSHotfixVersion'
GO
