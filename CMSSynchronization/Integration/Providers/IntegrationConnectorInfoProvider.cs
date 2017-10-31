using CMS.DataEngine;
using CMS.SettingsProvider;

namespace CMS.Synchronization
{
    using TypedDataSet = InfoDataSet<IntegrationConnectorInfo>;

    /// <summary>
    /// Class providing IntegrationConnectorInfo management.
    /// </summary>
    public class IntegrationConnectorInfoProvider : AbstractInfoProvider<IntegrationConnectorInfo, IntegrationConnectorInfoProvider>
    {
        #region "Constructors"

        /// <summary>
        /// Constructor
        /// </summary>
        public IntegrationConnectorInfoProvider()
            : base(true, true, false, LoadHashtableEnum.All)
        {
        }

        #endregion


        #region "Public methods - Basic"

        /// <summary>
        /// Returns dataset of all integration connectors matching the specified parameters.
        /// </summary>
        /// <param name="where">Where condition.</param>
        /// <param name="orderBy">Order by expression.</param>
        /// <param name="topN">Number of records to be selected.</param>        
        /// <param name="columns">Columns to be selected.</param>
        public static TypedDataSet GetIntegrationConnectors(string where, string orderBy, int topN, string columns)
        {
            return ProviderObject.GetIntegrationConnectorsInternal(where, orderBy, topN, columns);
        }


        /// <summary>
        /// Returns dataset of all integration connectors matching the specified parameters.
        /// </summary>
        /// <param name="where">Where condition.</param>
        /// <param name="orderBy">Order by expression.</param>
        public static TypedDataSet GetIntegrationConnectors(string where, string orderBy)
        {
            return ProviderObject.GetIntegrationConnectorsInternal(where, orderBy, -1, null);
        }


        /// <summary>
        /// Returns integration connector with specified ID.
        /// </summary>
        /// <param name="connectorId">Integration connector ID.</param>        
        public static IntegrationConnectorInfo GetIntegrationConnectorInfo(int connectorId)
        {
            return ProviderObject.GetIntegrationConnectorInfoInternal(connectorId);
        }


        /// <summary>
        /// Returns integration connector with specified name.
        /// </summary>
        /// <param name="connectorName">Integration connector name.</param>                
        public static IntegrationConnectorInfo GetIntegrationConnectorInfo(string connectorName)
        {
            return ProviderObject.GetIntegrationConnectorInfoInternal(connectorName);
        }


        /// <summary>
        /// Sets (updates or inserts) specified integration connector.
        /// </summary>
        /// <param name="connectorObj">Integration connector to be set.</param>
        public static void SetIntegrationConnectorInfo(IntegrationConnectorInfo connectorObj)
        {
            ProviderObject.SetIntegrationConnectorInfoInternal(connectorObj);
        }


        /// <summary>
        /// Deletes specified integration connector.
        /// </summary>
        /// <param name="connectorObj">Integration connector to be deleted.</param>
        public static void DeleteIntegrationConnectorInfo(IntegrationConnectorInfo connectorObj)
        {
            ProviderObject.DeleteIntegrationConnectorInfoInternal(connectorObj);
        }


        /// <summary>
        /// Deletes integration connector with specified ID.
        /// </summary>
        /// <param name="connectorId">Integration connector ID.</param>
        public static void DeleteIntegrationConnectorInfo(int connectorId)
        {
            IntegrationConnectorInfo connectorObj = GetIntegrationConnectorInfo(connectorId);
            DeleteIntegrationConnectorInfo(connectorObj);
        }


        /// <summary>
        /// Clears hashtables.
        /// </summary>
        /// <param name="logTasks">If true, web farm tasks are logged.</param>
        public static void Clear(bool logTasks)
        {
            ProviderObject.ClearHashtables(logTasks);

            if (logTasks)
            {
                WebSyncHelperClass.CreateTask(WebFarmTaskTypeEnum.DeleteUnmanagedItem, "ClearIntegrationConnectorInfos", null, null);
            }

            // Clear collections with connectors and subscriptions
            ModuleCommands.SynchronizationInvalidateConnectors();
        }

        #endregion


        #region "Public methods - Advanced"
        // Here come advanced public methods. If there are no advanced public methods, remove the block.
        #endregion


        #region "Internal methods - Basic"

        /// <summary>
        /// Returns dataset of all integration connectors matching the specified parameters.
        /// </summary>
        /// <param name="where">Where condition.</param>
        /// <param name="orderBy">Order by expression.</param>
        /// <param name="topN">Number of records to be selected.</param>        
        /// <param name="columns">Columns to be selected.</param>
        protected virtual TypedDataSet GetIntegrationConnectorsInternal(string where, string orderBy, int topN, string columns)
        {
            return GetData(null, where, orderBy, topN, columns, true);
        }


        /// <summary>
        /// Returns integration connector with specified ID.
        /// </summary>
        /// <param name="connectorId">Integration connector ID.</param>        
        protected virtual IntegrationConnectorInfo GetIntegrationConnectorInfoInternal(int connectorId)
        {
            return GetInfoById(connectorId, true);
        }


        /// <summary>
        /// Returns integration connector with specified name.
        /// </summary>
        /// <param name="connectorName">Integration connector name.</param>        
        protected virtual IntegrationConnectorInfo GetIntegrationConnectorInfoInternal(string connectorName)
        {
            return GetInfoByCodeName(connectorName, true);
        }


        /// <summary>
        /// Sets (updates or inserts) specified integration connector.
        /// </summary>
        /// <param name="connectorObj">Integration connector to be set.</param>        
        protected virtual void SetIntegrationConnectorInfoInternal(IntegrationConnectorInfo connectorObj)
        {
            SetInfo(connectorObj);
            if (connectorObj != null)
            {
                Clear(connectorObj.Generalized.LogWebFarmTasks);
            }
        }


        /// <summary>
        /// Deletes specified integration connector.
        /// </summary>
        /// <param name="connectorObj">Integration connector to be deleted.</param>        
        protected virtual void DeleteIntegrationConnectorInfoInternal(IntegrationConnectorInfo connectorObj)
        {
            DeleteInfo(connectorObj);
            if (connectorObj != null)
            {
                Clear(connectorObj.Generalized.LogWebFarmTasks);
            }
        }

        #endregion


        #region "Internal methods - Advanced"
        // Here come advanced internal methods. If there are no advanced internal methods, remove the block.
        #endregion
    }
}