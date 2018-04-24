<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span><%=Model.Caption%></h1>
        <div class="header-window-btn">
            <ul>
                <%--<li class="w-minimz" onclick="Minimize('<%=Model.InputParam.ContainerId%>');"><a href="#">Minimize</a></li>
                <li class="w-maxmiz" onclick="Maximize('<%=Model.InputParam.ContainerId%>');"><a href="#">Maximize</a></li>--%>
                <li class="w-close" onclick="CloseWindow('<%=Model.InputParam.ContainerId%>');"><a href="#">Close</a></li>
            </ul>
        </div>
    </header>
    <div class="overflow--container">
        <div class="inner-window window-fluid inner-window-style" id="addeditview-<%=Model.InputParam.ContainerId%>">
        </div>
        <div class="inner-window window-fluid inner-window-style" id="lstview-<%=Model.InputParam.ContainerId%>">
            <% 
                string type = Model.InputParam.Type;
                string menu = Model.InputParam.Menu;
                string tablename = Model.TableName;
                string subquery = Model.InputParam.SubQuery;
                string id = Model.InputParam.ContainerId;    
            %>
            <section class="window-inner-header">
                <div class="wdw-hdr-block">
                    <div class="wdw-hdr-block-title">Filter / Sort</div>
                    <div class="row">
                        <div class="col-xs-12 tp-pdd--1">
                            <div class="row">
                                <div class="col-xs-1">
                                    <label>Criteria:</label>
                                </div>
                                <div class="col-xs-11">
                                    <span class="txtbx--1">
                                        <label>Search Text</label>
                                        <input type="text" class="form-control searchText" 
                                            value="<%=(!string.IsNullOrEmpty(Model.SearchText) ? Model.SearchText : "")%>"
                                            style="width:450px;" data-id="<%=Model.InputParam.ContainerId %>" id="txt-<%=Model.InputParam.ContainerId %>-search" name="txt-<%=Model.InputParam.ContainerId %>-search"
                                            onKeyPress="javascript:captureEnterKey(event, this,'<%=Model.InputParam.Type %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');"
                                            >
                                    </span>
                                    <span class="search-btn no--float">
                                        <button 
                                            type="button" 
                                            class="search" 
                                            id="btn-<%=Model.InputParam.ContainerId %>-search" 
                                            onclick="javascript:return searchText('<%=Model.InputParam.Type %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');"
                                            >Search</button>
                                        <% 
                                            string addUrl = "/Manage/CodeEditAdd?edit=0&type=" + type + "&menu=" + menu.Replace("/","//").Replace(" ","|") + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;    
                                        %>
                                        <button type="button" data-fancybox data-type="ajax" data-src="<%=addUrl%>">Add New Record</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <% 
                var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(Model.TableData);    
                
            %>
            <section class="inner-window-body">
                <div class="app-table">
                    <table class="table table-bordered tablesorter-blue" id="<%=Model.InputParam.ContainerId%>-table">
                        <thead>
                            <tr>
                                <% 
                                    foreach (var header in Model.DataColumns.Where(_=>_.IsVisible))
                                    {
                                %>  
                                    <th><%=header.DisplayName %></th>
                                <%
                                    }
                                %>
                                <th class="sorter-false"></th>
                                <th class="sorter-false"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  
                                if (obj != null && obj.Any())
                                {
                                    foreach (var record in obj)
                                    {
                                        string primaryKeyCol = string.Empty;
                                        string primaryKeyVal = string.Empty;
                            %>
                            <tr>
                            <%
                                foreach (var col in Model.DataColumns.Where(_=>_.IsVisible))
                                {
                                    if (col.IsPrimaryKey)
                                    {
                                        primaryKeyCol = CMAHelper.ReplaceWithLINQName(col.DBColumnName);
                                        primaryKeyVal = record[CMAHelper.ReplaceWithLINQName(col.DBColumnName)].ToString();
                                    }
                            %>
                                    <td><%=record[CMAHelper.ReplaceWithLINQName(col.DBColumnName)].ToString() %></td>
                            <%
                                }
                               
                                string key = primaryKeyCol;
                                string value = primaryKeyVal;
                                string editUrl = "/Manage/CodeEditAdd?edit=1&type=" + type + "&key=" + key + "&val=" + value + "&menu=" + menu.Replace("/","//").Replace(" ","|") + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;
                            %>
                                <td><a 
                                    href="#"
                                    class="activelink" 
                                    data-fancybox data-type="ajax" data-src="<%=editUrl%>">
                                        Edit
                                    </a></td>
                                <td>
                                    <a 
                                    href="#"
                                    class="activelink" 
                                    onclick="javascript:deleteRecord('<%=Model.InputParam.Type %>','<%=primaryKeyCol %>','<%=primaryKeyVal %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');">
                                    Delete
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $("#<%=Model.InputParam.ContainerId%>-table").tablesorter({
                                theme: 'blue',
                                sortList: [[0, 0]],
                                widgets: ["zebra", "resizable","stickyHeaders"],
                                widgetOptions: {
                                    resizable: false,
                                }
                            });
                        });
                    </script>
                </div>
            </section>
        </div>
    </div>
</div>
