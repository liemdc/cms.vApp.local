using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.ExtendedControls;
using CMS.SiteProvider;

[EditedObject(OnlineMarketingObjectType.CONTACT, "contactID")]

public partial class CMSModules_ContactManagement_Pages_Tools_Contact_Tab_ContactGroups : CMSContactManagementContactGroupsPage
{
    #region "Variables"

    private ContactInfo editedContact;
    private CurrentUserInfo currentUser;
    private int siteID;
    private Permissions permissions = new Permissions();

    #endregion


    #region "Structs"

    /// <summary>
    /// Container of current user permissions related to this page.
    /// </summary>
    private struct Permissions
    {
        public bool ReadGroup;
        public bool ReadGlobalGroup;
        public bool ReadContact;
        public bool ReadGlobalContact;
        public bool ModifyGroup;
        public bool ModifyGlobalGroup;
        public bool ModifyContact;
        public bool ModifyGlobalContact;
    }

    #endregion


    #region "Page Load Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        editedContact = (ContactInfo)CMSPage.EditedObject;
        currentUser = CMSContext.CurrentUser;
        siteID = ContactHelper.ObjectSiteID(EditedObject);

        LoadPermissions();
        CheckReadPermission();
        LoadGroupSelector();
        LoadContactGroups();
    }


    /// <summary>
    /// Loads permissions for current user.
    /// </summary>
    void LoadPermissions()
    {
        permissions.ReadGroup = ContactGroupHelper.AuthorizedReadContactGroup(siteID, false);
        permissions.ReadGlobalGroup = ContactGroupHelper.AuthorizedReadContactGroup(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ReadContact = ContactHelper.AuthorizedReadContact(siteID, false);
        permissions.ReadGlobalContact = ContactHelper.AuthorizedReadContact(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ModifyGroup = ContactGroupHelper.AuthorizedModifyContactGroup(siteID, false);
        permissions.ModifyGlobalGroup = ContactGroupHelper.AuthorizedModifyContactGroup(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ModifyContact = ContactHelper.AuthorizedModifyContact(siteID, false);
        permissions.ModifyGlobalContact = ContactHelper.AuthorizedModifyContact(UniSelector.US_GLOBAL_RECORD, false);
    }


    /// <summary>
    /// Loads group selector.
    /// </summary>
    void LoadGroupSelector()
    {
        selectGroup.UniSelector.Enabled = UserCanManageContact(editedContact) || permissions.ModifyGlobalGroup || permissions.ModifyGroup;
        selectGroup.UniSelector.OnItemsSelected += new EventHandler(UniSelector_OnItemsSelected);
        selectGroup.UniSelector.ButtonImage = GetImageUrl("Objects/CMS_User/add.png");
        selectGroup.ImageDialog.CssClass = "NewItemImage";
        selectGroup.LinkDialog.CssClass = "NewItemLink";
        selectGroup.UniSelector.ResourcePrefix = "contactgroupcontact";
        selectGroup.IsLiveSite = false;

        // Set GroupSelector values depending on current site.
        if (editedContact.ContactSiteID == 0)
        {
            selectGroup.ObjectsRange = UniSelector.US_GLOBAL_RECORD;
        }
        else
        {
            selectGroup.SiteID = editedContact.ContactSiteID;
            if (permissions.ReadGlobalGroup)
            {
                selectGroup.ObjectsRange = UniSelector.US_GLOBAL_OR_SITE_RECORD;
            }
            else
            {
                selectGroup.ObjectsRange = editedContact.ContactSiteID;
            }
        }
    }


    /// <summary>
    /// Loads contact groups.
    /// </summary>
    void LoadContactGroups()
    {
        contactGroups.UniGrid.ZeroRowsText = GetString("om.contactgroup.notfound");

        // Set confirmation dialog
        CMS.UIControls.UniGridConfig.Action removeAction = (CMS.UIControls.UniGridConfig.Action)contactGroups.UniGrid.GridActions.Actions[0];
        removeAction.Confirmation = "$om.contactgroupmember.confirmremove$";

        // Set contact group filters ..
        contactGroups.FilterByContacts.Add(editedContact.ContactID);
        contactGroups.FilterBySites.Add(editedContact.ContactSiteID);
        if (this.permissions.ReadGlobalGroup)
        {
            contactGroups.FilterBySites.Add(null);
        }

        // .. and event handlers for its remove button
        contactGroups.OnRemoveGroup += new EventHandler(cContactGroups_OnRemoveFromGroup);
        contactGroups.OnDrawRemoveButton += cContactGroups_OnDrawRemoveButton;
    }

    #endregion


    #region "Methods"

    /// <summary>
    /// Checks read permissions for current user. 
    /// Redirects to access denied page.
    /// </summary>
    protected override void CheckReadPermissions()
    {
        // This method is called in OnInit method in parent class, but 
        // in this case needs to be called later, on Page_Load.
    }


    /// <summary>
    /// Checks read permissions for current user. 
    /// Redirects to access denied page.
    /// </summary>
    protected void CheckReadPermission()
    {
        if (!permissions.ReadContact && !permissions.ReadGroup && !permissions.ReadGlobalGroup)
        {
            RedirectToAccessDenied("CMS.ContactManagement", "ReadContacts or ReadContactGroups");
        }
    }


    /// <summary>
    /// Checks whether current user can edit a group or not.
    /// Depends on loaded permissions (else will return false).
    /// </summary>
    /// <exception cref="System.ArgumentNullException">Group is null</exception>
    private bool UserCanManageGroup(ContactGroupInfo group)
    {
        if (group == null)
        {
            throw new ArgumentNullException("group");
        }

        return group.IsGlobal ? permissions.ModifyGlobalGroup : permissions.ModifyGroup;
    }


    /// <summary>
    /// Checks whether current user can edit a group or not.
    /// Depends on loaded permissions (else will return false).
    /// </summary>
    /// <exception cref="System.ArgumentNullException">Contact is null</exception>
    private bool UserCanManageContact(ContactInfo contact)
    {
        if (contact == null)
        {
            throw new ArgumentNullException("contact");
        }

        return contact.IsGlobal ? permissions.ModifyGlobalContact : permissions.ModifyContact;
    }

    #endregion


    #region "Event Handlers Methods"

    void cContactGroups_OnDrawRemoveButton(object sender, CMSModules_ContactManagement_Controls_UI_Contact_ContactGroups.DrawButtonEventArgs e)
    {
        if (sender is CMSImageButton)
        {
            // Enable or disable button
            ContactGroupInfo editedGroup = ContactGroupInfoProvider.GetContactGroupInfo((int)e.EditedObject);
            e.ButtonEnabled = UserCanManageGroup(editedGroup) || UserCanManageContact(editedContact);
        }
    }


    /// <summary>
    /// Attempt to remove user from group event handler.
    /// </summary>
    void cContactGroups_OnRemoveFromGroup(object sender, EventArgs e)
    {
        int contactGroupID = ValidationHelper.GetInteger(sender, 0);
        if (contactGroupID != 0)
        {
            ContactGroupInfo removedGroup = ContactGroupInfoProvider.GetContactGroupInfo(contactGroupID);
            if (UserCanManageGroup(removedGroup) || UserCanManageContact(editedContact))
            {
                // Get the relationship object
                ContactGroupMemberInfo mi = ContactGroupMemberInfoProvider.GetContactGroupMemberInfoByData(contactGroupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact);
                if (mi != null)
                {
                    ContactGroupMemberInfoProvider.DeleteContactGroupMemberInfo(mi);
                }
            }
        }
    }


    /// <summary>
    /// New groups selected event handler.
    /// </summary>
    void UniSelector_OnItemsSelected(object sender, EventArgs e)
    {
        // Get new items from selector
        string newValues = ValidationHelper.GetString(selectGroup.Value, null);
        string[] newGroupIDs = newValues.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

        if (newGroupIDs != null)
        {
            ContactGroupMemberInfo cgmi;
            ContactGroupInfo group;
            int groupID;

            // Get all selected groups
            foreach (string newGroupID in newGroupIDs)
            {
                groupID = ValidationHelper.GetInteger(newGroupID, 0);
                group = ContactGroupInfoProvider.GetContactGroupInfo(groupID);
                if (group == null)
                {
                    // Group was most probably deleted after the uniselector
                    // window was opened.
                    continue;
                }

                if (UserCanManageGroup(group) || UserCanManageContact(editedContact))
                {
                    // Check if relation already exists
                    cgmi = ContactGroupMemberInfoProvider.GetContactGroupMemberInfoByData(groupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact);
                    if (cgmi == null)
                    {
                        ContactGroupMemberInfoProvider.SetContactGroupMemberInfo(groupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact, MemberAddedHowEnum.Manual);
                    }
                    else if (!cgmi.ContactGroupMemberFromManual)
                    {
                        cgmi.ContactGroupMemberFromManual = true;
                        ContactGroupMemberInfoProvider.SetContactGroupMemberInfo(cgmi);
                    }
                }
                else
                {
                    RedirectToAccessDenied("CMS.ContactManagement", "ModifyContact or ModifyGroup");
                }
            }

            // Reload unigrid
            LoadContactGroups();
            contactGroups.ReloadData();
            pnlUpdate.Update();
            selectGroup.Value = null;
        }
    }

    #endregion
}