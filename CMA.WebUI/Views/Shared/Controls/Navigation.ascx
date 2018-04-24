<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<nav class="app-nav">
    <div class="main-nav col-xs-12">
        <ul class="main-nav-list">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">File</a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Edit</a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Record</a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Activities</a>
                <ul role="menu" class="dropdown-menu">
                            <li><a href="#"
                                    class="menu-item"
                                    data-type="manage-case"
                                    data-container-name="manage-case"
                                    data-container-caption="Manage Case">Manage Case</a></li>
                            <li><a href="#"
                                    class="menu-item"
                                    data-type="manage-review"
                                    data-container-name="manage-review"
                                    data-container-caption="Manage Review">Manage Review</a></li>
                            <li class="divider"></li>
                            <li><a href="#"
                                    class="menu-item"
                                    data-type="manage-activity"
                                    data-container-name="manage-activity"
                                    data-container-caption="Manage Activity">Manage Activity</a></li>
                            <li><a href="#">Manage Billing</a></li>
                            <li>
                                <a href="#"
                                    class="menu-item"
                                    data-type="manage-document"
                                    data-container-name="manage-document"
                                    data-container-caption="Manage Document">Manage Document</a></li>
                            <li><a href="#">Manage Notes</a></li>
                            <li><a href="#">Manage Tasks</a></li>
                            <li class="divider"></li>
                            <li><a href="#">Add Activity</a></li>
                            <li><a href="#">Add Document</a></li>
                            <li><a href="#">Add Note</a></li>
                            <li><a href="#">Add Task</a></li>
                        </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Maintain</a>
                <ul role="menu" class="dropdown-menu">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Episode Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="decl" data-container-name="declined-closed-reason" data-container-caption="Declined/Closed Reason">Declined/Closed Reason</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="diag" data-container-name="diagnosis-category" data-container-caption="Diagnosis Category">Diagnosis Category</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="int" data-container-name="level-of-care-bed-type" data-container-caption="Level of Care/Bed Type">Level of Care/Bed Type</a>
                            </li>
                            <%--<li><a href="#">Profile Type</a></li>
                            <li><a href="#">Profile</a></li>--%>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="pend" data-container-name="pended-reason" data-container-caption="Pended Reason">Pended Reason</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="svcs" data-container-name="services" data-container-caption="Services">Services</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="et" data-container-name="service-type" data-container-caption="Service Type">Service Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="trel" data-container-name="term-relation" data-container-caption="Term Relation">Term Relation</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="act" data-container-name="activity-type" data-container-caption="Activity Type">Activity Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="asse" data-container-name="assesment-type" data-container-caption="Assesment Type">Assesment Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="ctry" data-container-name="countries" data-container-caption="Countries">Countries</a>
                            </li>
                            <%--<li><a href="#">Ethencity</a></li>
                            <li><a href="#">Exception Criteria</a></li>--%>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="fs" data-container-name="fee-schedule" data-container-caption="Fee Schedule">Fee Schedule</a>
                            </li>
                            <%--<li><a href="#">Group/Client LOB</a></li>--%>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="ppt" data-container-name="group-client-type" data-container-caption="Group/Client Type">Group/Client Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="lang" data-container-name="language" data-container-caption="Language">Language</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="name" data-container-name="name-type" data-container-caption="Name Type">Name Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="nt" data-container-name="note-type" data-container-caption="Note Type">Note Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="pyrt" data-container-name="payor-type" data-container-caption="Payor Type">Payor Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="phon" data-container-name="phon-type" data-container-caption="Phone Type">Phone Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="decl" data-container-name="plan-item-type" data-container-caption="Plan Item Type">Plan Item Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="lobt" data-container-name="plan-lob-type" data-container-caption="Plan/LOB Type">Plan/LOB Type</a>
                            </li>
                            <%--<li><a href="#">Plan/LOB Contract Status</a></li>--%>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="pss" data-container-name="psychlogical-stressors" data-container-caption="Psychological Stressors">Psychological Stressors</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="reg" data-container-name="region" data-container-caption="Region">Region</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="serv" data-container-name="resource-services" data-container-caption="Resource Services">Resource Services</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="st" data-container-name="states" data-container-caption="States">States</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="gt" data-container-name="user-group" data-container-caption="User Group">User Group</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-css="width60" data-table="codes" data-query="uact" data-container-name="work-activity" data-container-caption="Work Activity">Work Activity</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Review Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li><a href="#">Additional Info Reason</a></li>
                            <li><a href="#">Care Category</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Item Codes <span class="caret"></span></a>
                                <ul role="menu" class="dropdown-submenu-inner">
                                    <li><a href="#">AAA</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Mode</a></li>
                            <li><a href="#">Request Reason</a></li>
                            <li><a href="#">Request Status</a></li>
                            <li><a href="#">Review Type</a></li>
                            <li><a href="#">Second Review Reason</a></li>
                        </ul>
                    </li>
                    <%--<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Maternity Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li><a href="#">Manage Case</a></li>
                            <li><a href="#">Manage Review</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Add Document <span class="caret"></span></a>
                                <ul role="menu" class="dropdown-submenu-inner">
                                    <li><a href="#">Manage Case</a></li>
                                    <li><a href="#">Manage Review</a></li>
                                    <li><a href="#">Add Document</a></li>
                                    <li><a href="#">Add Note</a></li>
                                    <li><a href="#">Add Task</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Add Note</a></li>
                            <li><a href="#">Add Task</a></li>
                        </ul>
                    </li>--%>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="cpt" data-query="" data-container-name="cpt-4-cm" data-container-caption="CPT-4-CM">CPT-4-CM</a>
                    </li>
                    <%--<li><a href="#">HCPC</a></li>--%>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="dsm" data-query="" data-container-name="dsm-4" data-container-caption="DSM-4">DSM-4</a>
                    </li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="drg" data-query="" data-container-name="drg" data-container-caption="DRG">DRG</a>
                    </li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="ICD" data-query="" data-container-name="icd-9-cm" data-container-caption="ICD-9-CM">ICD-9-CM</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="namez" data-query="" data-container-name="names" data-container-caption="Names">Names</a>
                    </li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="organization" data-query="" data-container-name="organizations" data-container-caption="Organizations">Organizations</a>
                    </li>
                    <li><a href="#">Plan/LOB ID</a></li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="codes" data-query="stdbenefits" data-container-name="standard-benefits" data-container-caption="Standard">Standard</a> 
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="ActCodes" data-query="" data-container-name="activity-codes" data-container-caption="Activity Codes">Activity Codes</a>
                    </li>
                    <li>
                        <a class="menu-item" href="#" data-type="list" data-table="ActOver" data-query="" data-container-name="activity-overrides" data-container-caption="Activity Overrides">Activity Overrides</a>
                    </li>
                    <li><a href="#">Assesment Codes</a></li>
                    <li class="divider"></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Resources <span class="caret"></span></a>
                        <%--<ul role="menu" class="dropdown-submenu">
                            <li><a href="#">Manage Case</a></li>
                            <li><a href="#">Manage Review</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Add Document <span class="caret"></span></a>
                                <ul role="menu" class="dropdown-submenu-inner">
                                    <li><a href="#">Manage Case</a></li>
                                    <li><a href="#">Manage Review</a></li>
                                    <li><a href="#">Add Document</a></li>
                                    <li><a href="#">Add Note</a></li>
                                    <li><a href="#">Add Task</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Add Note</a></li>
                            <li><a href="#">Add Task</a></li>
                        </ul>--%>
                    </li>
                    <li><a href="#">Networks</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Users</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Reports</a>
                <%--<ul role="menu" class="dropdown-menu">
                    <li><a href="#">Manage Case</a></li>
                    <li><a href="#">Manage Review</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Manage Activity</a></li>
                    <li><a href="#">Manage Billing</a></li>
                    <li><a href="#">Manage Document</a></li>
                    <li><a href="#">Manage Notes</a></li>
                    <li><a href="#">Manage Tasks</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Add Activity</a></li>
                    <li><a href="#">Add Document</a></li>
                    <li><a href="#">Add Note</a></li>
                    <li><a href="#">Add Task</a></li>
                </ul>--%>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Help</a>
                <%--<ul role="menu" class="dropdown-menu">
                    <li><a href="#">Manage Case</a></li>
                    <li><a href="#">Manage Review</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Manage Activity</a></li>
                    <li><a href="#">Manage Billing</a></li>
                    <li><a href="#">Manage Document</a></li>
                    <li><a href="#">Manage Notes</a></li>
                    <li><a href="#">Manage Tasks</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Add Activity</a></li>
                    <li><a href="#">Add Document</a></li>
                    <li><a href="#">Add Note</a></li>
                    <li><a href="#">Add Task</a></li>
                </ul>--%>
            </li>
            <% 
            if (Request.IsAuthenticated)
            {
            %>
            <li>
                <a href="/Account/LogOff">LogOut</a>
            </li>
            <% 
            }
            %>
        </ul>
    </div>
    <div class="sub-nav col-xs-12">
        <ul class="sub-nav-list">
            <li><a href="#">
                <img src="/content/images/folder.png" alt="Previous" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-folder1.png" alt="Next" /></a></li>
            <li>
                <a class="menu-item" href="#" data-type="list" data-table="find_case" data-query="" data-container-name="find-case" data-container-caption="Find Case">
                    <img src="/content/images/icn-file-search.png" alt="Add" />
                </a>
            </li>
            <li class="ver-divider"><a href="#">
                <img src="/content/images/icn-notes.png" alt="Delete" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-print.png" alt="Cancel" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-file1.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-edit.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/folder.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-folder1.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-file-search.png" alt="" /></a></li>
            <li class="ver-divider"><a href="#">
                <img src="/content/images/icn-notes.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-print.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-file1.png" alt="" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-edit.png" alt="" /></a></li>
        </ul>
    </div>
</nav>
