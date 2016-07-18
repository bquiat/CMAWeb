<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<nav class="app-nav">
    <div class="main-nav col-xs-12">
        <ul class="main-nav-list">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">File</a>
                <%--<ul role="menu" class="dropdown-menu">
                            <li><a href="#">Manage Case</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Manage Review <span class="caret"></span></a>
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
                            </li>
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Edit</a>
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Record</a>
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Activities</a>
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Maintain</a>
                <ul role="menu" class="dropdown-menu">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Episode Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="decl" data-input3="declined-closed-reason" data-input4="Declined/Closed Reason">Declined/Closed Reason</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="diag" data-input3="diagnosis-category" data-input4="Diagnosis Category">Diagnosis Category</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="int" data-input3="level-of-care-bed-type" data-input4="Level of Care/Bed Type">Level of Care/Bed Type</a>
                            </li>
                            <li><a href="#">Profile Type</a></li>
                            <li><a href="#">Profile</a></li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="pend" data-input3="pended-reason" data-input4="Pended Reason">Pended Reason</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="svcs" data-input3="services" data-input4="Services">Services</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="et" data-input3="service-type" data-input4="Service Type">Service Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="trel" data-input3="term-relation" data-input4="Term Relation">Term Relation</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Codes <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-submenu">
                            <li>
                                <a href="/manage/list?menu=CODES&code=ACT">Activity Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=ASSE">Assesment Type</a>
                            </li>
                            <li>
                                <a class="menu-item" href="#" data-type="list" data-input1="codes" data-input2="ctry" data-input3="countries" data-input4="Countries">Countries</a>
                            </li>
                            <li><a href="#">Ethencity</a></li>
                            <li><a href="#">Exception Criteria</a></li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=FS">Fee Schedule</a>
                            </li>
                            <li><a href="#">Group/Client LOB</a></li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=PPT">Group/Client Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=LANG">Language</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=NAME">Name Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=NT">Note Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=PYRT">Payor Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=PHON">Phone Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=PACT">Plan Item Type</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=LOBT">Plan/LOB Type</a>
                            </li>
                            <li><a href="#">Plan/LOB Contract Status</a></li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=PSS">Psychological Stressors</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=REG">Region</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=SERV">Resource Services</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=ST">States</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=GT">User Group</a>
                            </li>
                            <li>
                                <a href="/manage/list?menu=CODES&code=UACT">Work Activity</a>
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
                    <li class="dropdown">
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
                    </li>
                    <li><a href="/manage/list?menu=CPT">CPT-4-CM</a></li>
                    <li><a href="#">HCPC</a></li>
                    <li><a href="/manage/list?menu=DSM">DSM-4</a></li>
                    <li><a href="/manage/list?menu=DRG">DRG</a></li>
                    <li><a href="/manage/list?menu=ICD">ICD-9-CM</a></li>
                    <li class="divider"></li>
                    <li><a href="/manage/list?menu=Namez">Names</a></li>
                    <li><a href="/manage/list?menu=Organizations">Organizations</a></li>
                    <li><a href="#">Plan/LOB ID</a></li>
                    <li><a href="/manage/list?menu=StdBenefits">Standard</a></li>
                    <li class="divider"></li>
                    <li><a href="/manage/list?menu=ActCodes">Activity Codes</a></li>
                    <li><a href="/manage/list?menu=ActOver">Activity Overrides</a></li>
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
        </ul>
    </div>
    <div class="sub-nav col-xs-12">
        <ul class="sub-nav-list">
            <li><a href="#">
                <img src="/content/images/folder.png" alt="Previous" /></a></li>
            <li><a href="#">
                <img src="/content/images/icn-folder1.png" alt="Next" /></a></li>
            <li><a href="#">
                <img src="/content/:images/icn-file-search.png" alt="Add" /></a></li>
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
