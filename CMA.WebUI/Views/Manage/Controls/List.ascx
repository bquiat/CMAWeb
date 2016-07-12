<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<section class="dummy-window">
    <div class="inner-window inner-window-style">
        <header class="app-header">
            
            <h1><span class="header-icon"></span>Case Management Assistant - <%= (Model.TableName == "CODES") ? Model.Caption : Model.TableName %></h1>
            
            <div class="header-window-btn">
                <ul>
                    <%--<li class="w-minimz"><a href="#">minimize</a></li>
                    <li class="w-maxmiz"><a href="#">Maximize</a></li>--%>
                    <li class="w-close"><a href="#">Close</a></li>
                </ul>
            </div>
        </header>
        <section class="window-inner-header">
            <div class="search-text">
                <h2>Search Text</h2>
                <div class="row">
                    <div class="col-sm-12">
                        <span class="seacrh-field">
                            <input class="form-control" type="text" id="searchText" name="searchText" value="<%=Model.SearchText %>">
                        </span>
                        <span class="serach-checkbox" style="display:none;">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox">
                                    Search Within
                                </label>
                            </div>
                        </span>
                        <span class="search-btn">
                            <button type="button" id="btnSearch" onclick="javascript:return searchText('<%=Model.TableName %>', '<%=Model.codeType %>');">Search</button>
                        </span>
                        <div style="float:right">
                            <button type="button" style="padding:5px;" onclick="javascript:return showAddForm();">Add New Record</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="inner-window-body">
            <div class="app-table">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                        <% 
                            foreach (var header in Model.TableHeaders)
                            {
                        %>
                            <th><%=CMA.WebUI.Helpers.CMAHelper.ReplaceWithFriendlyName(header.ColumnName) %></th>
                        <%
                            }
                        %>
                        <th></th>
                        <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(Model.TableData);
                            int counter = 0;
                            if (obj!=null)
                            foreach (var row in obj)
                            {
                                counter++;
                        %>
                            <tr id="List<%=counter %>">
                        <%
                                foreach (var header in Model.TableHeaders)
                                {
                                    string headerName = header.ColumnName;
                        %>
                                <td id="td<%=headerName%>">
                                    <%
                                        if (string.Equals(headerName, Model.TableName, StringComparison.CurrentCultureIgnoreCase))
                                            headerName = Model.TableName + "1";
                                        Response.Write(row[headerName].ToString());
                                        if (header.IsPrimaryKey)
                                        {
                                        %>
                                        <input type="hidden" id="list<%=counter %>Id" value="<%=row[headerName].ToString() %>" />
                                        <%
                                        }
                                    %>
                                </td>
                        <%
                                }
                        %>
                            <td><a href="#" onclick="javascript:return editForm('<%=counter%>');">Edit</a></td>    
                            <td><a href="#" onclick="javascript:return deleteRecord('<%=counter%>','<%=Model.TableName %>');">Delete</a></td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <input type="hidden" id="headerList" value="<%=string.Join(",",Model.TableHeaders.Select(_=>_.ColumnName).ToList()) %>" />
            </div>
        </section>
    </div>
</section>
