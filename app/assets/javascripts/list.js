document.addEventListener('DOMContentLoaded', function () {

    $(".task-wrapper:first-child input").on("click", function () {
        var taskId = $($(this).attr("data-task-id")).selector;
        $.post("/tasks/complete_task", {
            id: taskId
        }).done()
        
    });
});