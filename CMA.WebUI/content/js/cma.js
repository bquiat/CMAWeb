var global_case_Id = 0;

function deleteRecord(type, key, value, menu, tablename, subquery, id)
{
    var r = confirm('Are you sure you want to delete this record? Once deleted, this record cannot be recovered?')
    if (r)
    {
        $overlayText = $("#overlayText");
        $overlay = $("#ajax-Page-overlay");
        $overlay.fadeIn();
        $overlayText.text('Deleting the Record....');
        var serializedData = "type=" + type + "&key=" + key + "&val=" + value + "&menu=" + menu + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;

        $.ajax({
            url: "/Manage/DeleteRecord",
            type: "post",
            data: serializedData,
            success: function (response, textStatus, jqXHR) {
                alert(menu + ' Deleted successfully');
                var id = response.substring(0, response.indexOf('||')).trim();
                var content = response.substring(response.indexOf('||') + 2).trim();
                if ($("#pageContent").find("#" + id + "-window").length > 0) {
                    $("#pageContent").find("#" + id + "-window").html(content);
                    $("#lstview-" + id).slideDown(100);
                    $("#addeditview-" + id).slideUp(100);
                    refreshWindow(id);
                } else
                    $("#pageContent").append(content);
                openNewTab(id);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            },
            complete: function () {
                $overlay.fadeOut();
            }
        });
    }
    return false;
}
function captureEnterKey(e, obj, type, menu, tableName, subQuery, containerId)
{
    var code = e.keyCode ? e.keyCode : e.which;
    if (code == 13) {//Enter Key
        return searchText(type, menu, tableName, subQuery, containerId);
    }
}

function showhide(showid, hideid)
{
    if (($("#" + showid).length > 0) && ($("#" + hideid).length > 0)) {
        $("#" + showid).slideDown(100);
        $("#" + hideid).slideUp(100);
    }
    return false;
}
function addNewRecord(type, menu, tablename, subquery, id) {
    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    var serializedData = "edit=0&type=" + type + "&menu=" + menu + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;

    $overlayText.text('Loading to Add New ' + menu + '....');
    $.ajax({
        url: "/Manage/GetEdit",
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            $("#lstview-" + id).slideUp(100);
            $("#addeditview-" + id).slideDown(100);
            $("#addeditview-" + id).html(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        },
        complete: function () {
            $overlay.fadeOut();
        }
    });
    return false;
}
function editRecord(type,key,value,menu,tablename,subquery,id)
{
    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    var serializedData = "edit=1&type=" + type + "&key=" + key + "&val=" + value + "&menu=" + menu + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;
    $overlayText.text('Loading the ' + menu + '....');
    $.ajax({
        url: "/Manage/GetEdit",
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            $("#lstview-" + id).slideUp(100);
            $("#addeditview-" + id).slideDown(100);
            $("#addeditview-" + id).html(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        },
        complete: function () {
            $overlay.fadeOut();
        }
    });
    return false;
}
function saveRecord(id,type,menu,tablename,subquery,id)
{
    bError = false;
    $("#frm-" + id + "-edit").find(".required").each(function () {
        if (!bError) {
            if ($(this).val() == "") {
                bError = true;
                alert('This Field is Required. Please Add the Value.');
                $(this).focus();
            }
        }
    });

    if (!bError) {
        $overlayText = $("#overlayText");
        $overlay = $("#ajax-Page-overlay");
        $overlay.fadeIn();
        var serializedData = $("#frm-" + id + "-edit").serialize();
        $overlayText.text('Saving the ' + menu + '....');
        serializedData += "&type=" + type + "&menu=" + menu + "&table=" + tablename + "&subquery=" + subquery + "&id=" + id;

        $.ajax({
            url: "/Manage/SaveRecord",
            type: "post",
            data: serializedData,
            success: function (response, textStatus, jqXHR) {
                alert(menu + ' Updated successfully');
                var id = response.substring(0, response.indexOf('||')).trim();
                var content = response.substring(response.indexOf('||') + 2).trim();
                if ($("#pageContent").find("#" + id + "-window").length > 0) {
                    $("#pageContent").find("#" + id + "-window").html(content);
                    $("#lstview-" + id).slideDown(100);
                    $("#addeditview-" + id).slideUp(100);
                    refreshWindow(id);
                } else
                    $("#pageContent").append(content);
                openNewTab(id);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            },
            complete: function () {
                $overlay.fadeOut();
            }
        });
    }
    return false;
}

function OpenManageCase(NameID, id)
{
    global_case_Id = id;
    OpenMenu("manage-case", "", "manage-case", "Manage Case", "");
    return false;
}

function refreshWindow(id)
{
    if ($("#dragZone").find("#" + id).length == 1)
        $("#dragZone").find("#" + id).remove();
    if ($("#" + id + "-tab").length == 1)
        $("#" + id + "-tab").remove();
}
$(".menu-item").click(function () {
    var type = $(this).data('type');
    var tableName = $(this).data('table');
    var id = $(this).data('container-name');
    var menuName = $(this).data('container-caption');
    var subQuery = $(this).data('query');
    OpenMenu(type, tableName, id, menuName, subQuery);
    return false;
});

function OpenMenu(type,tableName,id,menuName,subQuery)
{   
    //Going to reset these vars so we open the find case since there is no global case id.
    //Might have to do this for other windows as well. 
    if ((type == "manage-case"
                || type == "manage-document"
                || type == "manage-review"
                || type == "manage-activity")
            && global_case_Id == 0) {
        type = "list";
        tableName = "find_case";
        subQuery = "";
        id = "find-case";
        menuName = "Find Case";
    }

    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    $overlayText.text('Refreshing....');
    var serializedData = "type=" + type + "&id=" + id + "&menu=" + menuName;
    if (type == "list") {
        var serializedData = serializedData + "&table=" + tableName + "&subquery=" + subQuery;
    }

    if (global_case_Id > 0)
        serializedData += "&NameID=" + global_case_Id;

    $.ajax({
        url: "/Manage/GetWindow",
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            var id = response.substring(0, response.indexOf('||')).trim();
            var content = response.substring(response.indexOf('||') + 2).trim();
            if ($("#pageContent").find("#" + id + "-window").length > 0) {
                $("#pageContent").find("#" + id + "-window").html(content);
                $("#lstview-" + id).slideDown(100);
                $("#addeditview-" + id).slideUp(100);
                refreshWindow(id);
            } else
                $("#pageContent").append(content);
            openNewTab(id);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        },
        complete: function () {
            $overlay.fadeOut();
        }
    });
}

$(document).ready(function () {
    $(".searchText").keyup(function (event) {
        if (event.keyCode == 13) {
            var id = $(this).data('id');
            $("#btn-" + id + "-search").click();
        }
    });
})

function UpdateCaseComment(EpisodeID)
{
    $("#case-episode-comment").html($("#case-episode-comment-" + EpisodeID).val());
    return false;
}

function searchCase()
{
    var searchText = $("#txt-find-case-search").val().trim();
    if (searchText == "") {
        alert('Please enter the Search Criteria');
        return false;
    }

    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    var serializedData = "SearchText=" + searchText;

    $overlayText.text('Searching the Case ' + searchText + '....');
    $.ajax({
        url: "/Manage/GetCaseSearch",
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            $("#find-case-search-result").html(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        },
        complete: function () {
            $overlay.fadeOut();
        }
    });
    return false;
}
function searchText(type, menu, tableName, subQuery, id)
{
    var $searchText = $("#txt-" + id + "-search");
    if ($searchText.val().trim() == "")
    {
        alert('Please enter the Search Text');
        $searchText.focus();
        return false;
    }

    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    $overlayText.text('Searching....');
    var serializedData = "type=" + type + "&table=" + tableName + "&subquery=" + subQuery + "&id=" + id + "&menu=" + menu;
    serializedData += "&searchText=" + $searchText.val();
    $.ajax({
        url: "/Manage/GetWindow",
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            var id = response.substring(0, response.indexOf('||')).trim();
            var content = response.substring(response.indexOf('||') + 2).trim();
            if ($("#pageContent").find("#" + id + "-window").length > 0) {
                $("#pageContent").find("#" + id + "-window").html(content);
                $("#lstview-" + id).slideDown(100);
                $("#addeditview-" + id).slideUp(100);
                refreshWindow(id);
            } else
                $("#pageContent").append(content);
            openNewTab(id);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        },
        complete: function () {
            $overlay.fadeOut();
        }
    });
    return false;
}

function validateLogin()
{
    if ($("#txtUsername").val().trim() == "")
    {
        alert('Please enter the Username');
        $("#txtUsername").focus();
        return false;
    }
    if ($("#txtPassword").val().trim() == "") {
        alert('Please enter the Password');
        $("#txtPassword").focus();
        return false;
    }
    return true;
}