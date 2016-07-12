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
            string codeType = "";       //"CTRY"

            Dictionary<string, string> codeMap = new Dictionary<string, string>(); 
            try {
                codeMap = new Dictionary<string, string>
                    {
                        { "DECL", "Declined/Closed Reason"},
                        { "DIAG", "Diagnostic"},
                        { "INT", "Level of Care/Status"},
                        { "PEND", "Pended Reason"},
                        { "SVCS", "Services" },
                        { "ET", "Service Type"},
                        { "TREL", "Term Relation"},
                        { "ACT", "Activity Type"},
                        { "ASSE", "Assesment Type"},
                        { "CTRY", "Country"},
                        { "ETHN", "Ethnicity"},
                        { "EXCP", "Exception Criteria"},
                        { "FS", "Fee Schedule"},
                        { "GLOB", "Group/Client LOB"},
                        { "PPT", "Group/Client Type"},
                        { "LANG", "Language"},
                        { "NAME", "Name Type"},
                        { "NT", "Note Type"},
                        { "PYRT", "Payor Type"},
                        { "PHON", "Phone Type"},
                        { "PCAT", "Plan Item Type"},
                        { "LOBT", "Plan/LOB Type"},
                        { "LOBS", "Plan/LOB Contract Status"},
                        { "PSS", "Psychological Stressors"},
                        { "REG", "Region"},
                        { "SERV", "Resource Services"},
                        { "ST", "State"},
                        { "GT", "User Group"},
                        { "UACT", "Work Activity"}
                    };
                }   catch(Exception e) { ; }


            if (Request.QueryString["menu"] != null)
            {
                tableName = Request.QueryString["menu"].ToString();
            }

            if (Request.QueryString["code"] != null)
            {
                codeType = Request.QueryString["code"].ToString();
            }
            
            string stoken = string.Empty;
            string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : stoken;
            string searchTarget = string.IsNullOrEmpty(searchText) ? stoken : searchText;

            ListViewModel ViewModelListOutput = new ListViewModel();
            ViewModelListOutput.ListType = tableName;
            ViewModelListOutput.TableName = tableName;
            ViewModelListOutput.SearchText = searchText;        //@ assin searchTarget instead of searchText to force non-blank predicate

            string codename = codeType;
            try { codename = codeMap[codeType.ToUpper()]; } 
            catch (Exception e) {; }

            ViewModelListOutput.codeType = codeType;
            ViewModelListOutput.Caption = codename + " Codes";

            var dataContext = new CMADataContext();
            ViewModelListOutput.TableHeaders = GetTableHeaders(dataContext, tableName);
            string TableData = string.Empty;
            switch (tableName.ToUpper())
            {
                case "CODES":

                    var q0 = dataContext.CODEs.AsQueryable();

                    //  searchText = "a";

/***
                    var c0 = q0.Where(co => co.Type == codeType)
                      .Select(co => new { co.Code1, co.Description })
                      .OrderBy(co => co.Code1);
***/

                    var l0 = dataContext.CODEs.AsQueryable();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        l0 = l0.Where(_ => SqlMethods.Like(_.Code1, "%" + searchText + "%")
                           || SqlMethods.Like(_.Description, "%" + searchText + "%")
                           && Equals(_.Type, codeType));
                    }
                    else
                    {
                        l0 = l0.Where(_ => _.Type == codeType)
                                .OrderBy(co => co.Code1);
                    }

                    TableData = JsonConvert.SerializeObject(l0.OrderBy(_ => _.Code1).ToList());
                    // TableData = JsonConvert.SerializeObject(c0.ToList());
                    break;

                case "CPT":
                    var l1 = dataContext.CPTs.AsQueryable();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        l1 = l1.Where(_ => SqlMethods.Like(_.CPT1, "%" + searchText + "%")
                                        || SqlMethods.Like(_.Description, "%" + searchText + "%"));
                    } else
                    {
                        l1 = l1.Where(_ => false);
                    }
                    TableData = JsonConvert.SerializeObject(l1.OrderBy(_ => _.CPT1).ToList());
                    break;
                case "EPISODE":
                    var l2 = dataContext.Episodes.AsQueryable();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        l2 = l2.Where(_ => SqlMethods.Like(_.Description, "%" + searchText + "%")
                                        || SqlMethods.Like(_.Comment, "%" + searchText + "%")
                                        || SqlMethods.Like(_.EpisodeID, "%" + searchText + "%")
                                        || SqlMethods.Like(_.EpisodeNo, "%" + searchText + "%"));

                    } else
                    {
                        l2 = l2.Where(_ => false);
                    }
                    TableData = JsonConvert.SerializeObject(l2.OrderByDescending(_ => _.ChgStamp).ToList());
                    break;

                case "ICD":
                    var l3 = dataContext.ICDs.AsQueryable();
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        l3 = l3.Where(_ => SqlMethods.Like(_.Description, "%" + searchText + "%")
                                        || SqlMethods.Like(_.Notes, "%" + searchText + "%"));
                    } else
                    {
                        l3 = l3.Where(_ => false);
                    }
                    TableData = JsonConvert.SerializeObject(l3.OrderBy(_ => _.ICD1).ToList());
                    break;

                default:
                    break;
            }
            // ViewData["ListOutputHeaders"] = JsonConvert.SerializeObject(ViewModelListOutput);
            // ViewData["ListOutputData"] = TableData;
            ViewModelListOutput.TableData = TableData;    
            dataContext.Dispose();

            if (Request.IsAjaxRequest())
                return PartialView("~/Views/Manage/Controls/List.ascx", ViewModelListOutput);

            return View(ViewModelListOutput);
        }

        [HttpPost]
        public ActionResult SaveRecord()
        {
            string tableName = Request.Form["tableName"] != null ? Request.Form["tableName"].ToString().Trim() : string.Empty;
            string codeType = Request.Form["code"] != null ? Request.Form["code"].ToString().Trim() : string.Empty;
            string id = Request.Form["recordId"] != null ? Request.Form["recordId"].ToString().Trim() : string.Empty;
            string columnList = Request.Form["columnList"] != null ? Request.Form["columnList"].ToString().Trim() : string.Empty;
            string nonStringColumnList = Request.Form["nonStringColumnList"] != null ? "," + Request.Form["nonStringColumnList"].ToString().Trim() + "," : string.Empty;
            string primaryKey = Request.Form["primaryKey"] != null ? Request.Form["primaryKey"].ToString().Trim() : string.Empty;

            string replacedPrimaryKey = CMAHelper.ReplaceWithFriendlyName(primaryKey);


            string errorMessage = string.Empty;
            bool isUpdate = false;

            if (string.IsNullOrEmpty(tableName) || string.IsNullOrEmpty(primaryKey) || (!string.IsNullOrEmpty(columnList) && !columnList.Contains(",")))
                errorMessage = "Error Saving the Record.";
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
                            sql = "select top 1 " + replacedPrimaryKey + " from dbo." + tableName + " with (NOLOCK) where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);
                        else
                            sql = "select top 1 " + replacedPrimaryKey + " from dbo." + tableName + " with (NOLOCK) where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(primaryKeyValue);

                        if (!string.IsNullOrEmpty(codeType))
                            sql += " and Type=" + SQLHelper.MakeSQLSafe(codeType);


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
                                if (nonStringColumnList.Contains("," + col + ","))
                                    sql += CMAHelper.ReplaceWithFriendlyName(col) + "=" + (Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : "NULL") + "," + Environment.NewLine;
                                else
                                    sql += CMAHelper.ReplaceWithFriendlyName(col) + "=" + SQLHelper.MakeSQLSafe(Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : string.Empty) + "," + Environment.NewLine;
                            }
                            sql = sql.Trim();

                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);
                            sql += " where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);

                            if (!string.IsNullOrEmpty(codeType))
                                sql += " and Type=" + SQLHelper.MakeSQLSafe(codeType);
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(codeType))
                                sql = "insert into dbo." + tableName + "(type," + columnList + ")values(" + Environment.NewLine + SQLHelper.MakeSQLSafe(codeType) + "," ;
                            else
                                sql = "insert into dbo." + tableName + "(" + columnList + ")values(" + Environment.NewLine;

                            foreach (var col in columnList.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                            {
                                if (nonStringColumnList.Contains("," + col + ","))
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
            string tableName = Request.Form["table-name"] != null ? Request.Form["table-name"].ToString().Trim() : string.Empty;
            string key = Request.Form["id"] != null ? Request.Form["id"].ToString().Trim() : string.Empty;

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
                            if (rec != null)
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

//=======


        public List<TableHeaders> GetTableHeaders(CMADataContext dataContext, string tableName)
        {
            List<TableHeaders> tableHeaders = new List<TableHeaders>();
            List<TableHeaders> displayHeaders = new List<TableHeaders>();

            if (dataContext != null)
            {
                foreach (var table in dataContext.Mapping.GetTables())
                {
                    if (string.Equals(table.TableName, "dbo." + tableName))
                    {
                        foreach (var col in table.RowType.DataMembers)
                        {
                            TableHeaders row = new TableHeaders();
//@x                         row.ColumnName = col.MappedName;
                            row.ColumnName = col.Name;
                            row.IsPrimaryKey = col.IsPrimaryKey;
                            string dbType;
                            int length;
                            GetDatabaseType(col.DbType, out dbType, out length);
                            row.Length = length;
                            row.DataType = dbType;
                            row.Required = !col.CanBeNull;

                            row.DisplayLength = length;
                            row.Caption = col.Name;
                            row.ReadOnly = false;
                            tableHeaders.Add(row);
                        }
                    }
                }
            }

            displayHeaders = filterList(tableHeaders, tableName);


            return displayHeaders;
            //@ return tableHeaders;
        }

        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public int Length { get; set; }
        public bool Required { get; set; }
        public bool IsPrimaryKey { get; set; }

        public string Caption;
        public int DisplayLength;
        public bool ReadOnly;


        List<TableHeaders> filterList(List<TableHeaders> headers,  string source)
        {
            List<TableHeaders> displayHeaders = new List<TableHeaders>();
            foreach (TableHeaders th in headers)
            {
                TableHeaders row = th;
                switch (source)
                {
                    case "CODES":
                        switch (th.ColumnName) {

/**                            case "Type":
///                                row.Caption = "CodeType";
                                displayHeaders.Add(row);
                                break;
**/
                            case "Code1":
                                row.Caption = "Code";
                                displayHeaders.Add(row);
                                break;
                            case "Description":
///                                row.Caption = "Description";
                                displayHeaders.Add(row);
                                break;
                        }
                        break;
                    default:
                        displayHeaders.Add(row);
                        break;
                }


            }

            return displayHeaders;
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

        int ProcessCodeType(string codeType)
        {
            int ri=0;
            switch(codeType)
            {
                case "ACT":
                    ;
                    break;
            }

            return ri;
        }
    }
}
