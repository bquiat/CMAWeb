<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span>Manage Documents</h1>
        <div class="header-window-btn">
            <ul>
                <li class="w-minimz" onclick="clasMinimaiz($(this));"><a href="#">minimize</a></li>
                <li class="w-maxmiz" onclick="clasMaximaiz($(this));"><a href="#" >Maximize</a></li>
                <li class="w-close" onclick="clascloseWin($(this));"><a href="#">Close</a></li>
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
                                        <th>Status</th>
                                        <th>User ID</th>
                                        <th>Return</th>
                                        <th>Note</th>
                                        <th>Type</th>
                                    </tr>
                                </thead>
                              <tbody>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>02/11/16 09:30AM</td>
                                    <td>POST</td>
                                    <td>CLD</td>
                                    <td>
                                        <div class="checkbox">
                                            <label>
                                               <input type="checkbox">
                                            </label>
                                        </div>
                                    </td>
                                    <td>Ldd1.0 Phone call from Mark at LO regarding the trial being</td>
                                    <td>Review: Case file</td>
                                </tr>
                              </tbody>
                            </table>
                        </div>
                    </section>
        </div>
    </div>
</div>
