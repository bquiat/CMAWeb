<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%@ Import Namespace="CMA.WebUI.Models" %>
<% 
    Namez name = ViewData["Name"] != null ? (Namez)ViewData["Name"] : null;
    if (name != null)
    {
        List<Episode> Episodes = (List<Episode>)ViewData["Episodes"];
        List<EPI_TEAM> EpisodeTeam = (List<EPI_TEAM>)ViewData["EpisodeTeam"];
        List<CODE> RelationCodes = (List<CODE>)ViewData["RelationCodes"];
        List<Namez> EpisodeTeamNames = (List<Namez>)ViewData["EpisodeTeamNames"];
        List<ORGANIZATION> Organizations = (List<ORGANIZATION>)ViewData["EpisodeOrganizations"];
        List<BENEFIT> Benefits = (List<BENEFIT>)ViewData["Benefits"];
        List<Epi_CasePhase> ServicePhase = (List<Epi_CasePhase>)ViewData["ServicePhase"];
        List<CODE> ServicePhaseServiceTypeCodes = (List<CODE>)ViewData["ServicePhaseServiceTypeCodes"];
        List<CODE> ServicePhaseReasonCodes = (List<CODE>)ViewData["ServicePhaseReasonCodes"];
        List<Epi_Acuity> LevelOfCare = (List<Epi_Acuity>)ViewData["LevelOfCare"];
        List<CODE> LevelOfCareCodes = (List<CODE>)ViewData["LevelOfCareCodes"];

        string episodeId = string.Empty;
%>

<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span>Manage Case</h1>
        <div class="header-window-btn">
            <ul>
                <%--<li class="w-minimz" onclick="Minimize('manage-case');"><a href="#">minimize</a></li>
                <li class="w-maxmiz" onclick="Maximize('manage-case');"><a href="#" >Maximize</a></li>--%>
                <li class="w-close" onclick="CloseWindow('manage-case');"><a href="#">Close</a></li>
            </ul>
        </div>
    </header>
    <div class="overflow--container">
        <div class="inner-window window-fluid inner-window-style">
            <section class="window-inner-header manage-window--hdr">
            	<div class="manage--case">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="mng-case--tp__info">
                            	<span><label>Name</label></span>
                                <span class="first__name">
                                        <input 
                                            type="text" 
                                            class="form-control" 
                                            id="case_first_name" 
                                            name="case_first_name"
                                            ReadOnly
                                            value="<%=CMAHelper.GetValue(name.FirstName)%>">
                                </span>
                                <span class="middle__name">
                                        <input 
                                            type="text" 
                                            class="form-control" 
                                            id="case_middle_name" 
                                            name="case_middle_name"
                                            ReadOnly
                                            value="<%=CMAHelper.GetValue(name.MI)%>">
                                </span>
                                <span class="last__name">
                                        <input 
                                            type="text" 
                                            class="form-control" 
                                            id="case_last_name" 
                                            name="case_last_name"
                                            ReadOnly
                                            value="<%=CMAHelper.GetValue(name.LastName)%>">
                                </span>
                            </div>
                            <div class="mng-case--tp__info">
                            	<span><label>Episode</label></span>
                                <span>
                                    <select 
                                    id ="ddl-episode-case-manage-case"
                                    name ="ddl-episode-case-manage-case"
                                    ReadOnly>
                                    <% 

                                        if (Episodes!=null && Episodes.Any())
                                        {
                                            foreach (var episode in Episodes)
                                            {
                                                episodeId = episode.EpisodeID;
                                    %>
                                        <option value="<%=CMAHelper.GetValue(episode.EpisodeID)%>" selected><%=CMAHelper.GetValue(episode.Description)%></option>
                                    <%
                                            }
                                        }
                                    %>
                                    </select>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="inner--body__manage--case">
                <div class="row">
                    	<div class="col-xs-12">
                        	<div class="manage--case__tabbing">
                            	<ul class="nav nav-tabs">
                                  <li class="active"><a href="#Case" data-toggle="tab" aria-expanded="false">Case</a></li>
                                  <%--<li class=""><a href="#Benefits" data-toggle="tab" aria-expanded="true">Benefits</a></li>
                                  <li class=""><a href="#Diagnose" data-toggle="tab" aria-expanded="false">Diagnose</a></li>
                                  <li class=""><a href="#Assesments" data-toggle="tab" aria-expanded="false">Assesments</a></li>
                                  <li class=""><a href="#Care-Cost" data-toggle="tab" aria-expanded="false">Care and Cost</a></li>
                                  <li class=""><a href="#Guidlines" data-toggle="tab" aria-expanded="false">Guidlines</a></li>
                                  <li class=""><a href="#Profile" data-toggle="tab" aria-expanded="false">Profile</a></li>--%>
                                </ul>
                                <div id="myTabContent" class="manage--case__tabbing__content tab-content">
                                	<!-- tab_1 -->
                                  	<div class="tab-pane fade active in" id="Case">
                                  		<div class="row">
                                            <div class="col-xs-12">
                                                <div class="wdw-hdr-block">
                                                    <div class="wdw-hdr-block-title">Name</div>
                                                    <div class="row">
                                                        <div class="col-xs-9">
                                                            <div class="row">
                                                            	<div class="first-name__input input--bx__1">
                                                                	<span><label>First Name</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-first-name"
                                                                            name="manage-case-first-name"
                                                                            value="<%=CMAHelper.GetValue(name.FirstName) %>">
                                                                    </span>
                                                                </div>
                                                                <div class="mi__input input--bx__1">
                                                                	<span><label>MI</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-middle-name"
                                                                            name="manage-case-middle-name"
                                                                            value="<%=CMAHelper.GetValue(name.MI) %>">
                                                                    </span>
                                                                </div>
                                                                <div class="last-name__input input--bx__1">
                                                                	<span><label>Last Name</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-last-name"
                                                                            name="manage-case-last-name"
                                                                            value="<%=CMAHelper.GetValue(name.LastName) %>">
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                            	<div class="master__input input--bx__1">
                                                                	<span><label>Master #</label></span>
                                                                	<span>
                                                                        <% 
                                                                            string masterNo = Benefits != null && Benefits.Any() && Benefits.Where(_ => _.EpisodeID == episodeId).Any() ?
                                                                                                    Benefits.Where(_ => _.EpisodeID == episodeId).FirstOrDefault().MemberNumber : string.Empty;
                                                                        %>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-master-number"
                                                                            name="manage-case-master-number"
                                                                            value="<%=!string.IsNullOrEmpty(name.Names_ID.ToString()) ? CMAHelper.GetValue(name.Names_ID.ToString()) : string.Empty %>">
                                                                    </span>
                                                                </div>
                                                                <div class="member__input input--bx__1">
                                                                	<span><label>Member #</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-member-number"
                                                                            name="manage-case-member-number"
                                                                            value="<%=masterNo %>"
                                                                            ><!--TODO-->
                                                                    </span>
                                                                </div>
                                                                <div class="position__input input--bx__1">
                                                                	<span><label>Position</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-position"
                                                                            name="manage-case-position"><!--TODO-->
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                            	<div class="phone__input input--bx__1">
                                                                	<span><label>Phone</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-phone"
                                                                            name="manage-case-phone"
                                                                            value="<%=CMAHelper.GetValue(name.Phone1) %>">
                                                                    </span>
                                                                </div>
                                                                <div class="ext__input input--bx__1">
                                                                	<span><label>Ext</label></span>
                                                                	<span>
                                                                       <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-phone-extn"
                                                                            name="manage-case-phone-extn"
                                                                            value="<%=CMAHelper.GetValue(name.Phone1Ext) %>">
                                                                    </span>
                                                                </div>
                                                                <div class="salutation__input input--bx__1">
                                                                	<span><label>Salutation</label></span>
                                                                	<span>
                                                                        <input 
                                                                            type="text" 
                                                                            class="form-control"
                                                                            id="manage-case-salutaion"
                                                                            name="manage-case-salutation"
                                                                            value="<%=CMAHelper.GetValue(name.Salutation) %>">
                                                                    </span>
                                                                </div>
                                                                <div class="input--bx__1">
                                                                	<span><label>Age</label></span>
                                                                    <% 
                                                                    if (name.DOB.HasValue)
                                                                    {
                                                                        int Age = DateTime.Now.Date.Year - name.DOB.Value.Year;
                                                                    %>
                                                                	<span>
                                                                        <%=Age %>
                                                                    </span>
                                                                    <% 
                                                                    }
                                                                    %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-3">
                                                        	<div class="mng-btns--right text-right">
                                                            	<button type="button">Edit Names</button>
                                                                <button type="button">Manage Notes</button>
                                                                <%--<button type="button">Maternity Outcomes</button>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="mng--inner--block__header">Episode of illness/injury</div>
                                                <div class="mng--inner--block block__height--sm">
                                                	<div class="app-table">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Description</th>
                                                                    <th>Diag</th>
                                                                    <th>Onset of Illness/Injury</th>
                                                                    <th>Episode No</th>
                                                                    <th>Region</th>
                                                                    <th>Episode Mgr</th>
                                                                    <th>Member#</th>
                                                                </tr>
                                                            </thead>
                                                            <% 
                                                                string comment = string.Empty;
                                                                if (Episodes != null && Episodes.Any())
                                                                {
                                                                    comment = Episodes.FirstOrDefault().Comment;
                                                            %>
                                                            <tbody>
                                                            <%
                                                                    foreach (var episode in Episodes)
                                                                    {
                                                            %>
                                                                <tr>
                                                                    <td></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=CMAHelper.GetValue(episode.Description) %></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=CMAHelper.GetValue(episode.DiagnosisType) %></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=episode.DateOnset.HasValue ? episode.DateOnset.Value.ToShortDateString() : string.Empty %></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=CMAHelper.GetValue(episode.EpisodeNo) %></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=CMAHelper.GetValue(episode.Region) %></td>
                                                                    <td style="cursor:pointer;" onclick="return UpdateCaseComment('<%=episode.EpisodeID.Trim()%>')"><%=CMAHelper.GetValue(episode.EpisodeMgr) %></td>
                                                                    <td></td><!--TODO  Member No--> 
                                                                </tr>
                                                                <input type="hidden" id="case-episode-comment-<%=episode.EpisodeID.Trim() %>" value="<%=CMAHelper.GetValue(episode.Comment)%>"/>
                                                            <% 
                                                                    }
                                                            %>
                                                            </tbody>
                                                            <%
                                                                }
                                                            %>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="mng--inner--block__header">Comments</div>
                                                <div class="mng--inner--block block__height--sm">
                                                	<p id="case-episode-comment"><%=comment %></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mar-top10">
                                            <div class="col-xs-4">
                                                <div class="mng--inner--block__header">Team</div>
                                                <div class="mng--inner--block block__height--md">
                                                	<div class="app-table">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th style="width:100px;">Relation</th>
                                                                    <th style="width:100px;">Last Name</th>
                                                                    <th style="width:100px;">First Name</th>
                                                                    <th style="width:150px;">Organization</th>
                                                                    <th>Phone</th>
                                                                    <th>Ext</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                 <% 
                                                                     if (EpisodeTeam!=null && EpisodeTeam.Any())
                                                                     {
                                                                         foreach(var epiTeam in EpisodeTeam)
                                                                         {
                                                                %>
                                                                        <tr>
                                                                            <td></td>
                                                                            <td>
                                                                                <% 
                                                                                    string RelationShip = RelationCodes.Any() && RelationCodes.Where(_ => _.Code1 == epiTeam.RelationCode).Any() ?
                                                                                                            RelationCodes.FirstOrDefault(_ => _.Code1 == epiTeam.RelationCode).Description
                                                                                                            : string.Empty;
                                                                                %>
                                                                                <%=RelationShip %>
                                                                            </td>
                                                                            <% 
                                                                                var episodeTeamName = EpisodeTeamNames.Any() ? EpisodeTeamNames.Where(_ => _.NameID == epiTeam.NameID).FirstOrDefault() : null;
                                                                                if (episodeTeamName!=null)
                                                                                {
                                                                            %>
                                                                                    <td><%=CMAHelper.GetValue(episodeTeamName.LastName) %></td>
                                                                                    <td><%=CMAHelper.GetValue(episodeTeamName.FirstName) %></td>
                                                                                    <% 
                                                                                        string orgName = string.Empty;
                                                                                        if (Organizations!=null
                                                                                                && Organizations.Any()
                                                                                                && episodeTeamName.Organization.HasValue
                                                                                                && Organizations.Where(_=>_.ORGANIZATION_ID == episodeTeamName.Organization).FirstOrDefault()!=null
                                                                                            )
                                                                                        {
                                                                                            orgName = Organizations.Where(_ => _.ORGANIZATION_ID == episodeTeamName.Organization).FirstOrDefault().NAME;
                                                                                        }

                                                                                    %>
                                                                                    <td><%=orgName %></td>
                                                                                    <td><%=CMAHelper.GetValue(episodeTeamName.Phone1) %></td>
                                                                                    <td><%=CMAHelper.GetValue(episodeTeamName.Phone1Ext) %></td>
                                                                            <%
                                                                                }
                                                                                else
                                                                                {
                                                                            %>
                                                                                    <td></td>
                                                                                    <td></td>
                                                                                    <td></td>
                                                                            <%
                                                                                }
                                                                            %>
                                                                        </tr>
                                                                <%
                                                                         }
                                                                     }
                                                                %>
                                                                
                                                              </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="mng--inner--block__header">Service Phase</div>
                                                <div class="mng--inner--block block__height--md">
                                                	<div class="app-table">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Service Type</th>
                                                                    <th>Phase</th>
                                                                    <th>Begin Date</th>
                                                                    <th>End Date</th>
                                                                    <th>Mgr</th>
                                                                    <th>Reason</th>
                                                                    <th>Referred By</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                    <% 
                                                                        if (ServicePhase != null && ServicePhase.Any())
                                                                        {
                                                                            foreach (var servicePhase in ServicePhase)
                                                                            {
                                                                    %>
                                                                            <tr>
                                                                                <td></td>
                                                                                <td>
                                                                                    <% 
                                                                                        string ServiceType = string.Empty;
                                                                                        ServiceType = !string.IsNullOrEmpty(servicePhase.CaseType)
                                                                                                        && ServicePhaseServiceTypeCodes != null
                                                                                                        && ServicePhaseServiceTypeCodes.Any()
                                                                                                        && ServicePhaseServiceTypeCodes.Where(_ => _.Code1 == servicePhase.CaseType).Any() ?
                                                                                                        ServicePhaseServiceTypeCodes.FirstOrDefault(_ => _.Code1 == servicePhase.CaseType).Description :
                                                                                                        string.Empty;
                                                                                        Response.Write(ServiceType);
                                                                                    %>
                                                                                </td>
                                                                                <td><%=CMAHelper.GetValue(servicePhase.Status) %></td>
                                                                                <td><%=servicePhase.BeginDate.HasValue ? 
                                                                                        servicePhase.BeginDate.Value.ToShortDateString() :
                                                                                        string.Empty
                                                                                    %>
                                                                                </td>
                                                                                <td><%=servicePhase.EndDate.HasValue ? 
                                                                                        servicePhase.EndDate.Value.ToShortDateString() :
                                                                                        string.Empty
                                                                                    %>
                                                                                </td>
                                                                                <td><%=CMAHelper.GetValue(servicePhase.CasePhaseMgr) %></td>
                                                                                <td>
                                                                                    <% 
                                                                                        string Reason = string.Empty;
                                                                                        Reason = !string.IsNullOrEmpty(servicePhase.Reason)
                                                                                                        && ServicePhaseReasonCodes != null
                                                                                                        && ServicePhaseReasonCodes.Any()
                                                                                                        && ServicePhaseReasonCodes.Where(_ => _.Code1 == servicePhase.Reason).Any() ?
                                                                                                        ServicePhaseReasonCodes.FirstOrDefault(_ => _.Code1 == servicePhase.Reason).Description :
                                                                                                        string.Empty;
                                                                                        Response.Write(Reason);
                                                                                    %>
                                                                                </td>
                                                                                <td></td><!--TODO Referred By -->
                                                                            </tr>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>
                                                              </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="mng--inner--block__header">Level of Care/Bed type</div><!--TODO-->
                                                <div class="mng--inner--block block__height--md">
                                                	<div class="app-table">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Level of Care</th>
                                                                    <th>Begin Date</th>
                                                                    <th>End Date</th>
                                                                    <th>Case Status</th>
                                                                    <th>Status Date</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                    <% 
                                                                        if (LevelOfCare!=null && LevelOfCare.Any())
                                                                        {
                                                                            foreach(var levelOfCare in LevelOfCare)
                                                                            {
                                                                    %>
                                                                        <tr>
                                                                            <td></td>
                                                                            <td>
                                                                                <% 
                                                                                    string levelOfCareDesc = string.Empty;
                                                                                    levelOfCareDesc = !string.IsNullOrEmpty(levelOfCare.LevelOfCare)
                                                                                                        && LevelOfCareCodes != null
                                                                                                        && LevelOfCareCodes.Any()
                                                                                                        && LevelOfCareCodes.Where(_ => _.Code1 == levelOfCare.LevelOfCare).Any() ?
                                                                                                        LevelOfCareCodes.FirstOrDefault(_ => _.Code1 == levelOfCare.LevelOfCare).Description :
                                                                                                        string.Empty;
                                                                                    Response.Write(levelOfCareDesc);
                                                                                %>
                                                                            </td>
                                                                           <td><%=levelOfCare.BeginDate.HasValue ? 
                                                                                        levelOfCare.BeginDate.Value.ToShortDateString() :
                                                                                        string.Empty
                                                                                %>
                                                                            </td>
                                                                            <td><%=levelOfCare.EndDate.HasValue ? 
                                                                                    levelOfCare.EndDate.Value.ToShortDateString() :
                                                                                    string.Empty
                                                                                %>
                                                                            </td>
                                                                            <td>
                                                                                <%=CMAHelper.GetValue(levelOfCare.LOCStatus) %>
                                                                            </td>
                                                                            <td><%=levelOfCare.LOCStatusDate.HasValue ? 
                                                                                    levelOfCare.LOCStatusDate.Value.ToShortDateString() :
                                                                                    string.Empty
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
                                                </div>
                                            </div>
                                        </div>
                                        
                                  	</div>
                                    
                                    <!-- tab_2 -->
                                    
                                  	<div class="tab-pane fade" id="Benefits">
                                    	No Content
                                  	</div>
                                  	<div class="tab-pane fade" id="Diagnose">
                                    	No Content
                                  	</div>
                                  	<div class="tab-pane fade" id="Assesments">
                                    	No Content
                                  	</div>
                                    <div class="tab-pane fade" id="Care-Cost">
                                    	No Content
                                  	</div>
                                    <div class="tab-pane fade" id="Guidlines">
                                    	No Content
                                  	</div>
                                    <div class="tab-pane fade" id="Profile">
                                    	No Content
                                  	</div>
                                </div>
                            </div>
                        </div>
                    </div>
            </section>
        </div>
    </div>
</div>


<% 
    }
%>