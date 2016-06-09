function showAddForm()
{   
    $("#ListRecord").hide(500);
    $("#AddNewRecord").show(100);
    $("#AddNewRecord").find(":input").each(function () {
        var id = $(this).attr('id');
        if (id != "tableName" && id!="columnList" && id!="nonStringColumnList" && id!="primaryKey" )
            $(this).val('');
    })
    $("#recordId").val('');
    $("#primaryKeyValue").val('');
    return false;
}
function closeAddForm()
{   
    $("#AddNewRecord").hide(500);
    $("#ListRecord").show(100);
    return false;
}

function deleteRecord(id, name)
{
    var r = confirm('Are you sure you want to delete this record? Once deleted, this record cannot be recovered?')
    if (r)
    {
        $overlay = $("#ajax-Page-overlay");
        $overlay.fadeIn();
        $("#overlayText").text('Deleting the Record....');
        var serializedData = "table-name=" + name + "&id=" + $("#list" + id + "Key").val();
        $.ajax({
            url: "/Manage/DeleteRecord",
            type: "post",
            data: serializedData,
            success: function (response, textStatus, jqXHR) {
                alert('Record Deleted successfully');
                $("#List" + id).remove();
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

function editForm(id)
{
    var $tr = $("#List" + id);
    var headerList = $("#headerList").val().split(',');
    var primaryKey = $("#primaryKey").val();
    var primaryKeyValue = "";
    for (var i = 0; i < headerList.length; i++)
    {
        var col = headerList[i];
        var val = $.trim($("#List" + id).find("#td" + col).text());
        if (col == primaryKey)
            primaryKeyValue = val;
        $("#txt" + col).val(val);
    }
    $("#primaryKeyValue").val(primaryKeyValue);
    $("#recordId").val($("#list" + id + "Id").val());
    $("#ListRecord").hide(500);
    $("#AddNewRecord").show(100);
    return false;
}
$("#searchText").keyup(function (event) {
    if (event.keyCode == 13) {
        
        $("#btnSearch").click();
    }
});
function searchText(name)
{
    var searchText = $.trim($("#searchText").val());
    $overlay = $("#ajax-Page-overlay");
    $overlay.fadeIn();
    $("#overlayText").text('Searching....');
    var serializedData = "searchText=" + searchText;

    $.ajax({
        url: "/Manage/List?menu=" + name,
        type: "post",
        data: serializedData,
        success: function (response, textStatus, jqXHR) {
            $("#ListRecord").html(response);
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

function saveAddForm()
{
    bError = false;
    $("#AddNewRecord").find(":input").each(function () {
        if (!bError) {
            var required = $(this).attr('data-required');
            var length = $(this).attr('data-length');
            if (required == "1" && $(this).val() == "") {
                bError = true;
                alert('This Field is Required. Please Add the Value.');
                $(this).focus();
            }
            else if (length == 0 && isNaN($(this).val()))
            {
                bError = true;
                alert('Invalid Input. Only Numbers Allowed.');
                $(this).focus();
            }
        }
    })

    if (!bError)
    {
        $overlay = $("#ajax-Page-overlay");
        $overlay.fadeIn();
        $("#overlayText").text('Saving the Record....');
        var serializedData = $("#frmAddEditRecord").serialize();
        $.ajax({
            url: "/Manage/SaveRecord",
            type: "post",
            data: serializedData,
            success: function (response, textStatus, jqXHR) {
                alert('Record Updated successfully');
                location.href = "/Manage/List?menu=" + $("#tableName").val();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            },
            complete: function () {
                //$overlay.fadeOut();
            }
        });
    }

    return false;
}