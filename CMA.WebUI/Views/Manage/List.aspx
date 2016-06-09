<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CMA.WebUI.ViewModels.ListViewModel>" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%

    if (Model != null)
    {
    %>
    <div id="ListRecord">
            <%Html.RenderPartial("~/Views/Manage/Controls/List.ascx", Model);%>
    </div>
            <%Html.RenderPartial("~/Views/Manage/Controls/Add.ascx", Model);%>
    <%
    }
    %>
</asp:Content>