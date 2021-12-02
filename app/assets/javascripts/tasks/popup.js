"use strict";

$(document).ready(function () {
    var modal = $("#modalDialog");
    var btn = $("#btn-add");
    var span = $("#close");

    btn.on('click', function () {
        $.get({
            url: '/tasks/new',
            dataType: 'json',
            success: function (data) {
                $('#modalDialog').html(data.html);
                modal.toggle();
            }
        });
    });
    // span.on('click', function(){

    //     modal.hide();
    // });
});