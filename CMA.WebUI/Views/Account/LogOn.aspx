<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <form method="post" id="CMALogon" name="CMALogon" action="/Account/LogOn">
        <div style="margin:auto; width:300px;padding-top:150px;">
            <table style="border:solid 1px #6badf6;width:400px;padding:10px;">
                <%
                    if (ViewData["ErrorMessage"]!=null && ViewData["ErrorMessage"].ToString().Length > 0)
                    {
                %>
                    <tr style="height:50px;">
                        <td colspan="2" style="text-align:center;color:#ff0000;font-weight:bold;">
                            <%=ViewData["ErrorMessage"].ToString() %>
                        </td>
                    </tr>
                <%
                    }
                %>
                <tr>
                    <td style="height:30px;padding:20px;">Username</td>
                    <td style="padding:20px;">
                        <input type="text" 
                            class="form-control" 
                            style="width: 300px;" 
                            maxlength = "5"
                            id="txtUsername" 
                            name="txtUsername" 
                            value=""/>
                    </td>
                </tr>
                <tr>
                    <td style="height:30px;padding:20px;">Password</td>
                    <td style="padding:20px;">
                        <input type="password" 
                            class="form-control" 
                            style="width: 300px;" 
                            maxlength = "10"
                            id="txtPassword" 
                            name="txtPassword" 
                            value=""/>
                    </td>
                </tr>

                <tr style="height:50px;">
                    <td colspan="2" style="text-align:center;">
                        <button type="submit" class="btncancel" onclick="javascript:return validateLogin();">Login</button>
                    </td>
                </tr>
            </table> 
        </div>
    </form>
</asp:Content>