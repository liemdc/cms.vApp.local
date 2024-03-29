using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.DataEngine;
using CMS.GlobalHelper;
using CMS.SiteProvider;
using CMS.Synchronization;
using CMS.TreeEngine;
using CMS.UIControls;
using CMS.WorkflowEngine;
using CMS.EventLog;
using CMS.IO;
using CMS.SettingsProvider;

using TreeNode = CMS.TreeEngine.TreeNode;

/// <summary>
/// Image editor for attachments and meta files.
/// </summary>
public partial class CMSAdminControls_ImageEditor_ImageEditor : CMSUserControl
{
    #region "Variables"

    private Guid attachmentGuid = Guid.Empty;
    private Guid metafileGuid = Guid.Empty;
    private AttachmentInfo ai = null;
    private MetaFileInfo mf = null;
    private AttachmentManager mAttachmentManager = null;
    private VersionManager mVersionManager = null;
    private string mCurrentSiteName = null;
    private bool mRefreshAfterAction = true;
    private string externalControlID = null;
    private int siteId = 0;
    private bool mEnabled = true;

    private string filePath = null;

    #endregion


    #region "Properties"

    /// <summary>
    /// Gets the GUID of the instance of the ImageEditor.
    /// </summary>
    public Guid InstanceGUID
    {
        get
        {
            return baseImageEditor.InstanceGUID;
        }
    }


    /// <summary>
    /// Version manager.
    /// </summary>
    public VersionManager VersionManager
    {
        get
        {
            if (mVersionManager == null)
            {
                mVersionManager = new VersionManager(baseImageEditor.Tree);
            }
            return mVersionManager;
        }
    }


    /// <summary>
    /// Attachment manager.
    /// </summary>
    public AttachmentManager AttachmentManager
    {
        get
        {
            if (mAttachmentManager == null)
            {
                mAttachmentManager = new AttachmentManager();
            }
            return mAttachmentManager;
        }
    }


    /// <summary>
    /// Indicates whether the refresh should be risen after edit action takes place.
    /// </summary>
    public bool RefreshAfterAction
    {
        get
        {
            return mRefreshAfterAction;
        }
        set
        {
            mRefreshAfterAction = value;
        }
    }


    /// <summary>
    /// Returns the site name from query string 'sitename' or 'siteid' if present, otherwise CMSContext.CurrentSiteName.
    /// </summary>
    private string CurrentSiteName
    {
        get
        {
            if (mCurrentSiteName == null)
            {
                mCurrentSiteName = QueryHelper.GetString("sitename", CMSContext.CurrentSiteName);

                siteId = QueryHelper.GetInteger("siteid", 0);

                SiteInfo site = SiteInfoProvider.GetSiteInfo(siteId);
                if (site != null)
                {
                    mCurrentSiteName = site.SiteName;
                }
            }
            return mCurrentSiteName;
        }
    }


    /// <summary>
    /// Version history ID.
    /// </summary>
    public int VersionHistoryID
    {
        get
        {
            return ValidationHelper.GetInteger(ViewState["VersionHistoryID"], 0);
        }
        set
        {
            ViewState["VersionHistoryID"] = value;
        }
    }


    /// <summary>
    /// Indicates if saving failed.
    /// </summary>
    public bool SavingFailed
    {
        get
        {
            return this.baseImageEditor.SavingFailed;
        }
        set
        {
            this.baseImageEditor.SavingFailed = value;
        }
    }


    /// <summary>
    /// Indicates if control is enabled.
    /// </summary>
    public bool Enabled
    {
        get
        {
            return this.mEnabled;
        }
        set
        {
            this.mEnabled = value;
        }
    }

    #endregion


    #region "Events"

    /// <summary>
    /// Loads image URL.
    /// </summary>
    void baseImageEditor_LoadImageUrl()
    {
        // Use appropriate parameter from URL
        string url = null;
        if (attachmentGuid != Guid.Empty)
        {
            int documentId = (ai != null) ? ai.AttachmentDocumentID : 0;
            bool useLatestDoc = (IsLiveSite && (documentId > 0));

            url = "~/CMSPages/GetFile.aspx?guid=" + attachmentGuid + "&sitename=" + CurrentSiteName;
            if ((VersionHistoryID != 0) && !useLatestDoc)
            {
                url += "&versionhistoryid=" + VersionHistoryID;
            }

            // Add latest version requirement for live site
            if (useLatestDoc)
            {
                // Add requirement for latest version of files for current document
                string newparams = "latestfordocid=" + documentId;
                newparams += "&hash=" + ValidationHelper.GetHashString("d" + documentId);

                url += "&" + newparams;
            }

        }
        else if (metafileGuid != Guid.Empty)
        {
            url = "~/CMSPages/GetMetaFile.aspx?fileguid=" + metafileGuid + "&sitename=" + CurrentSiteName;
        }
        else
        {
            // Path to the physical file
            baseImageEditor.AttUrl = filePath;
            return;
        }

        baseImageEditor.AttUrl = URLHelper.UpdateParameterInUrl(url, "chset", Guid.NewGuid().ToString());
    }


    /// <summary>
    /// Loads image type from querystring.
    /// </summary>
    void baseImageEditor_LoadImageType()
    {
        // Use appropriate parameter from URL
        if (attachmentGuid != Guid.Empty)
        {
            baseImageEditor.ImageType = ImageHelper.ImageTypeEnum.Attachment;
        }
        else if (metafileGuid != Guid.Empty)
        {
            baseImageEditor.ImageType = ImageHelper.ImageTypeEnum.Metafile;
        }
        else if (!string.IsNullOrEmpty(filePath))
        {
            baseImageEditor.ImageType = ImageHelper.ImageTypeEnum.PhysicalFile;
        }
    }


    /// <summary>
    /// Initializes common properties used for processing image.
    /// </summary>
    void baseImageEditor_InitializeProperties()
    {
        CurrentUserInfo currentUser = CMSContext.CurrentUser;

        // Process attachment
        switch (baseImageEditor.ImageType)
        {
            default:
            case ImageHelper.ImageTypeEnum.Attachment:
                {
                    baseImageEditor.Tree = new TreeProvider(currentUser);

                    // If using workflow then get versioned attachment
                    if (VersionHistoryID != 0)
                    {
                        // Get the versioned attachment
                        AttachmentHistoryInfo attachmentVersion = VersionManager.GetAttachmentVersion(VersionHistoryID, attachmentGuid);
                        if (attachmentVersion == null)
                        {
                            ai = null;
                        }
                        else
                        {
                            // Create new attachment object
                            ai = new AttachmentInfo(attachmentVersion.Generalized.DataClass);
                            ai.AttachmentID = attachmentVersion.AttachmentHistoryID;
                        }
                    }
                    // else get file without binary data
                    else
                    {
                        ai = AttachmentManager.GetAttachmentInfoWithoutBinary(attachmentGuid, CurrentSiteName);
                    }

                    // If file is not null and current user is set
                    if (ai != null)
                    {
                        TreeNode node = null;
                        if (ai.AttachmentDocumentID > 0)
                        {
                            node = baseImageEditor.Tree.SelectSingleDocument(ai.AttachmentDocumentID);
                        }
                        else
                        {
                            // Get parent node ID in case attachment is edited for document not created yet
                            int parentNodeId = QueryHelper.GetInteger("parentId", 0);

                            node = baseImageEditor.Tree.SelectSingleNode(parentNodeId);
                        }

                        // If current user has appropriate permissions then set image - check hash fro live site otherwise check node permissions
                        if ((currentUser != null) && (node != null) && ((IsLiveSite && QueryHelper.ValidateHash("hash")) || (!IsLiveSite && (currentUser.IsAuthorizedPerDocument(node, NodePermissionsEnum.Modify) == AuthorizationResultEnum.Allowed))))
                        {
                            // Ensure attachment binary data
                            if (VersionHistoryID == 0)
                            {
                                ai.AttachmentBinary = AttachmentManager.GetFile(ai, CurrentSiteName);
                            }

                            if (ai.AttachmentBinary != null)
                            {
                                baseImageEditor.ImgHelper = new ImageHelper(ai.AttachmentBinary);
                            }
                            else
                            {
                                baseImageEditor.LoadingFailed = true;
                                baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                            }
                        }
                        else
                        {
                            baseImageEditor.LoadingFailed = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.filemodify";
                        }
                    }
                    else
                    {
                        baseImageEditor.LoadingFailed = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                    }
                }
                break;

            // Process physical file
            case ImageHelper.ImageTypeEnum.PhysicalFile:
                {
                    if (!String.IsNullOrEmpty(filePath))
                    {
                        if ((currentUser != null) && currentUser.IsGlobalAdministrator)
                        {
                            try
                            {
                                // Load the file from disk
                                string physicalPath = Server.MapPath(filePath);
                                byte[] data = File.ReadAllBytes(physicalPath);
                                baseImageEditor.ImgHelper = new ImageHelper(data);
                            }
                            catch
                            {
                                baseImageEditor.LoadingFailed = true;
                                baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                            }
                        }
                        else
                        {
                            baseImageEditor.LoadingFailed = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.rights";
                        }
                    }
                    else
                    {
                        baseImageEditor.LoadingFailed = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                    }
                }
                break;

            // Process metafile
            case ImageHelper.ImageTypeEnum.Metafile:
                {
                    // Get metafile
                    mf = MetaFileInfoProvider.GetMetaFileInfoWithoutBinary(metafileGuid, CurrentSiteName, true);

                    // If file is not null and current user is global administrator then set image
                    if (mf != null)
                    {
                        if (UserInfoProvider.IsAuthorizedPerObject(mf.MetaFileObjectType, mf.MetaFileObjectID, PermissionsEnum.Modify, this.CurrentSiteName, CMSContext.CurrentUser))
                        {
                            // Ensure metafile binary data
                            mf.MetaFileBinary = MetaFileInfoProvider.GetFile(mf, CurrentSiteName);
                            if (mf.MetaFileBinary != null)
                            {
                                baseImageEditor.ImgHelper = new ImageHelper(mf.MetaFileBinary);
                            }
                            else
                            {
                                baseImageEditor.LoadingFailed = true;
                                baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                            }
                        }
                        else
                        {
                            baseImageEditor.LoadingFailed = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.rights";
                        }
                    }
                    else
                    {
                        baseImageEditor.LoadingFailed = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                    }
                }
                break;
        }

        // Check that image is in supported formats
        if ((!baseImageEditor.LoadingFailed) && (baseImageEditor.ImgHelper.ImageFormatToString() == null))
        {
            baseImageEditor.LoadingFailed = true;
            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.format";
        }
    }


    /// <summary>
    /// Initialize labels according to current image type.
    /// </summary>
    void baseImageEditor_InitializeLabels(bool reloadName)
    {
        //Initialize strings depending on image type
        switch (baseImageEditor.ImageType)
        {
            default:
            case ImageHelper.ImageTypeEnum.Attachment:
                if (ai != null)
                {
                    if (reloadName)
                    {
                        baseImageEditor.TxtFileName.Text = ai.AttachmentName.Substring(0, (ai.AttachmentName.Length - (ai.AttachmentExtension.Length)));
                    }
                    baseImageEditor.LblExtensionValue.Text = ai.AttachmentExtension.Substring(1, (ai.AttachmentExtension.Length - 1));
                    baseImageEditor.LblImageSizeValue.Text = DataHelper.GetSizeString(ai.AttachmentSize);
                    baseImageEditor.LblWidthValue.Text = ai.AttachmentImageWidth.ToString();
                    baseImageEditor.LblHeightValue.Text = ai.AttachmentImageHeight.ToString();
                    baseImageEditor.SetTitleAndDescription(ai.AttachmentTitle, ai.AttachmentDescription);
                    // Set attachment info object
                    baseImageEditor.SetMetaDataInfoObject(ai);
                }
                break;

            case ImageHelper.ImageTypeEnum.PhysicalFile:
                {
                    if (!String.IsNullOrEmpty(filePath))
                    {
                        if (!RequestHelper.IsPostBack())
                        {
                            baseImageEditor.TxtFileName.Text = Path.GetFileNameWithoutExtension(filePath);
                        }
                        baseImageEditor.LblExtensionValue.Text = Path.GetExtension(filePath);

                        if (baseImageEditor.ImgHelper != null)
                        {
                            ImageHelper img = baseImageEditor.ImgHelper;
                            baseImageEditor.LblImageSizeValue.Text = DataHelper.GetSizeString(img.SourceData.Length);
                            baseImageEditor.LblWidthValue.Text = img.ImageWidth.ToString();
                            baseImageEditor.LblHeightValue.Text = img.ImageHeight.ToString();
                        }
                    }
                }
                break;

            case ImageHelper.ImageTypeEnum.Metafile:
                if (mf != null)
                {
                    if (!RequestHelper.IsPostBack())
                    {
                        baseImageEditor.TxtFileName.Text = mf.MetaFileName.Substring(0, (mf.MetaFileName.Length - (mf.MetaFileExtension.Length)));
                    }
                    baseImageEditor.LblExtensionValue.Text = mf.MetaFileExtension.Substring(1, (mf.MetaFileExtension.Length - 1));
                    baseImageEditor.LblImageSizeValue.Text = DataHelper.GetSizeString(mf.MetaFileSize);
                    baseImageEditor.LblWidthValue.Text = mf.MetaFileImageWidth.ToString();
                    baseImageEditor.LblHeightValue.Text = mf.MetaFileImageHeight.ToString();
                    baseImageEditor.SetTitleAndDescription(mf.MetaFileTitle, mf.MetaFileDescription);
                    // Set metafile info object
                    baseImageEditor.SetMetaDataInfoObject(mf);
                }
                break;
        }
    }


    /// <summary>
    /// Saves modified image data.
    /// </summary>
    /// <param name="name">Image name</param>
    /// <param name="extension">Image extension</param>
    /// <param name="mimetype">Image mimetype</param>
    /// <param name="title">Image title</param>
    /// <param name="description">Image description</param>
    /// <param name="binary">Image binary data</param>
    /// <param name="width">Image width</param>
    /// <param name="height">Image height</param>
    void baseImageEditor_SaveImage(string name, string extension, string mimetype, string title, string description, byte[] binary, int width, int height)
    {
        SaveImage(name, extension, mimetype, title, description, binary, width, height);
    }


    /// <summary>
    /// Returns image name, title and description according to image type.
    /// </summary>
    /// <returns>Image name, title and desciption</returns>
    void baseImageEditor_GetMetaData()
    {
        LoadInfos();

        string name = string.Empty;
        string title = string.Empty;
        string description = string.Empty;

        switch (baseImageEditor.ImageType)
        {
            case ImageHelper.ImageTypeEnum.Attachment:
                if (ai != null)
                {
                    name = Path.GetFileNameWithoutExtension(ai.AttachmentName);
                    title = ai.AttachmentTitle;
                    description = ai.AttachmentDescription;
                }
                break;

            case ImageHelper.ImageTypeEnum.PhysicalFile:
                if (!String.IsNullOrEmpty(filePath))
                {
                    name = Path.GetFileNameWithoutExtension(filePath);
                }
                break;

            case ImageHelper.ImageTypeEnum.Metafile:
                if (mf != null)
                {
                    name = Path.GetFileNameWithoutExtension(mf.MetaFileName);
                    title = mf.MetaFileTitle;
                    description = mf.MetaFileDescription;
                }
                break;
        }

        baseImageEditor.GetNameResult = name;
        baseImageEditor.GetTitleResult = title;
        baseImageEditor.GetDescriptionResult = description;
    }


    /// <summary>
    /// Sets mate data according to image type.
    /// </summary>
    /// <param name="name">File name</param>
    /// <param name="title">File title</param>
    /// <param name="description">File description</param>
    void baseImageEditor_SetMetaData(string name, string title, string description)
    {
        LoadInfos();

        string newName = name + "." + baseImageEditor.CurrentFormat;

        // Check that file name is unique in case that it is attachment
        if (((baseImageEditor.ImageType == ImageHelper.ImageTypeEnum.Attachment) && IsNameUnique(newName, null)) ||
            (baseImageEditor.ImageType == ImageHelper.ImageTypeEnum.Metafile) ||
            (baseImageEditor.ImageType == ImageHelper.ImageTypeEnum.PhysicalFile)
            )
        {
            if (RefreshAfterAction)
            {
                string clientId = QueryHelper.GetString("clientid", "").ToLower();
                switch (clientId)
                {
                    case "content":
                        baseImageEditor.LtlScript.Text = ScriptHelper.GetScript("if(wopener.imageEdit_ContentRefresh){wopener.imageEdit_ContentRefresh('guid|" + attachmentGuid + "|nodeId|" + QueryHelper.GetInteger("parentId", 0) + "')}");
                        break;

                    case "docattachments":
                        baseImageEditor.LtlScript.Text = ScriptHelper.GetScript("if(wopener.imageEdit_AttachmentRefresh){wopener.imageEdit_AttachmentRefresh('guid|" + attachmentGuid + "')}");
                        break;

                    default:
                        // baseImageEditor.LtlScript.Text = ScriptHelper.GetScript("Refresh();");
                        break;
                }
            }
            baseImageEditor.PropagateChanges(false);
        }
        else
        {
            baseImageEditor.LblFileNameValidationFailed.ResourceString = "img.namenotunique";
            baseImageEditor.LblFileNameValidationFailed.Visible = true;
            baseImageEditor.LoadingFailed = true;
        }
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        // Initialize GUID from query
        attachmentGuid = QueryHelper.GetGuid("attachmentguid", Guid.Empty);
        metafileGuid = QueryHelper.GetGuid("metafileguid", Guid.Empty);
        if (!RequestHelper.IsPostBack())
        {
            VersionHistoryID = QueryHelper.GetInteger("VersionHistoryID", 0);
        }
        externalControlID = QueryHelper.GetString("clientid", null);

        String identifier = QueryHelper.GetString("identifier", null);
        if (!String.IsNullOrEmpty(identifier))
        {
            Hashtable properties = WindowHelper.GetItem(identifier) as Hashtable;
            if (properties != null)
            {
                filePath = ValidationHelper.GetString(properties["filepath"], null);
            }
        }

        string siteName = CMSContext.CurrentSiteName;

        bool storeFilesToDisk = SettingsKeyProvider.GetBoolValue(siteName + ".CMSStoreFilesInFileSystem");
        bool storeFilesInDatabase = SettingsKeyProvider.GetBoolValue(siteName + ".CMSStoreFilesInDatabase");

        // Check only if store files in file system is enabled
        if (storeFilesToDisk && !storeFilesInDatabase)
        {
            // Get path to media file folder
            string path = DirectoryHelper.CombinePath(Server.MapPath("~/"), siteName);

            //  Attachments folder
            if (attachmentGuid != Guid.Empty)
            {
                path = DirectoryHelper.CombinePath(path, "files");
            }

            // Metafiles folder
            if (metafileGuid != Guid.Empty)
            {
                path = DirectoryHelper.CombinePath(path, "metafiles");
            }

            // Enable control if permissions are sufficient to edit image
            this.Enabled = DirectoryHelper.CheckPermissions(path, false, true, true, true);

            if (!this.Enabled)
            {
                // Set error message
                this.baseImageEditor.LblLoadFailed.Visible = true;
                this.baseImageEditor.LblLoadFailed.ResourceString = "img.errors.filesystempermissions";
            }
        }

        baseImageEditor.LoadImageType += new CMSAdminControls_ImageEditor_BaseImageEditor.OnLoadImageType(baseImageEditor_LoadImageType);
        baseImageEditor.LoadImageUrl += new CMSAdminControls_ImageEditor_BaseImageEditor.OnLoadImageUrl(baseImageEditor_LoadImageUrl);
        baseImageEditor.InitializeProperties += new CMSAdminControls_ImageEditor_BaseImageEditor.OnInitializeProperties(baseImageEditor_InitializeProperties);
        baseImageEditor.InitializeLabels += new CMSAdminControls_ImageEditor_BaseImageEditor.OnInitializeLabels(baseImageEditor_InitializeLabels);
        baseImageEditor.SaveImage += new CMSAdminControls_ImageEditor_BaseImageEditor.OnSaveImage(baseImageEditor_SaveImage);
        baseImageEditor.GetMetaData += new CMSAdminControls_ImageEditor_BaseImageEditor.OnGetMetaData(baseImageEditor_GetMetaData);
    }


    /// <summary>
    /// Checks whether the name is unique.
    /// </summary>
    /// <param name="name">New attachment name</param>
    /// <param name="extension">New attachment extension. If null current is used.</param>
    private bool IsNameUnique(string name, string extension)
    {
        if ((ai != null) && (AttachmentManager != null))
        {
            // Ensure extension is set
            extension = extension ?? ai.AttachmentExtension;

            // Check that the name is unique in the document or version context
            Guid attachmentFormGuid = QueryHelper.GetGuid("formguid", Guid.Empty);
            bool nameIsUnique = false;
            if (attachmentFormGuid == Guid.Empty)
            {
                // Get the node
                TreeNode node = DocumentHelper.GetDocument(ai.AttachmentDocumentID, baseImageEditor.Tree);
                nameIsUnique = DocumentHelper.IsUniqueAttachmentName(node, name, extension, ai.AttachmentID, baseImageEditor.Tree);
            }
            else
            {
                nameIsUnique = AttachmentManager.IsUniqueTemporaryAttachmentName(attachmentFormGuid, name, extension, ai.AttachmentID);
            }
            return nameIsUnique;
        }

        return false;
    }


    /// <summary>
    /// Saves modified image data.
    /// </summary>
    /// <param name="name">Image name</param>
    /// <param name="extension">Image extension</param>
    /// <param name="mimetype">Image mimetype</param>
    /// <param name="title">Image title</param>
    /// <param name="description">Image description</param>
    /// <param name="binary">Image binary data</param>
    /// <param name="width">Image width</param>
    /// <param name="height">Image height</param>
    private void SaveImage(string name, string extension, string mimetype, string title, string description, byte[] binary, int width, int height)
    {
        LoadInfos();

        // Save image data depending to image type
        switch (baseImageEditor.ImageType)
        {
            // Process attachment
            case ImageHelper.ImageTypeEnum.Attachment:
                if ((ai != null) && (AttachmentManager != null))
                {
                    // Save new data
                    try
                    {
                        // Get the node
                        TreeNode node = DocumentHelper.GetDocument(ai.AttachmentDocumentID, baseImageEditor.Tree);

                        // Check Create permission when saving temporary attachment, check Modify permission else
                        NodePermissionsEnum permissionToCheck = (ai.AttachmentFormGUID == Guid.Empty) ? NodePermissionsEnum.Modify : NodePermissionsEnum.Create;

                        // Check permission
                        if (CMSContext.CurrentUser.IsAuthorizedPerDocument(node, permissionToCheck) != AuthorizationResultEnum.Allowed)
                        {
                            baseImageEditor.LblLoadFailed.Visible = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "attach.actiondenied";
                            this.SavingFailed = true;

                            return;
                        }

                        if (!IsNameUnique(name, extension))
                        {
                            baseImageEditor.LblLoadFailed.Visible = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.namenotunique";
                            this.SavingFailed = true;

                            return;
                        }



                        // Ensure automatic check-in/ check-out
                        bool useWorkflow = false;
                        bool autoCheck = false;
                        WorkflowManager workflowMan = new WorkflowManager(baseImageEditor.Tree);
                        if (node != null)
                        {
                            // Get workflow info
                            WorkflowInfo wi = workflowMan.GetNodeWorkflow(node);

                            // Check if the document uses workflow
                            if (wi != null)
                            {
                                useWorkflow = true;
                                autoCheck = !wi.UseCheckInCheckOut(CurrentSiteName);
                            }

                            // Check out the document
                            if (autoCheck)
                            {
                                VersionManager.CheckOut(node, node.IsPublished, true);
                                VersionHistoryID = node.DocumentCheckedOutVersionHistoryID;
                            }

                            // Workflow has been lost, get published attachment
                            if (useWorkflow && (VersionHistoryID == 0))
                            {
                                ai = AttachmentManager.GetAttachmentInfo(ai.AttachmentGUID, CurrentSiteName);
                            }

                            // If extension changed update CMS.File extension
                            if ((node.NodeClassName.ToLower() == "cms.file") && (node.DocumentExtensions != extension))
                            {
                                // Update document extensions if no custom are used
                                if (!node.DocumentUseCustomExtensions)
                                {
                                    node.DocumentExtensions = extension;
                                }
                                node.SetValue("DocumentType", extension);

                                DocumentHelper.UpdateDocument(node, baseImageEditor.Tree);
                            }
                        }

                        if (ai != null)
                        {
                            // Test all parameters to empty values and update new value if available
                            if (name != "")
                            {
                                if (!name.EndsWith(extension))
                                {
                                    ai.AttachmentName = name + extension;
                                }
                                else
                                {
                                    ai.AttachmentName = name;
                                }
                            }
                            if (extension != "")
                            {
                                ai.AttachmentExtension = extension;
                            }
                            if (mimetype != "")
                            {
                                ai.AttachmentMimeType = mimetype;
                            }

                            ai.AttachmentTitle = title;
                            ai.AttachmentDescription = description;

                            if (binary != null)
                            {
                                ai.AttachmentBinary = binary;
                                ai.AttachmentSize = binary.Length;
                            }
                            if (width > 0)
                            {
                                ai.AttachmentImageWidth = width;
                            }
                            if (height > 0)
                            {
                                ai.AttachmentImageHeight = height;
                            }
                            // Ensure object
                            ai.MakeComplete(true);
                            if (VersionHistoryID > 0)
                            {
                                VersionManager.SaveAttachmentVersion(ai, VersionHistoryID);
                            }
                            else
                            {
                                AttachmentManager.SetAttachmentInfo(ai);

                                // Log the sycnhronization and search task for the document
                                if (node != null)
                                {
                                    // Update search index for given document
                                    if ((node.PublishedVersionExists) && (SearchIndexInfoProvider.SearchEnabled))
                                    {
                                        SearchTaskInfoProvider.CreateTask(SearchTaskTypeEnum.Update, PredefinedObjectType.DOCUMENT, SearchHelper.ID_FIELD, node.GetSearchID());
                                    }

                                    DocumentSynchronizationHelper.LogDocumentChange(node, TaskTypeEnum.UpdateDocument, baseImageEditor.Tree);
                                }
                            }

                            // Check in the document
                            if (autoCheck)
                            {
                                if (VersionManager != null)
                                {
                                    if (VersionHistoryID > 0 && node != null)
                                    {
                                        VersionManager.CheckIn(node, null, null);
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        baseImageEditor.LblLoadFailed.Visible = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.processing";
                        ScriptHelper.AppendTooltip(baseImageEditor.LblLoadFailed, ex.Message, "help");
                        EventLogProvider.LogException("Image editor", "SAVEIMAGE", ex);
                        this.SavingFailed = true;
                    }
                }
                break;

            case ImageHelper.ImageTypeEnum.PhysicalFile:
                if (!String.IsNullOrEmpty(filePath))
                {
                    CurrentUserInfo currentUser = CMSContext.CurrentUser;
                    if ((currentUser != null) && currentUser.IsGlobalAdministrator)
                    {
                        try
                        {
                            string physicalPath = Server.MapPath(filePath);
                            string newPath = physicalPath;

                            // Write binary data to the disk
                            File.WriteAllBytes(physicalPath, binary);

                            // Handle rename of the file
                            if (!String.IsNullOrEmpty(name))
                            {
                                newPath = DirectoryHelper.CombinePath(Path.GetDirectoryName(physicalPath), name);
                            }
                            if (!String.IsNullOrEmpty(extension))
                            {
                                string oldExt = Path.GetExtension(physicalPath);
                                newPath = newPath.Substring(0, newPath.Length - oldExt.Length) + extension;
                            }

                            // Move the file
                            if (newPath != physicalPath)
                            {
                                File.Move(physicalPath, newPath);
                            }
                        }
                        catch (Exception ex)
                        {
                            baseImageEditor.LblLoadFailed.Visible = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.processing";
                            ScriptHelper.AppendTooltip(baseImageEditor.LblLoadFailed, ex.Message, "help");
                            EventLogProvider.LogException("Image editor", "SAVEIMAGE", ex);
                            this.SavingFailed = true;
                        }
                    }
                    else
                    {
                        baseImageEditor.LblLoadFailed.Visible = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.rights";
                        this.SavingFailed = true;
                    }
                }
                break;

            // Process metafile
            case ImageHelper.ImageTypeEnum.Metafile:

                if (mf != null)
                {
                    if (UserInfoProvider.IsAuthorizedPerObject(mf.MetaFileObjectType, mf.MetaFileObjectID, PermissionsEnum.Modify, this.CurrentSiteName, CMSContext.CurrentUser))
                    {
                        try
                        {
                            // Test all parameters to empty values and update new value if available
                            if (name.CompareTo("") != 0)
                            {
                                if (!name.EndsWith(extension))
                                {
                                    mf.MetaFileName = name + extension;
                                }
                                else
                                {
                                    mf.MetaFileName = name;
                                }
                            }
                            if (extension.CompareTo("") != 0)
                            {
                                mf.MetaFileExtension = extension;
                            }
                            if (mimetype.CompareTo("") != 0)
                            {
                                mf.MetaFileMimeType = mimetype;
                            }

                            mf.MetaFileTitle = title;
                            mf.MetaFileDescription = description;

                            if (binary != null)
                            {
                                mf.MetaFileBinary = binary;
                                mf.MetaFileSize = binary.Length;
                            }
                            if (width > 0)
                            {
                                mf.MetaFileImageWidth = width;
                            }
                            if (height > 0)
                            {
                                mf.MetaFileImageHeight = height;
                            }

                            // Save new data
                            MetaFileInfoProvider.SetMetaFileInfo(mf);

                            if (RefreshAfterAction)
                            {
                                if (String.IsNullOrEmpty(externalControlID))
                                {
                                    baseImageEditor.LtlScript.Text = ScriptHelper.GetScript("Refresh();");
                                }
                                else
                                {
                                    baseImageEditor.LtlScript.Text = ScriptHelper.GetScript(String.Format("InitRefresh({0}, false, false, '{1}', 'refresh')", ScriptHelper.GetString(externalControlID), mf.MetaFileGUID));
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            baseImageEditor.LblLoadFailed.Visible = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.processing";
                            ScriptHelper.AppendTooltip(baseImageEditor.LblLoadFailed, ex.Message, "help");
                            EventLogProvider.LogException("Image editor", "SAVEIMAGE", ex);
                            this.SavingFailed = true;
                        }
                    }
                    else
                    {
                        baseImageEditor.LblLoadFailed.Visible = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.rights";
                        this.SavingFailed = true;
                    }
                }
                break;
        }
    }


    /// <summary>
    /// Ensures the info objects.
    /// </summary>
    private void LoadInfos()
    {
        switch (baseImageEditor.ImageType)
        {
            default:
            case ImageHelper.ImageTypeEnum.Attachment:

                if (ai == null)
                {
                    baseImageEditor.Tree = new TreeProvider(CMSContext.CurrentUser);

                    // If using workflow then get versioned attachment
                    if (VersionHistoryID != 0)
                    {
                        AttachmentHistoryInfo attachmentVersion = VersionManager.GetAttachmentVersion(VersionHistoryID, attachmentGuid);
                        if (attachmentVersion == null)
                        {
                            ai = null;
                        }
                        else
                        {
                            ai = new AttachmentInfo(attachmentVersion.Generalized.DataClass);
                            ai.AttachmentID = attachmentVersion.AttachmentHistoryID;
                        }
                    }
                    // else get file without binary data
                    else
                    {
                        ai = AttachmentManager.GetAttachmentInfoWithoutBinary(attachmentGuid, CurrentSiteName);
                    }
                }
                break;

            case ImageHelper.ImageTypeEnum.Metafile:

                if (mf == null)
                {
                    mf = MetaFileInfoProvider.GetMetaFileInfoWithoutBinary(metafileGuid, CurrentSiteName, true);
                }
                break;

            case ImageHelper.ImageTypeEnum.PhysicalFile:
                // Skip loading info for physical files
                break;
        }

    }

    #endregion


    #region "Undo redo functionality"

    /// <summary>
    /// Returns true if the files are stored only in DB or user has disk read/write permissions. Otherwise false.
    /// </summary>
    public bool IsUndoRedoPossible()
    {
        return baseImageEditor.IsUndoRedoPossible();
    }


    /// <summary>
    /// Returns true if there is a previous version of the file which is being modified.
    /// </summary>
    public bool IsUndoEnabled()
    {
        return baseImageEditor.IsUndoEnabled();
    }


    /// <summary>
    /// Returns true if there is a next version of the file which is being modified.
    /// </summary>
    public bool IsRedoEnabled()
    {
        return baseImageEditor.IsRedoEnabled();
    }


    /// <summary>
    /// Processes the undo action.
    /// </summary>
    public void ProcessUndo()
    {
        baseImageEditor.ProcessUndo();
    }


    /// <summary>
    /// Processes the redo action.
    /// </summary>
    public void ProcessRedo()
    {
        baseImageEditor.ProcessRedo();
    }


    /// <summary>
    /// Saves current version of image and discards all other versions.
    /// </summary>
    public void SaveCurrentVersion()
    {
        baseImageEditor.SaveCurrentVersion(true);
    }

    #endregion
}
