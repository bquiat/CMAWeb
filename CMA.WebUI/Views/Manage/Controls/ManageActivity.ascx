<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%@ Import Namespace="CMA.WebUI.Models" %>
<% 
    Namez name = ViewData["Name"] != null ? (Namez)ViewData["Name"] : null;
    if (name != null)
    {
        List<Episode> Episodes = (List<Episode>)ViewData["Episodes"];
        List<Activity> Activities = (List<Activity>)ViewData["Activity"];
        List<ACTCODE> ActivityCodes = (List<ACTCODE>)ViewData["ActivityCodes"];
        List<CODE> ServiceCodes = (List<CODE>)ViewData["ServiceCodes"];
        List<Namez> PayorNamez = (List<Namez>)ViewData["PayorNames"];
        List<ORGANIZATION> Organizations = (List<ORGANIZATION>)ViewData["Organizations"];
%>

<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span>Manage Activity</h1>
        <div class="header-window-btn">
            <ul>
                <%--<li class="w-minimz" onclick="clasMinimaiz($(this));"><a href="#">minimize</a></li>
                <li class="w-maxmiz" onclick="clasMaximaiz($(this));"><a href="#">Maximize</a></li>--%>
                <li class="w-close" onclick="classcloseWin('manage-activity');"><a href="#">Close</a></li>
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
                                <div class="col-xs-1">
                                    <label>Criteria:</label>
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
                                    <div class="col-xs-1">
                                        <label class="label--align">Sort By:</label>
                                    </div>
                                    <div class="col-xs-11">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                Date/Time
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox">
                                                From
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
                                <th>User</th>
                                <th>Case/Episode</th>
                                <th>Description</th>
                                <th>Activity Total</th>
                                <th>Inv No</th>
                                <th>Billing Status</th>
                                <th>Time</th>
                                <th>Code</th>
                                <th>Activity Description</th>
                                <th>Service</th>
                                <th>Reference</th>
                                <th>Client</th>
                            </tr>
                        </thead>
                        <tbody>
                                <% 
                                    if (Activities!=null && Activities.Any())
                                    {
                                        foreach (var activity in Activities)
                                        {
                                %>
                                    <tr>
                                        <td></td>
                                        <td><%=activity.ActivityDate.HasValue ? activity.ActivityDate.Value.ToLongDateString() + " " + activity.ActivityDate.Value.ToShortTimeString() : string.Empty %></td>
                                        <td><%=CMAHelper.GetValue(activity.UserID) %></td>
                                        <td>
                                            <% 
                                                if (Episodes != null && Episodes.Any())
                                                {
                                                    var episode = Episodes.Where(_ => _.EpisodeID == activity.EpisodeID);
                                                    if (episode.Any())
                                                        Response.Write(episode.FirstOrDefault().Description);
                                                }
                                            %>
                                        </td>
                                        <td><%=CMAHelper.GetValue(activity.Description) %></td>
                                        <td><%=activity.ActivityTotal.HasValue ? String.Format("{0:C}",activity.ActivityTotal.Value) : "$0.00" %></td>
                                        <td><%=activity.InvoiceNo.HasValue ? CMAHelper.GetValue(activity.InvoiceNo.Value.ToString()) : string.Empty %></td>
                                        <td><%=CMAHelper.GetValue(activity.BillingStatus) %></td>
                                        <td><%=activity.Time_.HasValue ? CMAHelper.GetValue(activity.Time_.Value.ToString()) : string.Empty %></td>
                                        <td><%=CMAHelper.GetValue(activity.ActivityCode) %></td>
                                        <td>
                                            <% 
                                                if (ActivityCodes != null && ActivityCodes.Any() && !string.IsNullOrEmpty(activity.ActivityCode))
                                                {
                                                    var activityCode = ActivityCodes.Where(_ => _.ActivityCode == activity.ActivityCode);
                                                    if (activityCode != null)
                                                        Response.Write(activityCode.FirstOrDefault().Description);
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <%
                                                if (!string.IsNullOrEmpty(activity.ServiceCode)
                                                    && ServiceCodes != null
                                                    && ServiceCodes.Any()
                                                    && ServiceCodes.Where(_ => _.Code1 == activity.ServiceCode).Any()
                                                )
                                                    Response.Write(ServiceCodes.FirstOrDefault(_ => _.Code1 == activity.ServiceCode).Description);
                                            %>

                                        </td>
                                        <td><%=CMAHelper.GetValue(activity.Reference) %></td>
                                        <td><%
                                                if (PayorNamez != null && PayorNamez.Any() && !string.IsNullOrEmpty(activity.PayorID))
                                                {
                                                    var PayorName = PayorNamez.Where(_ => _.NameID == activity.PayorID);
                                                    if (PayorName!=null)
                                                    {
                                                        if (PayorName.FirstOrDefault().Organization!=null
                                                                && Organizations!=null
                                                                && Organizations.Any())
                                                        {
                                                            var Organization = Organizations.FirstOrDefault(o => PayorName.FirstOrDefault().Organization == o.ORGANIZATION_ID);
                                                            if (Organization != null)
                                                                Response.Write(Organization.NAME + ";");
                                                        }
                                                        Response.Write(PayorName.FirstOrDefault().FirstName + " " + PayorName.FirstOrDefault().LastName);
                                                    }
                                                }
                                        %></td>
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