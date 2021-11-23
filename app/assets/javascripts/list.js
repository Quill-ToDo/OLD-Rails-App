"use strict";

document.addEventListener('DOMContentLoaded', function () {

    // Update task as completed on click
    $(".check-box-wrapper:first-child input").on("click", function () {
        var taskId = $(this).attr("data-task-id");
        // Add or remove strike-through
        if ($(this).prop("checked")) {
            $(`.title a[data-task-id='${taskId}']`).addClass("completed");
        } else {
            $(`.title a[data-task-id='${taskId}']`).removeClass("completed");
        }

        // Update task as complete
        $.post("/tasks/complete_task", {
            id: taskId
        })
    });

    // Collapse sections on click 
    $(".expandable-section-header").on("click", function () {
        var section = $($(this).siblings(".section-collapsible"));
        section.toggle(150, "swing");
        var symbol = $(this).children(".expand-symbol");
        var rotation = symbol.css("rotate");
        if (rotation == "45deg") {
            symbol.css("rotate", "-135deg");
        } else {
            symbol.css("rotate", "45deg");
        }
    });
});