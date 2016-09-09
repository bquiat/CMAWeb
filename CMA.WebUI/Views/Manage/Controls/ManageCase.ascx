<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span>Manage Case</h1>
        <div class="header-window-btn">
            <ul>
                <li class="w-minimz" onclick="classMinimize($(this));"><a href="#">minimize</a></li>
                <li class="w-maxmiz" onclick="classMaximize($(this));"><a href="#" >Maximize</a></li>
                <li class="w-close" onclick="classcloseWin($(this));"><a href="#">Close</a></li>
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
                                <span class="first__name"><input type="text" class="form-control"></span>
                                <span class="middle__name"><input type="text" class="form-control"></span>
                                <span class="last__name"><input type="text" class="form-control"></span>
                            </div>
                            <div class="mng-case--tp__info">
                            	<span><label>Episode</label></span>
                                <span><input type="text" class="form-control"></span>
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
                                  <li class=""><a href="#Benefits" data-toggle="tab" aria-expanded="true">Benefits</a></li>
                                  <li class=""><a href="#Diagnose" data-toggle="tab" aria-expanded="false">Diagnose</a></li>
                                  <li class=""><a href="#Assesments" data-toggle="tab" aria-expanded="false">Assesments</a></li>
                                  <li class=""><a href="#Care-Cost" data-toggle="tab" aria-expanded="false">Care and Cost</a></li>
                                  <li class=""><a href="#Guidlines" data-toggle="tab" aria-expanded="false">Guidlines</a></li>
                                  <li class=""><a href="#Profile" data-toggle="tab" aria-expanded="false">Profile</a></li>
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
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="mi__input input--bx__1">
                                                                	<span><label>MI</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="last-name__input input--bx__1">
                                                                	<span><label>Last Name</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                            	<div class="master__input input--bx__1">
                                                                	<span><label>Master #</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="member__input input--bx__1">
                                                                	<span><label>Member #</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="position__input input--bx__1">
                                                                	<span><label>Position</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                            	<div class="phone__input input--bx__1">
                                                                	<span><label>Phone</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="ext__input input--bx__1">
                                                                	<span><label>Ext</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="salutation__input input--bx__1">
                                                                	<span><label>Salutation</label></span>
                                                                	<span>
                                                                        <input type="text" class="form-control">
                                                                    </span>
                                                                </div>
                                                                <div class="input--bx__1">
                                                                	<span><label>Age</label></span>
                                                                	<span>
                                                                        45
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-3">
                                                        	<div class="mng-btns--right text-right">
                                                            	<button type="button">Edit Names</button>
                                                                <button type="button">Manage Notes</button>
                                                                <button type="button">Maternity Outcomes</button>
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
                                                                    <th>Date/Time</th>
                                                                    <th>Status</th>
                                                                    <th>Note</th>
                                                                    <th>Type</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                              </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="mng--inner--block__header">Comments</div>
                                                <div class="mng--inner--block block__height--sm">
                                                	<p>PPI Case: Wendy Hills vs. Margot Werts<br>
Mediation: 01/11/2016; 03/24/2016 Trial: 02/19/2016 Cont to May 2016 Venue: LA Central</p>
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
                                                                    <th>Date/Time</th>
                                                                    <th>Status</th>
                                                                    <th>Note</th>
                                                                    <th>Type</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
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
                                                                    <th>Date/Time</th>
                                                                    <th>Status</th>
                                                                    <th>Note</th>
                                                                    <th>Type</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                              </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="mng--inner--block__header">Level of Care/Bed type</div>
                                                <div class="mng--inner--block block__height--md">
                                                	<div class="app-table">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th></th>
                                                                    <th>Date/Time</th>
                                                                    <th>Status</th>
                                                                    <th>Note</th>
                                                                    <th>Type</th>
                                                                </tr>
                                                            </thead>
                                                              <tbody>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>02/11/16 09:30AM</td>
                                                                    <td>POST</td>
                                                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                                                    <td>Review: Case file</td>
                                                                </tr>
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
