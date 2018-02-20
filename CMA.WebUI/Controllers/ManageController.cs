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
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml;
using System.Reflection;

namespace CMA.WebUI.Controllers
{
    public class ManageController : Controller
    {
        [Authorize]
        public ActionResult Home()
        {   
            return View();
        }
       
        [Authorize]
        public ActionResult Notes()
        {
            return View();
        }


        [HttpPost]
        [Authorize]

        public ActionResult GetCaseSearch()
        {
            var searchText = Request.Form["SearchText"] != null ? Request.Form["SearchText"].ToString().Trim().ToLower() : string.Empty;
            bool includeFirstName = false;
            if (Request.Form["IncludeFirstName"] != null && Request.Form["IncludeFirstName"].ToString() == "1")
                includeFirstName = true;

            if (!string.IsNullOrEmpty(searchText))
            {
                var dataContext = new CMADataContext();
                string lastName = string.Empty;
                string firstName = string.Empty;
                if (includeFirstName && searchText.Contains(" "))
                {
                    lastName = searchText.Substring(0, searchText.IndexOf(" "));
                    firstName = searchText.Substring(searchText.IndexOf(" ") + 1);
                }
                else
                    lastName = searchText;

                var query = dataContext.Namezs.Where(_ =>
                                 _.NameIs.HasValue &&
                                 _.NameIs.Value == 1
                                 && (
                                    SqlMethods.Like(_.LastName, "%" + lastName + "%"))
                            );
                if (includeFirstName)
                    query = query.Where(_ =>
                                SqlMethods.Like(_.FirstName, "%" + firstName + "%")
                            );

                var results = query.OrderBy(_=>_.LastName).ThenBy(_=>_.FirstName).ToList();

                ViewData["FindCaseSearchOutput"] = results;
                dataContext.Dispose();
                return PartialView("~/Views/Manage/Controls/Find-Case-Result.ascx");
            }
            return null;
        }
        [HttpPost]
        [Authorize]
        public ActionResult GetEdit()
        {
            ListInput inputParam = new ListInput();
            bool isEdit = Request.Form["edit"] != null ? Request.Form["edit"].ToString() == "1" : false;
            var type = Request.Form["type"] != null ? Request.Form["type"].ToString() : string.Empty;
            string key = Request.Form["key"] != null ? Request.Form["key"].ToString() : string.Empty;
            string value = Request.Form["val"] != null ? Request.Form["val"].ToString() : string.Empty;
            inputParam.Menu = Request.Form["menu"] != null ? Request.Form["menu"].ToString() : string.Empty;
            inputParam.TableName = Request.Form["table"] != null ? Request.Form["table"].ToString() : string.Empty;
            inputParam.SubQuery = Request.Form["subquery"] != null ? Request.Form["subquery"].ToString() : string.Empty;
            inputParam.Type = type;
            inputParam.ContainerId = Request.Form["id"] != null ? Request.Form["id"].ToString() : string.Empty;
            ListViewModel viewModel = new ListViewModel();
            viewModel.InputParam = inputParam;
            int MaxListRecord = 0;

            if (string.Equals(type, "list", StringComparison.InvariantCultureIgnoreCase))
            {
                viewModel.TableName = inputParam.TableName;
                if (isEdit)
                    viewModel.Caption = "Edit Record for " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                else
                    viewModel.Caption = "Add Record for " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                viewModel.DataColumns = InitializeDataMapping(inputParam, out MaxListRecord);
                viewModel.MaxListRecords = MaxListRecord;

                if (isEdit)
                    viewModel.TableData = GetDataFromDB(viewModel, value);



                return PartialView("~/Views/Manage/Controls/Edit.ascx", viewModel);
            }
            else
                return null;
        }
        [HttpPost]
        [Authorize]
        public ActionResult GetWindow()
        {
            ListInput inputParam = new ListInput();
            var type = Request.Form["type"] != null ? Request.Form["type"].ToString() : string.Empty;
            inputParam.TableName = Request.Form["table"] != null ? Request.Form["table"].ToString() : string.Empty;
            inputParam.SubQuery = Request.Form["subquery"] != null ? Request.Form["subquery"].ToString() : string.Empty;
            inputParam.Menu = Request.Form["menu"] != null ? Request.Form["menu"].ToString() : string.Empty;
            inputParam.ContainerId = Request.Form["id"] != null ? Request.Form["id"].ToString() : string.Empty;
            inputParam.Type = type;

            int NameID = 0;
            if (Request.Form["NameID"] != null)
                int.TryParse(Request.Form["NameID"].ToString(), out NameID);

            if (string.Equals(type, "manage-case", StringComparison.InvariantCultureIgnoreCase) 
                    && NameID==0)
            {
                inputParam.TableName = "find_case";
                inputParam.Menu = "Find Case";
            } 

            ListViewModel viewModel = new ListViewModel();
            viewModel.InputParam = inputParam;
            int MaxListRecords = 0;

            if (string.Equals(type, "list", StringComparison.InvariantCultureIgnoreCase))
            {
                if (string.Equals(inputParam.TableName, "find_case", StringComparison.CurrentCultureIgnoreCase))
                {
                    string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;
                    viewModel.TableName = inputParam.TableName;
                    viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                    viewModel.SearchText = searchText.Trim();
                    return PartialView("~/Views/Manage/Controls/Find.ascx", viewModel);
                }
                else
                {
                    string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;
                    viewModel.TableName = inputParam.TableName;
                    viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                    viewModel.SearchText = searchText.Trim();
                    viewModel.DataColumns = InitializeDataMapping(inputParam, out MaxListRecords);
                    viewModel.MaxListRecords = MaxListRecords;
                    viewModel.TableData = GetDataFromDB(viewModel);
                    return PartialView("~/Views/Manage/Controls/List.ascx", viewModel);
                }
            }
            else if (string.Equals(type, "manage-case", StringComparison.InvariantCultureIgnoreCase))
            {
                InitializeCaseWindow(NameID);
                SetEpisodeIDForName(NameID);
                string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;
                viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                viewModel.SearchText = searchText.Trim();
                return PartialView("~/Views/Manage/Controls/ManageCase.ascx", viewModel);
            }
            else if (string.Equals(type, "manage-document", StringComparison.InvariantCultureIgnoreCase))
            {
                InitializeDocumentWindow(NameID);
                string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;
                viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                viewModel.SearchText = searchText.Trim();
                return PartialView("~/Views/Manage/Controls/ManageDocument.ascx", viewModel);
            }
            else if (string.Equals(type, "manage-activity", StringComparison.InvariantCultureIgnoreCase))
            {
                InitializeActivityWindow(NameID);
                string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : string.Empty;
                viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                viewModel.SearchText = searchText.Trim();
                return PartialView("~/Views/Manage/Controls/ManageActivity.ascx", viewModel);
            }
            else
                return null;
        }
        [HttpPost]
        [Authorize]
        public ActionResult DeleteRecord()
        {
            ListInput inputParam = new ListInput();
            var type = Request.Form["type"] != null ? Request.Form["type"].ToString() : string.Empty;
            string key = Request.Form["key"] != null ? Request.Form["key"].ToString() : string.Empty;
            string value = Request.Form["val"] != null ? Request.Form["val"].ToString() : string.Empty;
            inputParam.Menu = Request.Form["menu"] != null ? Request.Form["menu"].ToString() : string.Empty;
            inputParam.TableName = Request.Form["table"] != null ? Request.Form["table"].ToString() : string.Empty;
            inputParam.SubQuery = Request.Form["subquery"] != null ? Request.Form["subquery"].ToString() : string.Empty;
            inputParam.Type = type;
            inputParam.ContainerId = Request.Form["id"] != null ? Request.Form["id"].ToString() : string.Empty;
            int MaxListRecord = 0;
            ListViewModel viewModel = new ListViewModel();
            viewModel.InputParam = inputParam;

            if (string.Equals(type, "list", StringComparison.InvariantCultureIgnoreCase))
            {
                viewModel.TableName = inputParam.TableName;
                DeleteRecordFromDB(viewModel, value, viewModel.InputParam.SubQuery);
                viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                viewModel.SearchText = string.Empty;
                viewModel.DataColumns = InitializeDataMapping(inputParam, out MaxListRecord);
                viewModel.MaxListRecords = MaxListRecord;
                viewModel.TableData = GetDataFromDB(viewModel);
                return PartialView("~/Views/Manage/Controls/List.ascx", viewModel);
            }
            else
                return null;
        }

        [HttpPost]
        [Authorize]
        public ActionResult SaveRecord()
        {
            ListInput inputParam = new ListInput();
            var type = Request.Form["type"] != null ? Request.Form["type"].ToString() : string.Empty;
            inputParam.TableName = Request.Form["table"] != null ? Request.Form["table"].ToString() : string.Empty;
            inputParam.SubQuery = Request.Form["subquery"] != null ? Request.Form["subquery"].ToString() : string.Empty;
            inputParam.Menu = Request.Form["menu"] != null ? Request.Form["menu"].ToString() : string.Empty;
            inputParam.ContainerId = Request.Form["id"] != null ? Request.Form["id"].ToString() : string.Empty;
            inputParam.Type = type;

            ListViewModel viewModel = new ListViewModel();
            viewModel.InputParam = inputParam;
            viewModel.TableName = inputParam.TableName;
            string errorMessage = string.Empty;
            int MaxListRecord = 0;

            if (string.Equals(type, "list", StringComparison.InvariantCultureIgnoreCase))
            {
                string pkey = Request.Form["pkey"] != null ? Request.Form["pkey"].ToString().Trim() : string.Empty;
                string pkeyValue = Request.Form["pkeyValue"] != null ? Request.Form["pkeyValue"].ToString().Trim() : string.Empty;
                bool isUpdate = !string.IsNullOrEmpty(pkey) && !string.IsNullOrEmpty(pkeyValue) ? true : false;
                viewModel.DataColumns = InitializeDataMapping(inputParam, out MaxListRecord);
                viewModel.MaxListRecords = MaxListRecord;
                string sql = string.Empty;

                var dataContext = new CMADataContext();
                IEnumerable<dynamic> rec;
                if (isUpdate)
                {
                    sql = "select top 1 " + pkey + " from dbo." + viewModel.TableName + " where " + pkey + "=" + SQLHelper.MakeSQLSafe(pkeyValue);
                    if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery))
                        sql += " and type=" + SQLHelper.MakeSQLSafe(viewModel.InputParam.SubQuery);

                    rec = dataContext.ExecuteQuery<dynamic>(sql);
                    if (isUpdate && !rec.Any()) // Make sure this record dont exist as its a primary Key
                        errorMessage = "No Record Found to Update";
                }

                if (string.IsNullOrEmpty(errorMessage))
                {
                    string updateKeyValue = Request.Form["txt-" + viewModel.InputParam.ContainerId + "-" + viewModel.DataColumns.Where(_ => _.IsPrimaryKey).FirstOrDefault().DBColumnName].ToString();
                    if (isUpdate && !string.Equals(pkeyValue, updateKeyValue, StringComparison.InvariantCultureIgnoreCase) || !isUpdate)
                    {
                        sql = "select top 1 " + pkey + " from dbo." + viewModel.TableName + " where " + pkey + "=" + SQLHelper.MakeSQLSafe(updateKeyValue);
                        if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery))
                            sql += " and type=" + SQLHelper.MakeSQLSafe(viewModel.InputParam.SubQuery);

                        rec = dataContext.ExecuteQuery<dynamic>(sql);
                        if (rec != null && rec.Any()) // Make sure this record dont exist as its a primary Key
                            errorMessage = "Record Already Exists for the " + pkey + ".";
                    }

                    if (string.IsNullOrEmpty(errorMessage))
                    {
                        if (isUpdate)
                        {
                            sql = "update dbo." + viewModel.TableName + Environment.NewLine + "set ";
                            foreach (var col in viewModel.DataColumns)
                            {
                                sql += col.DBColumnName + "=" + SQLHelper.MakeSQLSafe(Request.Form["txt-" + viewModel.InputParam.ContainerId + "-" + col.DBColumnName]) + ",";
                            }
                            sql = sql.Trim();
                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);

                            sql += " where " + pkey + "=" + SQLHelper.MakeSQLSafe(pkeyValue);
                            if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery))
                                sql += " and type=" + SQLHelper.MakeSQLSafe(viewModel.InputParam.SubQuery);

                            dataContext.ExecuteQuery<dynamic>(sql);


                        }
                        else
                        {
                            sql = "insert into " + viewModel.TableName + " (";
                            foreach (var col in viewModel.DataColumns)
                                sql += col.DBColumnName + ",";
                            if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery))
                                sql += "type,";
                            sql = sql.Trim();
                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);
                            sql += ") values(";
                            foreach (var col in viewModel.DataColumns)
                                sql += SQLHelper.MakeSQLSafe(Request.Form["txt-" + viewModel.InputParam.ContainerId + "-" + col.DBColumnName]) + ",";
                            if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery))
                                sql += SQLHelper.MakeSQLSafe(viewModel.InputParam.SubQuery);
                            sql = sql.Trim();
                            if (sql.EndsWith(","))
                                sql = sql.Substring(0, sql.Length - 1);
                            sql += ")";
                            dataContext.ExecuteQuery<dynamic>(sql);
                        }

                        dataContext.Dispose();
                        viewModel.Caption = "Manage " + CMAHelper.ConvertSentenceCase(inputParam.Menu);
                        viewModel.SearchText = string.Empty;
                        viewModel.TableData = GetDataFromDB(viewModel);
                        return PartialView("~/Views/Manage/Controls/List.ascx", viewModel);

                    }
                }
                dataContext.Dispose();

                if (!string.IsNullOrEmpty(errorMessage))
                {
                    Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    Response.StatusDescription = errorMessage;
                    Response.Write(errorMessage);
                }
            }

            return null;
        }

        #region "Private Functions"

        private void SetEpisodeIDForName(int NameID)
        {
            var dataContext = new CMADataContext();
            Namez name = dataContext.Namezs.Where(_ => _.Names_ID == NameID).FirstOrDefault();
            if (name != null)
            {
                var episodes = dataContext.Episodes.Where(_ => _.NameID == name.NameID.Trim()).ToList();
                if (episodes!=null && episodes.Any() && Session["AuthUserID"]!=null)
                {
                    string UserId = Session["AuthUserID"].ToString();
                    var user = dataContext.USER_s.FirstOrDefault(u => u.User_ID == UserId);
                    if (user != null)
                    {
                        // Commenting this out till we are ready.
                        //user.Episode1 = episodes.FirstOrDefault().EpisodeID;
                        //dataContext.SubmitChanges();
                    }
                }
            }
            dataContext.Dispose();
        }
        private void InitializeDocumentWindow(int NameID)
        {
            var dataContext = new CMADataContext();
            Namez name = dataContext.Namezs.Where(_ => _.Names_ID == NameID).FirstOrDefault();
            if (name != null)
            {
                var episodes = dataContext.Episodes.Where(_ => _.NameID == name.NameID.Trim()).ToList();
                List<Document> Documents = dataContext.Documents.Where(_ => episodes.Select(e => e.EpisodeID.Trim()).ToArray().Contains(_.EpisodeID)).ToList();
                List<string> NameIDs = Documents.Where(_ => _.ToNameID != null).Select(_ => _.ToNameID).ToList();
                List<Namez> ToFromNames = dataContext.Namezs.Where(_ => NameIDs.Contains(_.NameID)).ToList();
                List<ORGANIZATION> ToFromOrganization = dataContext.ORGANIZATIONs.Where(_ => ToFromNames.Where(n => n.Organization != null).Select(n => n.Organization).ToList().Contains(_.ORGANIZATION_ID)).ToList();

                ViewData["Name"] = name;
                ViewData["Episodes"] = episodes;
                ViewData["Documents"] = Documents;
                ViewData["ToFromNames"] = ToFromNames;
                ViewData["ToFromOrganization"] = ToFromOrganization;
            }
            dataContext.Dispose();
        }

        private void InitializeActivityWindow(int NameID)
        {
            var dataContext = new CMADataContext();
            Namez name = dataContext.Namezs.Where(_ => _.Names_ID == NameID).FirstOrDefault();
            if (name != null)
            {
                var episodes = dataContext.Episodes.Where(_ => _.NameID == name.NameID.Trim()).ToList();
                List<Activity> Activity = dataContext.Activities.Where(_ => episodes.Select(e => e.EpisodeID.Trim()).ToArray().Contains(_.EpisodeID)).ToList();
                List<ACTCODE> ActivityCodes = dataContext.ACTCODEs.ToList();
                List<CODE> ServiceCodes = dataContext.CODEs.Where(_ => _.Type.ToUpper() == "SVCS").ToList();
                List<Namez> PayorNames = dataContext.Namezs.Where(_ => Activity.Select(a => a.PayorID).Distinct().ToList().Contains(_.NameID)).ToList();
                List<ORGANIZATION> Organizations = dataContext.ORGANIZATIONs.Where(_ => PayorNames.Select(p => p.Organization).ToList().Contains(_.ORGANIZATION_ID)).ToList();


                ViewData["Name"] = name;
                ViewData["Episodes"] = episodes;
                ViewData["Activity"] = Activity;
                ViewData["ActivityCodes"] = ActivityCodes;
                ViewData["ServiceCodes"] = ServiceCodes;
                ViewData["PayorNames"] = PayorNames;
                ViewData["Organizations"] = Organizations;
            }
            dataContext.Dispose();
        }

        private void InitializeCaseWindow(int NameID)
        {
            var dataContext = new CMADataContext();
            Namez name = dataContext.Namezs.Where(_ => _.Names_ID == NameID).FirstOrDefault();
            if (name != null)
            {
                var episodes = dataContext.Episodes.Where(_ => _.NameID == name.NameID.Trim()).ToList();
                var episodeTeams = dataContext.EPI_TEAMs.Where(_ => episodes.Select(e=>e.EpisodeID.Trim()).ToArray().Contains(_.EpisodeID)).ToList();
                List<string> EpisodeTeamNameIDs = episodeTeams.Select(_ => _.NameID.Trim()).ToList();
                List<Namez> EpisodeTeamNames = dataContext.Namezs.Where(_ => EpisodeTeamNameIDs.Contains(_.NameID.Trim())).ToList();
                List<ORGANIZATION> organizations = dataContext.ORGANIZATIONs.Where(_ => EpisodeTeamNames.Select(e => e.Organization).ToArray().Contains(_.ORGANIZATION_ID)).ToList();
                List<BENEFIT> benefits = dataContext.BENEFITs.Where(_ => episodes.Select(e => e.EpisodeID).ToArray().Contains(_.EpisodeID)).ToList();
                List<CODE> relationCodes = dataContext.CODEs.Where(_ => _.Type.ToUpper() == "TREL").ToList();
                List<Epi_CasePhase> servicePhase = dataContext.Epi_CasePhases.Where(_ => episodes.Select(e => e.EpisodeID.Trim()).ToArray().Contains(_.EpisodeID)).ToList();
                List<CODE> servicePhaseServiceTypeCodes = dataContext.CODEs.Where(_ => _.Type.ToUpper() == "ET").ToList();
                List<CODE> servicePhaseReasonCodes = dataContext.CODEs.Where(_ => _.Type.ToUpper() == "DECL").ToList();
                List<Epi_Acuity> levelOfCare = dataContext.Epi_Acuities.Where(_ => episodes.Select(e => e.EpisodeID.Trim()).ToArray().Contains(_.EpisodeID)).ToList();
                List<CODE> levelOfCareCodes = dataContext.CODEs.Where(_ => _.Type.ToUpper() == "INT").ToList();


                ViewData["Name"] = name;
                ViewData["Episodes"] = episodes;
                ViewData["EpisodeTeam"] = episodeTeams;
                ViewData["EpisodeTeamNames"] = EpisodeTeamNames;
                ViewData["EpisodeOrganizations"] = organizations;
                ViewData["Benefits"] = benefits;
                ViewData["RelationCodes"] = relationCodes;
                ViewData["ServicePhase"] = servicePhase;
                ViewData["ServicePhaseServiceTypeCodes"] = servicePhaseServiceTypeCodes;
                ViewData["ServicePhaseReasonCodes"] = servicePhaseReasonCodes;
                ViewData["LevelOfCare"] = levelOfCare;
                ViewData["LevelOfCareCodes"] = levelOfCareCodes;
            }
            dataContext.Dispose();
        }

        private bool DeleteRecordFromDB(ListViewModel viewModel, string value, string subquery)
        {
            bool result = false;
            var dataContext = new CMADataContext();
            switch (viewModel.TableName.ToLower())
            {
                case "codes":
                    var q0 = dataContext.CODEs.AsQueryable().Where(_ => _.Code1 == value && _.Type == subquery);
                    if (q0 != null && q0.Any())
                    {
                        dataContext.CODEs.DeleteAllOnSubmit(q0);
                        dataContext.SubmitChanges();
                    }
                    break;
                default:
                    break;
            }

            dataContext.Dispose();
            return result;
        }

        private string GetDataFromDB(ListViewModel viewModel)
        {
            return GetDataFromDB(viewModel, null);
        }
        private string GetDataFromDB(ListViewModel viewModel, string value)
        {
            var dataContext = new CMADataContext();
            string sql = "select ";
            if (!string.IsNullOrEmpty(viewModel.SearchText))
                sql += " top 1 ";
            else if (viewModel.MaxListRecords > 0)
                sql += " top " + viewModel.MaxListRecords + " ";

            sql += string.Join(",", viewModel.DataColumns.Select(_ => _.DBColumnName).ToList());
            sql += " from dbo." + viewModel.TableName.ToLower() + " with (NOLOCK)";

            bool hasWhereClause = false;
            bool bAddAnd = false;
            if (!string.IsNullOrEmpty(viewModel.InputParam.SubQuery) && viewModel.DataColumns.Where(_ => _.IsSubQuery).Any())
            {

                if (!hasWhereClause)
                {
                    sql += " where ";
                    hasWhereClause = true;
                }
                foreach (var colName in viewModel.DataColumns.Where(_ => _.IsSubQuery))
                    sql += " " + colName.DBColumnName + "=" + SQLHelper.MakeSQLSafe(viewModel.InputParam.SubQuery) + " OR";

                sql = sql.Trim();
                if (sql.EndsWith("OR"))
                    sql = sql.Substring(0, sql.Length - 2);
                bAddAnd = true;
            }

            if (!string.IsNullOrEmpty(value) && viewModel.DataColumns.Where(_ => _.IsPrimaryKey).Any())
            {
                bool bFirstTime = true;
                if (!hasWhereClause)
                {
                    sql += " where ";
                    hasWhereClause = true;
                }
                foreach (var colName in viewModel.DataColumns.Where(_ => _.IsPrimaryKey))
                {
                    if (bAddAnd && bFirstTime)
                        sql += " AND ";
                    sql += " " + colName.DBColumnName + "=" + SQLHelper.MakeSQLSafe(value) + " AND";
                    bFirstTime = false;
                }

                sql = sql.Trim();
                if (sql.EndsWith("AND"))
                    sql = sql.Substring(0, sql.Length - 3);
                bAddAnd = true;
            }

            else if (!string.IsNullOrEmpty(viewModel.SearchText) && viewModel.DataColumns.Where(_ => _.IsSearchAble).Any())
            {
                bool bFirstTime = true;
                if (!hasWhereClause)
                {
                    sql += " where ";
                    hasWhereClause = true;
                }
                foreach (var colName in viewModel.DataColumns.Where(_ => _.IsSearchAble))
                {
                    if (bAddAnd && bFirstTime)
                        sql += " AND ";
                    sql += " " + colName.DBColumnName + " like " + SQLHelper.MakeSQLSafe("%" + viewModel.SearchText + "%") + " OR";
                }

                sql = sql.Trim();
                if (sql.EndsWith("OR"))
                    sql = sql.Substring(0, sql.Length - 2);
                bAddAnd = true;
            }

            if (viewModel.DataColumns.Where(_ => _.OrderBy != null).Any())
            {
                foreach (var colName in viewModel.DataColumns.Where(_ => _.OrderBy != null))
                    sql += colName.OrderBy + ",";
                sql = sql.Trim();
                if (sql.EndsWith(","))
                    sql = sql.Substring(0, sql.Length - 1);
            }

            var dbTabName = dataContext.Mapping.GetTables().Where(_ => _.TableName.ToLower() == "dbo." + viewModel.TableName.ToLower()).FirstOrDefault();
                var output = dataContext.ExecuteQuery(dbTabName.RowType.Type, sql);
            viewModel.TableData = JsonConvert.SerializeObject(output, new JsonSerializerSettings{
                                                                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore});
            dataContext.Dispose();
            return viewModel.TableData;
        }
        private List<DataColumn> InitializeDataMapping(ListInput inputParam, out int MaxListRecords)
        {
            MaxListRecords = int.Parse(ConfigurationManager.AppSettings["MaxListRecods"]);
            List<DataColumn> dataColumns = new List<DataColumn>();
            XDocument xDoc = XDocument.Load(Server.MapPath("~/Models/DataMapping.xml"));
            var datacolumns = from cols in xDoc.Descendants("DataMapping")
                              where cols.Element("Menu").Value.ToLower() == inputParam.Menu.ToLower()
                                    && cols.Element("TableName").Value.ToLower() == inputParam.TableName.ToLower()
                                    && cols.Element("SubQuery").Value.ToLower() == inputParam.SubQuery.ToLower()
                              select cols;

            if (datacolumns != null && datacolumns.Any())
            {
                if (datacolumns.Descendants("MaxRecords") != null && datacolumns.Descendants("MaxRecords").FirstOrDefault() != null)
                    MaxListRecords = int.Parse(datacolumns.Descendants("MaxRecords").FirstOrDefault().Value.ToString());

                foreach (var col in datacolumns.Descendants("DataColumn"))
                {
                    DataColumn column = new DataColumn();
                    column.DBColumnName = col.Element("DBColumnName").Value;
                    column.DisplayName = col.Element("DisplayName").Value;
                    column.MaxLength = col.Element("MaxLength") != null ? int.Parse(col.Element("MaxLength").Value) : 0;
                    column.ReadOnly = col.Element("ReadOnly") != null ? bool.Parse(col.Element("ReadOnly").Value) : false; // All fields are updatable unless specified
                    column.IsPrimaryKey = col.Element("IsPrimaryKey") != null ? bool.Parse(col.Element("IsPrimaryKey").Value) : false;
                    column.IsRequired = col.Element("IsRequired") != null ? bool.Parse(col.Element("IsRequired").Value) : true; // Default all Values are required unless specified
                    column.Width = col.Element("Width") != null ? int.Parse(col.Element("Width").Value) : 100;
                    column.IsSearchAble = col.Element("IsSearchAble") != null ? bool.Parse(col.Element("IsSearchAble").Value) : false; // Default is False unless specified
                    column.IsSubQuery = col.Element("IsSubQuery") != null ? bool.Parse(col.Element("IsSubQuery").Value) : false; // Default is False unless specified
                    column.DefaultValue = col.Element("DefaultValue") != null ? col.Element("DefaultValue").Value.ToString() : string.Empty;
                    column.IsVisible = col.Element("IsVisible") != null ? bool.Parse(col.Element("IsVisible").Value) : true; // Default is true unless specified
                    column.OrderBy = (col.Element("OrderBy") != null ? column.DBColumnName + " " + col.Element("OrderBy").Value.ToString() : null);
                    dataColumns.Add(column);
                }
            }
            return dataColumns;
        }

        private void GetDatabaseType(string input, out string output, out int length)
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
        #endregion


        //        private ActionResult List()
        //        {
        //            string tableName = "CPT";
        //            string codeType = "";       //"CTRY"

        //            Dictionary<string, string> codeMap = new Dictionary<string, string>(); 
        //            try {
        //                codeMap = new Dictionary<string, string>
        //                    {
        //                        { "DECL", "Declined/Closed Reason"},
        //                        { "DIAG", "Diagnostic"},
        //                        { "INT", "Level of Care/Status"},
        //                        { "PEND", "Pended Reason"},
        //                        { "SVCS", "Services" },
        //                        { "ET", "Service Type"},
        //                        { "TREL", "Term Relation"},
        //                        { "ACT", "Activity Type"},
        //                        { "ASSE", "Assesment Type"},
        //                        { "CTRY", "Country"},
        //                        { "ETHN", "Ethnicity"},
        //                        { "EXCP", "Exception Criteria"},
        //                        { "FS", "Fee Schedule"},
        //                        { "GLOB", "Group/Client LOB"},
        //                        { "PPT", "Group/Client Type"},
        //                        { "LANG", "Language"},
        //                        { "NAME", "Name Type"},
        //                        { "NT", "Note Type"},
        //                        { "PYRT", "Payor Type"},
        //                        { "PHON", "Phone Type"},
        //                        { "PCAT", "Plan Item Type"},
        //                        { "LOBT", "Plan/LOB Type"},
        //                        { "LOBS", "Plan/LOB Contract Status"},
        //                        { "PSS", "Psychological Stressors"},
        //                        { "REG", "Region"},
        //                        { "SERV", "Resource Services"},
        //                        { "ST", "State"},
        //                        { "GT", "User Group"},
        //                        { "UACT", "Work Activity"}
        //                    };
        //                }   catch(Exception e) { ; }


        //            if (Request.QueryString["menu"] != null)
        //            {
        //                tableName = Request.QueryString["menu"].ToString();
        //            }

        //            if (Request.QueryString["code"] != null)
        //            {
        //                codeType = Request.QueryString["code"].ToString();
        //            }

        //            string stoken = string.Empty;
        //            string searchText = Request.Form["searchText"] != null ? Request.Form["searchText"].ToString().Trim() : stoken;
        //            string searchTarget = string.IsNullOrEmpty(searchText) ? stoken : searchText;

        //            ListViewModel ViewModelListOutput = new ListViewModel();
        //            ViewModelListOutput.ListType = tableName;
        //            ViewModelListOutput.TableName = tableName;
        //            ViewModelListOutput.SearchText = searchText;        //@ assin searchTarget instead of searchText to force non-blank predicate

        //            string codename = codeType;
        //            try { codename = codeMap[codeType.ToUpper()]; } 
        //            catch (Exception e) {; }

        //            ViewModelListOutput.codeType = codeType;
        //            ViewModelListOutput.Caption = codename + " Codes";

        //            var dataContext = new CMADataContext();
        //            ViewModelListOutput.TableHeaders = GetTableHeaders(dataContext, tableName);
        //            string TableData = string.Empty;
        //            switch (tableName.ToUpper())
        //            {
        //                case "CODES":

        //                    var q0 = dataContext.CODEs.AsQueryable();

        //                    //  searchText = "a";

        ///***
        //                    var c0 = q0.Where(co => co.Type == codeType)
        //                      .Select(co => new { co.Code1, co.Description })
        //                      .OrderBy(co => co.Code1);
        //***/

        //                    var l0 = dataContext.CODEs.AsQueryable();
        //                    if (!string.IsNullOrEmpty(searchText))
        //                    {
        //                        l0 = l0.Where(_ => SqlMethods.Like(_.Code1, "%" + searchText + "%")
        //                           || SqlMethods.Like(_.Description, "%" + searchText + "%")
        //                           && Equals(_.Type, codeType));
        //                    }
        //                    else
        //                    {
        //                        l0 = l0.Where(_ => _.Type == codeType)
        //                                .OrderBy(co => co.Code1);
        //                    }

        //                    TableData = JsonConvert.SerializeObject(l0.OrderBy(_ => _.Code1).ToList());
        //                    // TableData = JsonConvert.SerializeObject(c0.ToList());
        //                    break;

        //                case "CPT":
        //                    var l1 = dataContext.CPTs.AsQueryable();
        //                    if (!string.IsNullOrEmpty(searchText))
        //                    {
        //                        l1 = l1.Where(_ => SqlMethods.Like(_.CPT1, "%" + searchText + "%")
        //                                        || SqlMethods.Like(_.Description, "%" + searchText + "%"));
        //                    } else
        //                    {
        //                        l1 = l1.Where(_ => false);
        //                    }
        //                    TableData = JsonConvert.SerializeObject(l1.OrderBy(_ => _.CPT1).ToList());
        //                    break;
        //                case "EPISODE":
        //                    var l2 = dataContext.Episodes.AsQueryable();
        //                    if (!string.IsNullOrEmpty(searchText))
        //                    {
        //                        l2 = l2.Where(_ => SqlMethods.Like(_.Description, "%" + searchText + "%")
        //                                        || SqlMethods.Like(_.Comment, "%" + searchText + "%")
        //                                        || SqlMethods.Like(_.EpisodeID, "%" + searchText + "%")
        //                                        || SqlMethods.Like(_.EpisodeNo, "%" + searchText + "%"));

        //                    } else
        //                    {
        //                        l2 = l2.Where(_ => false);
        //                    }
        //                    TableData = JsonConvert.SerializeObject(l2.OrderByDescending(_ => _.ChgStamp).ToList());
        //                    break;

        //                case "ICD":
        //                    var l3 = dataContext.ICDs.AsQueryable();
        //                    if (!string.IsNullOrEmpty(searchText))
        //                    {
        //                        l3 = l3.Where(_ => SqlMethods.Like(_.Description, "%" + searchText + "%")
        //                                        || SqlMethods.Like(_.Notes, "%" + searchText + "%"));
        //                    } else
        //                    {
        //                        l3 = l3.Where(_ => false);
        //                    }
        //                    TableData = JsonConvert.SerializeObject(l3.OrderBy(_ => _.ICD1).ToList());
        //                    break;

        //                default:
        //                    break;
        //            }
        //            // ViewData["ListOutputHeaders"] = JsonConvert.SerializeObject(ViewModelListOutput);
        //            // ViewData["ListOutputData"] = TableData;
        //            ViewModelListOutput.TableData = TableData;    
        //            dataContext.Dispose();

        //            if (Request.IsAjaxRequest())
        //                return PartialView("~/Views/Manage/Controls/List.ascx", ViewModelListOutput);

        //            return View(ViewModelListOutput);
        //        }

        //        [HttpPost]
        //        private ActionResult SaveRecord()
        //        {
        //            string tableName = Request.Form["tableName"] != null ? Request.Form["tableName"].ToString().Trim() : string.Empty;
        //            string codeType = Request.Form["code"] != null ? Request.Form["code"].ToString().Trim() : string.Empty;
        //            string id = Request.Form["recordId"] != null ? Request.Form["recordId"].ToString().Trim() : string.Empty;
        //            string columnList = Request.Form["columnList"] != null ? Request.Form["columnList"].ToString().Trim() : string.Empty;
        //            string nonStringColumnList = Request.Form["nonStringColumnList"] != null ? "," + Request.Form["nonStringColumnList"].ToString().Trim() + "," : string.Empty;
        //            string primaryKey = Request.Form["primaryKey"] != null ? Request.Form["primaryKey"].ToString().Trim() : string.Empty;

        //            string replacedPrimaryKey = CMAHelper.ReplaceWithFriendlyName(primaryKey);


        //            string errorMessage = string.Empty;
        //            bool isUpdate = false;

        //            if (string.IsNullOrEmpty(tableName) || string.IsNullOrEmpty(primaryKey) || (!string.IsNullOrEmpty(columnList) && !columnList.Contains(",")))
        //                errorMessage = "Error Saving the Record.";
        //            if (string.IsNullOrEmpty(errorMessage))
        //            {
        //                if (!string.IsNullOrEmpty(id))
        //                    isUpdate = true;

        //                string primaryKeyValue = Request.Form["txt" + primaryKey] != null ?
        //                                                Request.Form["txt" + primaryKey].ToString() : string.Empty;

        //                string updatePrimaryKeyValue = Request.Form["primaryKeyValue"] != null ?
        //                                                Request.Form["primaryKeyValue"].ToString() : string.Empty;

        //                if (isUpdate && string.IsNullOrEmpty(updatePrimaryKeyValue))
        //                    errorMessage = "Missing Primary Key for the Record.";
        //                if (string.IsNullOrEmpty(primaryKeyValue))
        //                    errorMessage = "Missing Primary Key for the Record. Please add one.";


        //                if (string.IsNullOrEmpty(errorMessage))
        //                {
        //                    var dataContext = new CMADataContext();
        //                    try
        //                    {
        //                        string sql = string.Empty;
        //                        if (isUpdate)
        //                            sql = "select top 1 " + replacedPrimaryKey + " from dbo." + tableName + " with (NOLOCK) where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);
        //                        else
        //                            sql = "select top 1 " + replacedPrimaryKey + " from dbo." + tableName + " with (NOLOCK) where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(primaryKeyValue);

        //                        if (!string.IsNullOrEmpty(codeType))
        //                            sql += " and Type=" + SQLHelper.MakeSQLSafe(codeType);


        //                        var rec = dataContext.ExecuteQuery<dynamic>(sql);

        //                        if (isUpdate && !rec.Any()) // Make sure this record dont exist as its a primary Key
        //                            errorMessage = "Error Updating the Record";
        //                        else if (!isUpdate && rec.Any())
        //                            errorMessage = "Record exists for this Key " + primaryKeyValue;


        //                        if (isUpdate)
        //                        {
        //                            sql = "update dbo." + tableName + Environment.NewLine + "set ";
        //                            foreach (var col in columnList.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
        //                            {
        //                                if (nonStringColumnList.Contains("," + col + ","))
        //                                    sql += CMAHelper.ReplaceWithFriendlyName(col) + "=" + (Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : "NULL") + "," + Environment.NewLine;
        //                                else
        //                                    sql += CMAHelper.ReplaceWithFriendlyName(col) + "=" + SQLHelper.MakeSQLSafe(Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : string.Empty) + "," + Environment.NewLine;
        //                            }
        //                            sql = sql.Trim();

        //                            if (sql.EndsWith(","))
        //                                sql = sql.Substring(0, sql.Length - 1);
        //                            sql += " where " + replacedPrimaryKey + "=" + SQLHelper.MakeSQLSafe(updatePrimaryKeyValue);

        //                            if (!string.IsNullOrEmpty(codeType))
        //                                sql += " and Type=" + SQLHelper.MakeSQLSafe(codeType);
        //                        }
        //                        else
        //                        {
        //                            if (!string.IsNullOrEmpty(codeType))
        //                                sql = "insert into dbo." + tableName + "(type," + CMAHelper.ReplaceWithFriendlyName(columnList) + ")values(" + Environment.NewLine + SQLHelper.MakeSQLSafe(codeType) + "," ;
        //                            else
        //                                sql = "insert into dbo." + tableName + "(" + CMAHelper.ReplaceWithFriendlyName(columnList) + ")values(" + Environment.NewLine;

        //                            foreach (var col in columnList.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
        //                            {
        //                                if (nonStringColumnList.Contains("," + col + ","))
        //                                    sql += (Request.Form["txt" + col] != null ? Request.Form["txt" + col] : "NULL") + ",";
        //                                else
        //                                    sql += SQLHelper.MakeSQLSafe(Request.Form["txt" + col] != null ? Request.Form["txt" + col].Trim() : string.Empty) + ",";
        //                            }
        //                            sql = sql.Trim();

        //                            if (sql.EndsWith(","))
        //                                sql = sql.Substring(0, sql.Length - 1);

        //                            sql += ");";
        //                        }
        //                        dataContext.ExecuteQuery<dynamic>(sql);

        //                        dataContext.SubmitChanges();
        //                    }
        //                    catch (Exception ex)
        //                    {
        //                        errorMessage = ex.Message;
        //                    }
        //                    finally
        //                    {
        //                        dataContext.Dispose();
        //                    }
        //                }
        //            }

        //            if (!string.IsNullOrEmpty(errorMessage))
        //            {
        //                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
        //                Response.StatusDescription = errorMessage;
        //                Response.Write(errorMessage);
        //            }

        //            return null;
        //        }

        //        [HttpPost]
        //        private ActionResult DeleteRecord()
        //        {
        //            string tableName = Request.Form["table-name"] != null ? Request.Form["table-name"].ToString().Trim() : string.Empty;
        //            string key = Request.Form["id"] != null ? Request.Form["id"].ToString().Trim() : string.Empty;

        //            if (string.IsNullOrEmpty(tableName) || string.IsNullOrEmpty(key))
        //            {
        //                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
        //                Response.StatusDescription = "Error Deleting the Record.";
        //                Response.Write("Error Deleting the Record.");
        //            }
        //            else
        //            {
        //                var dataContext = new CMADataContext();
        //                switch (tableName.ToUpper())
        //                {
        //                    case "CPT":
        //                        {
        //                            var rec = dataContext.CPTs.FirstOrDefault(_ => _.CPT1 == key);
        //                            if (rec != null)
        //                                dataContext.CPTs.DeleteOnSubmit(rec);
        //                            break;
        //                        }
        //                    default:
        //                        break;
        //                }
        //                dataContext.SubmitChanges();
        //                dataContext.Dispose();
        //            }
        //            return null;
        //        }

        //=======


        //        private List<TableHeaders> GetTableHeaders(CMADataContext dataContext, string tableName)
        //        {
        //            List<TableHeaders> tableHeaders = new List<TableHeaders>();
        //            List<TableHeaders> displayHeaders = new List<TableHeaders>();

        //            if (dataContext != null)
        //            {
        //                foreach (var table in dataContext.Mapping.GetTables())
        //                {
        //                    if (string.Equals(table.TableName, "dbo." + tableName))
        //                    {
        //                        foreach (var col in table.RowType.DataMembers)
        //                        {
        //                            TableHeaders row = new TableHeaders();
        ////@x                         row.ColumnName = col.MappedName;
        //                            row.ColumnName = col.Name;
        //                            row.IsPrimaryKey = col.IsPrimaryKey;
        //                            string dbType;
        //                            int length;
        //                            GetDatabaseType(col.DbType, out dbType, out length);
        //                            row.Length = length;
        //                            row.DataType = dbType;
        //                            row.Required = !col.CanBeNull;

        //                            row.DisplayLength = length;
        //                            row.Caption = col.Name;
        //                            row.ReadOnly = false;
        //                            tableHeaders.Add(row);
        //                        }
        //                    }
        //                }
        //            }

        //            displayHeaders = filterList(tableHeaders, tableName);


        //            return displayHeaders;
        //            //@ return tableHeaders;
        //        }

        //        public string ColumnName { get; set; }
        //        public string DataType { get; set; }
        //        public int Length { get; set; }
        //        public bool Required { get; set; }
        //        public bool IsPrimaryKey { get; set; }

        //        public string Caption;
        //        public int DisplayLength;
        //        public bool ReadOnly;


        //        List<TableHeaders> filterList(List<TableHeaders> headers,  string source)
        //        {
        //            List<TableHeaders> displayHeaders = new List<TableHeaders>();
        //            foreach (TableHeaders th in headers)
        //            {
        //                TableHeaders row = th;
        //                switch (source)
        //                {
        //                    case "CODES":
        //                        switch (th.ColumnName) {

        ///**                            case "Type":
        /////                                row.Caption = "CodeType";
        //                                displayHeaders.Add(row);
        //                                break;
        //**/
        //                            case "Code1":
        //                                row.Caption = "Code";
        //                                displayHeaders.Add(row);
        //                                break;
        //                            case "Description":
        /////                                row.Caption = "Description";
        //                                displayHeaders.Add(row);
        //                                break;
        //                        }
        //                        break;
        //                    default:
        //                        displayHeaders.Add(row);
        //                        break;
        //                }


        //            }

        //            return displayHeaders;
        //        }


        int ProcessCodeType(string codeType)
        {
            int ri = 0;
            switch (codeType)
            {
                case "ACT":
                    ;
                    break;
            }

            return ri;
        }
    }
}
