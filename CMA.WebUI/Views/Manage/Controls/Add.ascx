<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<div id="AddNewRecord" style="display:none;">
    <form id="frmAddEditRecord" method="post">
    <section class="dummy-window">
        <div class="inner-window inner-window-style">
            <header class="app-header">
                <h1><span class="header-icon"></span>Case Management Assistant - Add <%=Model.TableName %></h1>
                <div class="header-window-btn">
                    <ul>
                        <li class="w-close"><a href="#" onclick="javascript:return closeAddForm();">Close</a></li>
                    </ul>
                </div>
            </header>
            <section class="window-inner-header">
                <div class="search-text">
                    <h2>Add New - <%=Model.TableName %></h2>
                </div>
            </section>
            <section class="inner-window-body">
                <div class="app-table">
                    <table class="table table-bordered">
                        <%
                        foreach (var header in Model.TableHeaders)
                        {
                        %>
                        <% 
                            if (header.IsPrimaryKey)
                            {
                        %>
                        <input type="hidden" id="primaryKey" name ="primaryKey" value="<%=header.ColumnName %>" />
                        <input type="hidden" id="primaryKeyValue" name ="primaryKeyValue" value="" />
                        <%
                            }
                        %>    
                        <tr>
                            <td><%=CMA.WebUI.Helpers.CMAHelper.ReplaceWithFriendlyName(header.ColumnName) %></td>
                            <td>
                                <input type="text"
                                        id = "txt<%=header.ColumnName%>"
                                        name ="txt<%=header.ColumnName%>" 
                                        class="form-control"
                                        data-required = "<%=header.Required ? "1" : "0" %>"
                                        data-length = "<%=header.Length %>"
                                        <% 
                                    if (header.Length > 0)
                                    {
                                        %>
                                        maxlength = "<%=header.Length %>"
                                        <% 
                                    }
                                        %>
                                />
                            </td>
                        </tr>
                        <%
                        }
                        %>
                        <tr>
                            <td colspan = "<%=Model.TableHeaders.Count %>" style="text-align:center;">
                                <input type="hidden" id="recordId" name="recordId" />
                                
                                <input type="hidden" id="tableName" name="tableName" value="<%=Model.TableName %>" />
                                <input type="hidden" id="code" name="code" value="<%=Request.QueryString["code"]!=null ? Request.QueryString["code"].ToString() : "" %>" />
                                <input type="hidden" id="columnList" name="columnList" value="<%=string.Join(",",Model.TableHeaders.Select(_=>_.ColumnName).ToList()) %>" />
                                <input type="hidden" id="nonStringColumnList" name="nonStringColumnList" value="<%=string.Join(",",Model.TableHeaders.Where(_=>_.Length ==0).Select(_=>_.ColumnName).ToList()) %>" />
                                <button type="button" style="padding:5px;width:100px;" onclick="javascript:return saveAddForm();">Save</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </section>
        </div>
    </section>
    </form>
</div>
