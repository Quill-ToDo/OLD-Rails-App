//= require popper
//= require tempus-dominus

$(document).ready(function () {
    var modal = $("#modalDialog");
    var btn = $("#btn-add");
    var span = $("#close");

    btn.on('click', function () {
        console.log("here0")
        if (modal.css('display') == "none") {
            $.get({
                url: '/tasks/new',
                dataType: 'json'
            }).then((data) => {
                $('#modalDialog').html(data.html);
                modal.toggle();
                var options = {
                    display: {
                        buttons: {
                            close: true
                        },
                        // toolbarPlacement: "top"
                    }
                }
                var start = new tempusDominus.TempusDominus(document.getElementById('datetime-picker-start'), options);
                var end = new tempusDominus.TempusDominus(document.getElementById('datetime-picker-due'), options);
            });
        } else {
            modal.toggle();
        }
    });
});