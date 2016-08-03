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
        url: "/Manage/GetEditData",
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
        url: "/Manage/GetEditData",
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
function refreshWindow(id)
{
    if ($("#dragZone").find("#" + id).length == 1)
        $("#dragZone").find("#" + id).remove();
    if ($("#" + id + "-tab").length == 1)
        $("#" + id + "-tab").remove();
}
$(".menu-item").click(function () {
    var type = $(this).attr('data-type');
    var tableName = $(this).attr('data-input1');
    var subQuery = $(this).attr('data-input2');
    var id = $(this).attr('data-input3');
    var menuName = $(this).attr('data-input4');
    $overlayText = $("#overlayText");
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    $overlayText.text('Refreshing....');
    var serializedData = "type=" + type + "&table=" + tableName + "&subquery=" + subQuery + "&id=" + id + "&menu=" + menuName;
    $.ajax({
        url: "/Manage/GetListData",
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
            }else
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
});
$(".searchText").keyup(function (event) {
    if (event.keyCode == 13) {
        var id = $(this).attr('data-id');
        $("#btn-" + id + "-search").click();
    }
});

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
        url: "/Manage/GetListData",
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