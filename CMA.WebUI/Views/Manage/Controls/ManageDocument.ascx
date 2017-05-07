<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%@ Import Namespace="CMA.WebUI.Models" %>

<% 
    Namez name = ViewData["Name"] != null ? (Namez)ViewData["Name"] : null;
    if (name != null)
    {
        List<Episode> Episodes = (List<Episode>)ViewData["Episodes"];
        List<Document> Documents = (List<Document>)ViewData["Documents"];
        List<Namez> ToFromNamez = (List<Namez>)ViewData["ToFromNames"];
        List<ORGANIZATION> ToFromOrganization = (List<ORGANIZATION>)ViewData["ToFromOrganization"];
%>

<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span>Manage Documents</h1>
        <div class="header-window-btn">
            <ul>
                <%--<li class="w-minimz" onclick="clasMinimaiz($(this));"><a href="#">minimize</a></li>
                <li class="w-maxmiz" onclick="clasMaximaiz($(this));"><a href="#" >Maximize</a></li>--%>
                <li class="w-close" onclick="classcloseWin('manage-document');"><a href="#">Close</a></li>
            </ul>
        </div>
    </header>
    <div class="overflow--container">
        <div class="inner-window window-fluid inner-window-style">
            <section class="window-inner-header">
                        <div class="wdw-hdr-block">
                            <div class="wdw-hdr-block-title">Filter / Sort</div>
                            <div class="row">
                                <div class="col-xs-12 tp-pdd--1">
                                    <div class="row">
                                        <div class="col-xs-1"><label>Criteria:</label>
                                        </div>
                                        <div class="col-xs-11"> 
                                            <span class="txtbx--1 tofrom----">
                                                <label>To/From</label>
                                                <input type="text" class="form-control">
                                            </span>
                                            <span class="txtbx--1 from--">
                                                <label>From</label>
                                                <select class="form-control">
                                                    <option></option>
                                                    <option></option>
                                                    <option>1</option>
                                                    <option>1</option>
                                                </select>
                                            </span>
                                            <span class="txtbx--1 byto--">
                                                <label>By/To</label>
                                                <select class="form-control">
                                                    <option></option>
                                                    <option></option>
                                                    <option>1</option>
                                                    <option>1</option>
                                                </select>
                                            </span>
                                            <span class="txtbx--1 case-episode--">
                                                <label>Case/Episode</label>
                                                <input type="text" class="form-control">
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="hdr-sort--">
                                        <div class="row">
                                            <div class="col-xs-1"><label class="label--align">Sort By:</label>
                                            </div>
                                            <div class="col-xs-11">
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox"> Date/Time
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox"> From
                                                    </label>
                                                </div>
                                                <span class="search-btn no--float">
                                                    <button type="button">Query</button>
                                                </span>
                                            </div>
                                        </div>
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
                                        <th></th>
                                        <th>Date/Time</th>
                                        <th>To/From</th>
                                        <th>From</th>
                                        <th>By/To</th>
                                        <th>Type</th>
                                        <th>Document</th>
                                        <th>Return</th>
                                        <th>Received</th>
                                        <th>Description</th>
                                        <th>File</th>
                                        <th>Episode</th>
                                    </tr>
                                </thead>
                              <tbody>
                                <%
                                    if (Documents!=null && Documents.Any())
                                    {
                                        foreach(var document in Documents)
                                        {
                                %>
                                    <tr>
                                        <td></td>
                                        <td><%=document.Date_.HasValue ?
                                                document.Date_.Value.ToLongDateString() + " " + document.Date_.Value.ToLongTimeString() :
                                                string.Empty
                                            %>
                                        </td>
                                        <td>
                                            <% 
                                                string toFromName = string.Empty;

                                                if (document.ToNameID!=null
                                                    && ToFromNamez!=null
                                                    && ToFromNamez.Any())
                                                {
                                                    var Name = ToFromNamez.FirstOrDefault(n => n.NameID == document.ToNameID);
                                                    if (Name!=null)
                                                    {   
                                                        toFromName = Name.FirstName + " " + Name.LastName;
                                                        if (Name.Organization!=null
                                                                && ToFromOrganization!=null
                                                                && ToFromOrganization.Any())
                                                        {
                                                            var Organization = ToFromOrganization.FirstOrDefault(o => Name.Organization == o.ORGANIZATION_ID);
                                                            if (Organization != null)
                                                                toFromName += ";" + Organization.NAME;
                                                        }
                                                    }
                                                }
                                                Response.Write(toFromName);
                                            %>
                                        </td>
                                        <td><%=CMAHelper.GetValue(document.FromUserID) %></td>
                                        <td><%=CMAHelper.GetValue(document.ByUserID) %></td>
                                        <td><%=CMAHelper.GetValue(document.DocType) %></td>
                                        <td><%=CMAHelper.GetValue(document.DocName) %></td>
                                        <td><input type="checkbox" class="checkbox" disabled <%=(document.Return_.HasValue && document.Return_.Value == 1 ? " checked " : "") %> /></td>
                                        <td><%=document.Received.HasValue ? 
                                                document.Received.Value.ToShortDateString():
                                                string.Empty
                                        %></td>
                                        <td><%=CMAHelper.GetValue(document.Description) %></td>
                                        <td><%=CMAHelper.GetValue(document.File_) %></td>
                                        <td><%
                                                Response.Write(Episodes != null && Episodes.Any() ? CMAHelper.GetValue(Episodes.FirstOrDefault().Description) : string.Empty);
                                        %>
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

<% 
    }
%>