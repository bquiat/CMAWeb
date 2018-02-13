<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<%=Model.InputParam.ContainerId%>||
<div id="<%=Model.InputParam.ContainerId%>-window">
    <header class="app-header ">
        <h1><span class="header-icon"></span><%=Model.Caption%></h1>
        <div class="header-window-btn">
            <ul>
                <%--<li class="w-minimz" onclick="Minimize('find-case');"><a href="#">Minimize</a></li>
                <li class="w-maxmiz" onclick="Maximize('find-case');"><a href="#">Maximize</a></li>--%>
                <li class="w-close" onclick="CloseWindow('find-case');"><a href="#">Close</a></li>
            </ul>
        </div>
    </header>
    <div class="overflow--container">
        <div class="inner-window window-fluid inner-window-style" id="addeditview-<%=Model.InputParam.ContainerId%>">
        </div>
        <div class="inner-window window-fluid inner-window-style" id="lstview-<%=Model.InputParam.ContainerId%>">
            <section class="window-inner-header">
                <div class="wdw-hdr-block">
                    <div class="wdw-hdr-block-title">Filter</div>
                    <div class="row">
                        <div class="col-xs-12 tp-pdd--1">
                            <div class="row">
                                <div class="col-xs-1">
                                    <label>Criteria:</label>
                                </div>
                                <div class="col-xs-11">
                                    <span class="txtbx--1">
                                        <label>Search Text</label>
                                        <input 
                                                type="text" 
                                                class="form-control searchText" 
                                                value="<%=(!string.IsNullOrEmpty(Model.SearchText) ? Model.SearchText : "")%>"
                                                style="width:450px;" 
                                                id="txt-find-case-search" 
                                                name="txt-find-case-search"
                                                onkeyUp="SearchManageCase(this)"
                                             />
                                    </span>
                                    <span class="search-btn no--float">
                                        <button 
                                            type="button" 
                                            class="search" 
                                            id="btn-search" 
                                            onclick="javascript:return searchCase();">Search</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="inner-window-body" id="find-case-search-result">
            </section>
        </div>
    </div>
</div>

<script type="text/javascript">
    function SearchManageCase(evt)
    {
        if (event.keyCode == 13) {
            searchCase();
        }
    }
</script>