using System;
using System.Linq;
using System.Web.Mvc;
using CMA.WebUI.Models;
using System.Configuration;
using System.Text;
using CMA.WebUI.ViewModels;
using CMA.WebUI.Helpers;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Net;
using System.Data.Linq.SqlClient;

namespace CMA.WebUI.Controllers
{
    public class ManageController : Controller
    {
        public ActionResult Home()
        {   
            return View();
        }

        public ActionResult Case()
        {
            return View();
        }

        public ActionResult Documents()
        {
            return View();
        }
        public ActionResult Notes()
        {
            return View();
        }

        public ActionResult List()
        {   
            string tableName = "CPT";
            if (Request.QueryString["menu"] != null)
                tableName = Request.QueryString["menu"].ToString();
            string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;


            ListViewModel ViewModelListOutput = new ListViewModel();
            ViewModelListOutput.ListType = tableName;
            ViewModelListOutput.TableName = tableName;
            ViewModelListOutput.SearchText = searchText;

            var dataContext = new CMADataContext();
            ViewModelListOutput.TableHeaders = GetTableHeaders(dataContext, tableName);
            string TableData = string.Empty;
            switch(tableName.ToUpper())
            {
                case "CPT":
                    var list = dataContext.CPTs.AsQueryable();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        list = list.Where(_ => SqlMethods.Like(_.CPT1, "%" + searchText + "%")
                                        || SqlMethods.Like(_.Description, "%" + searchText + "%")
                                        || SqlMethods.Like(_.CodeSource, "%" + searchText + "%")
                                        || SqlMethods.Like(_.SyncStamp, "%" + searchText + "%")
                                        || SqlMethods.Like(_.OrgStamp, "%" + searchText + "%")); 
                    }
                    TableData = JsonConvert.SerializeObject(list.OrderBy(_ => _.CPT1).ToList());
                    break;
                default:
                    break;
            }
            //ViewData["ListOutputHeaders"] = JsonConvert.SerializeObject(ViewModelListOutput);
            //ViewData["ListOutputData"] = TableData;
            ViewModelListOutput.TableData = TableData;
            dataContext.Dispose();

            if (Request.IsAjaxRequest())
                return PartialView("~/Views/Manage/Controls/List.ascx", ViewModelListOutput);

            return View(ViewModelListOutput);
        }

        [HttpPost]
        public ActionResult SaveRecord()
        {
            string tableName = Request.Form["tableName"]!=null ? Request.Form["tableName"].ToString().Trim() : string.Empty;
            string id = Request.Form["recordId"]!=null ?Request.Form["recordId"].ToString().Trim() : string.Empty ;
            string columnList = Request.Form["columnList"]!=null ?Request.Form["columnList"].ToString().Trim() : string.Empty ;
            string nonStringColumnList = Request.Form["nonStringColumnList"]!=null ? "," + Request.Form["nonStringColumnList"].ToString().Trim() +"," : string.Empty ;
            string primaryKey = Request.Form["primaryKey"]!=null ?Request.Form["primaryKey"].ToString().Trim() : string.Empty ;
            string errorMessage = string.Empty;
            bool isUpdate = false;

            if (string.IsNullOrEmpty(tableName) || string.IsNullOrEmpty(primaryKey) || (!string.IsNullOrEmpty(columnList) && !columnList.Contains(",")))
                errorMessage= "Error Saving the Record.";
            if (string.IsNullOrEmpty(errorMessage))
            {
                if (!string.IsNullOrEmpty(id))
                    isUpdate = true;

                string primaryKeyValue = Request.Form["txt" + primaryKey] != null ?
                                                Request.Form["txt" + primaryKey].ToString() : string.Empty;

                string updatePrimaryKeyValue = Request.Form["primaryKeyValue"] != null ?
                                                Request.Form["primaryKeyValue"].ToString() : string.Empty;

                if (isUpdate && string.IsNullOrEmpty(updatePrimaryKeyValue))
                    errorMessage = "Missing Primary Key for the Record.";
                if (string.IsNullOrEmpty(primaryKeyValue))
                    errorMessage = "Missing Primary Key for the Record. Please add one.";


                if (string.IsNullOrEmpty(errorMessage))
                {
                    var dataContext = new CMADataContext();
                    try
                    {
                        string sql = string.Empty;
                        if (isUpdate)
                            sql = "select top 1 " + primaryKey + " from dbo." + tableName + " with (NOLOCK) where " + primaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);
                        else
                            sql = "select top 1 " + primaryKey + " from dbo." + tableName + " with (NOLOCK) where " + primaryKey + "=" + SQLHelper.MakeSQLSafe(primaryKeyValue);

                        var rec = dataContext.ExecuteQuery<dynamic>(sql);

                        if (isUpdate && !rec.Any()) // Make sure this record dont exist as its a primary Key
                            errorMessage = "Error Updating the Record";
                        else if (!isUpdate && rec.Any())
                            errorMessage = "Record exists for this Key " + primaryKeyValue;


                        if (isUpdate)
                        {
                            sql = "update dbo." + tableName + Environment.NewLine + "set ";
                            foreach (var col in columnList.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                            {
                                 if  (nonStringColumnList.Contains("," + col + ","))
                                    sql += col + "=" + (Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : "NULL") + "," + Environment.NewLine;
                                else
                                    sql += col + "=" + SQLHelper.MakeSQLSafe(Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : string.Empty) + "," + Environment.NewLine;
                            }
                            sql = sql.Trim();

                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);
                            sql += " where " + primaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);
                        }
                        else
                        {
                            sql = "insert into dbo." + tableName + "(" + columnList + ")values(" + Environment.NewLine;
                            foreach (var col in columnList.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                            {   
                                if  (nonStringColumnList.Contains("," + col + ","))
                                    sql += (Request.Form["txt" + col] != null ? Request.Form["txt" + col] : "NULL") + ",";
                                else
                                    sql += SQLHelper.MakeSQLSafe(Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : string.Empty) + ",";
                            }
                            sql = sql.Trim();

                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);

                            sql += ");";
                        }
                        dataContext.ExecuteQuery<dynamic>(sql);

                        dataContext.SubmitChanges();
                    }
                    catch (Exception ex)
                    {
                        errorMessage = ex.Message;
                    }
                    finally
                    {
                        dataContext.Dispose();
                    }
                }
            }

            if (!string.IsNullOrEmpty(errorMessage))
            {
                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                Response.StatusDescription = errorMessage;
                Response.Write(errorMessage);
            }

            return null; 
        }

        [HttpPost]
        public ActionResult DeleteRecord()
        {
            string tableName = Request.Form["table-name"]!=null ? Request.Form["table-name"].ToString().Trim() : string.Empty;
            string key = Request.Form["id"]!=null ?Request.Form["id"].ToString().Trim() : string.Empty ;

            if (string.IsNullOrEmpty(tableName) || string.IsNullOrEmpty(key))
            {
                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                Response.StatusDescription = "Error Deleting the Record.";
                Response.Write("Error Deleting the Record.");
            }
            else
            {
                var dataContext = new CMADataContext();
                switch (tableName.ToUpper())
                {
                    case "CPT":
                        {
                            var rec = dataContext.CPTs.FirstOrDefault(_ => _.CPT1 == key);
                            if (rec!=null)
                                dataContext.CPTs.DeleteOnSubmit(rec);
                            break;
                        }
                    default:
                        break;
                }
                dataContext.SubmitChanges();
                dataContext.Dispose();
            }
            return null;
        }

        public List<TableHeaders> GetTableHeaders(CMADataContext dataContext, string tableName)
        {
            List<TableHeaders> tableHeaders = new List<TableHeaders>();

            if (dataContext != null)
            {
                foreach (var table in dataContext.Mapping.GetTables())
                {
                    if (string.Equals(table.TableName, "dbo." + tableName))
                    {
                        foreach (var col in table.RowType.DataMembers)
                        {
                            TableHeaders row = new TableHeaders();
                            row.ColumnName = col.MappedName;
                            row.IsPrimaryKey = col.IsPrimaryKey;
                            string dbType;
                            int length;
                            GetDatabaseType(col.DbType, out dbType, out length);
                            row.Length = length;
                            row.DataType = dbType;
                            row.Required = !col.CanBeNull;
                            tableHeaders.Add(row);
                        }
                    }
                }
            }
            return tableHeaders;
        }

        public void GetDatabaseType(string input, out string output, out int length)
        {
            output = "VARCHAR(MAX)";
            length = 0;
            var dbarr = input.Split(' ');

            if (dbarr.Length > 0)
            {
                string type = dbarr[0].ToUpper();
                if (type.Contains("("))
                    type = type.Substring(0, type.IndexOf("("));
                switch (type)
                {
                    case "VARCHAR":
                    case "CHAR":
                        output = type;
                        length = int.Parse(dbarr[0].ToUpper().Replace(type + "(", "").Replace(")", ""));
                        break;
                    case "INT":
                    case "DECIMAL":
                    case "MONEY":
                    case "FLOAT":
                        output = type;
                        break;

                }

            }
        }
    }
}
