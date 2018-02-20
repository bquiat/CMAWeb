<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<% 
    var results = (List<CMA.WebUI.Models.Namez>)ViewData["FindCaseSearchOutput"];
    if (results != null && results.Any())
    {
%>
<div class="app-table">
    <table class="table table-bordered tablesorter" id="manage-case-find">
        <thead>
            <tr>
                <th>Last Name</th>
                <th>First Name</th>
            </tr>
        </thead>
        <tbody>

            <%foreach (var result in results.OrderBy(_=>_.FirstName))
                {
            %>
            <tr>
                <td style="cursor:pointer;" onclick="return OpenManageCase('<%=result.NameID.Trim()%>','<%=result.Names_ID %>');"><%=result.LastName %></td>
                <td style="cursor:pointer;" onclick="return OpenManageCase('<%=result.NameID.Trim()%>','<%=result.Names_ID %>');"><%=result.FirstName %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#manage-case-find").tablesorter();
    }
);
</script>
<% 
    }
%>
