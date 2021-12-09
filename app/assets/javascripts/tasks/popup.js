//= require popper
//= require tempus-dominus

$(document).ready(function () {
    $(document).on("click", function (e) {
        if (e.target) {
            newPopupHandler(e.target);
        }
    });
});

function newPopupHandler(target) {
    var btn = $(target).parents("#btn-add");
    if (btn.length) {
        if (!$("#new-wrapper").is(":visible")) {
            newPopupRender()
        } else {
            $("#new-wrapper").toggle();
            $("#new-wrapper").remove("#new-filter");
        }
    }

    if (target.matches("#new-filter") && $("#new-wrapper").is(":visible")) {
        console.log("hi");
        $("#new-wrapper").toggle();
    }
}

function newPopupRender(fieldData = null) {
    $.get({
        url: '/tasks/new',
        data: fieldData,
        dataType: 'json'
    }).then((data) => {
        $('#new-wrapper').html(data.html);
        var options = {
            display: {
                buttons: {
                    close: true,
                    // clear: true
                },
                // toolbarPlacement: "top"
            }
        }
        var start = new tempusDominus.TempusDominus(document.getElementById('datetime-picker-start'), options);
        var end = new tempusDominus.TempusDominus(document.getElementById('datetime-picker-due'), options);
        $("#new-wrapper").css("display", "flex");
        if (data.length) {
            $("#new-wrapper .mid-section").append('<div id="new-filter"> </div>');
            $("#new-wrapper").addClass(".from-calendar");
        }
    });
}