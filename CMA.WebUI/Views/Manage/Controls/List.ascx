<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span><%=Model.Caption%></h1>
        <div class="header-window-btn">
            <ul>
                <li class="w-minimz" onclick="classMinimize($(this));"><a href="#">Minimize</a></li>
                <li class="w-maxmiz" onclick="classMaximize($(this));"><a href="#">Maximize</a></li>
                <li class="w-close" onclick="classcloseWin($(this));"><a href="#">Close</a></li>
            </ul>
        </div>
    </header>
    <div class="overflow--container">
        <div class="inner-window window-fluid inner-window-style" id="addeditview-<%=Model.InputParam.ContainerId%>">
        </div>
        <div class="inner-window window-fluid inner-window-style" id="lstview-<%=Model.InputParam.ContainerId%>">
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
                                            style="width:450px;" data-id="<%=Model.InputParam.ContainerId %>" id="txt-<%=Model.InputParam.ContainerId %>-search" name="txt-<%=Model.InputParam.ContainerId %>-search">
                                    </span>
                                    <span class="search-btn no--float">
                                        <button 
                                            type="button" 
                                            class="search" 
                                            id="btn-<%=Model.InputParam.ContainerId %>-search" 
                                            onclick="javascript:return searchText('<%=Model.InputParam.Type %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');"
                                            >Search</button>
                                        <button type="button" onclick="javascript:addNewRecord('<%=Model.InputParam.Type %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');">Add New Record</button>
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
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <% 
                                    foreach (var header in Model.DataColumns)
                                    {
                                %>  
                                    <th><%=header.DisplayName %></th>
                                <%
                                    }
                                %>
                                <th></th>
                                <th></th>
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
                                foreach (var col in Model.DataColumns)
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
                            %>
                                <td><a 
                                    href="#"
                                    class="activelink" 
                                    onclick="javascript:editRecord('<%=Model.InputParam.Type %>','<%=primaryKeyCol %>','<%=primaryKeyVal %>','<%=Model.InputParam.Menu %>','<%=Model.TableName %>','<%=Model.InputParam.SubQuery %>','<%=Model.InputParam.ContainerId %>');">
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
                </div>
            </section>
        </div>
    </div>
</div>
