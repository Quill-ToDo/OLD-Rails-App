"use strict";

$(document).ready(function(){
    var modal = $("#modalDialog");
    var btn = $("#btn-add");
    var span = $("#close");
    btn.on('click', function(){
        modal.toggle();
    });
    span.on('click', function(){
        
        modal.hide();
    });
});
