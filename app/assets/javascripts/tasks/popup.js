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
            $("#new-wrapper").removeClass("from-calendar");
        }
    }

    if (target.matches("#new-filter") && $("#new-wrapper").is(":visible")) {
        $("#new-wrapper").toggle();
        $("#new-wrapper").remove("#new-filter");
        $("#new-wrapper").removeClass("from-calendar");
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
        if (fieldData) {
            console.log("hi")
            $("#new-wrapper").append('<div id="new-filter"> </div>');
            $("#new-wrapper").addClass("from-calendar");
        }
        $("#new-wrapper").css("display", "flex");
    });
}