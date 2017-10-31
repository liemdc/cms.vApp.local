using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public class VTSqlHelper : System.Web.UI.Page
{
    /// <summary>
    /// Get Sql Connection in Web.config
    /// </summary>
    public static string GetConnection
    {
        get
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["CMSConnectionString"].ConnectionString;
        }
    }

    /// <summary>
    /// Execute an update store
    /// </summary>
    /// <param name="storeName">Store procedure name</param>
    /// <param name="pars">Sql Parameter command</param>
    /// <returns></returns>
    public static int ExecuteNonQuery(string storeName, SqlParameter[] pars)
    {
        if (string.IsNullOrEmpty(storeName))
            return 0;
        else
            return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(GetConnection, CommandType.StoredProcedure, storeName, pars);
    }

    /// <summary>
    /// Execute an command text
    /// </summary>
    /// <param name="commandText"></param>
    /// <returns></returns>
    public static int ExecuteNonQuery(string commandText)
    {
        if (string.IsNullOrEmpty(commandText))
            return 0;
        else
            return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(GetConnection, CommandType.Text, commandText);
    }

    /// <summary>
    /// Get DataTable by Store Procedure
    /// </summary>
    /// <param name="storeName"></param>
    /// <param name="pars"></param>
    /// <returns></returns>
    public static DataTable ExecuteDataTable(string storeName, SqlParameter[] pars)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(GetConnection, CommandType.StoredProcedure, storeName, pars).Tables[0];
    }

    /// <summary>
    /// Get DataTable by command text
    /// </summary>
    /// <param name="commandLine"></param>
    /// <returns></returns>
    public static DataTable ExecuteDataTable(string commandText)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(GetConnection, CommandType.Text, commandText).Tables[0];
    }

    /// <summary>
    /// Get as SqlDataReader
    /// </summary>
    /// <param name="commandText">command text</param>
    /// <returns></returns>
    public static SqlDataReader ExecuteDataReader(string commandText)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(GetConnection, CommandType.Text, commandText);
    }

    /// <summary>
    /// Get as SqlDataReader
    /// </summary>
    /// <param name="storeName">store name</param>
    /// <param name="pars"></param>
    /// <returns></returns>
    public static SqlDataReader ExecuteDataReader(string storeName, SqlParameter[] pars)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(GetConnection, CommandType.StoredProcedure, storeName, pars);
    }

    /// <summary>
    /// Get as Object
    /// </summary>
    /// <param name="storeName"></param>
    /// <param name="pars"></param>
    /// <returns></returns>
    public static object ExecuteScalar(string storeName, SqlParameter[] pars)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteScalar(GetConnection, CommandType.StoredProcedure, storeName, pars);
    }

    /// <summary>
    /// Get as object
    /// </summary>
    /// <param name="commandText"></param>
    /// <returns></returns>
    public static object ExecuteScalar(string commandText)
    {
        return Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteScalar(GetConnection, CommandType.Text, commandText);
    }
}

