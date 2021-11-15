"use strict";

document.addEventListener('DOMContentLoaded', function () {

// Update task as completed on click
$(".check-box-wrapper:first-child input").on("click", function () {
    var taskId = $($(this).attr("data-task-id")).selector;
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
});