<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<% 
    var results = (List<CMA.WebUI.Models.Namez>)ViewData["FindCaseSearchOutput"];
    if (results != null && results.Any())
    {
%>
<div class="app-table">
    <table class="table table-bordered">
        <thead>
            <tr>
                <td>First Name</td>
                <td>Last Name</td>
            </tr>
        </thead>
        <tbody>

            <%foreach (var result in results.OrderBy(_=>_.FirstName))
                {
            %>
            <tr>
                <td style="cursor:pointer;" onclick="return OpenManageCase('<%=result.NameID.Trim()%>','<%=result.Names_ID %>');"><%=result.FirstName %></td>
                <td style="cursor:pointer;" onclick="return OpenManageCase('<%=result.NameID.Trim()%>','<%=result.Names_ID %>');"><%=result.LastName %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<% 
    }
%>
