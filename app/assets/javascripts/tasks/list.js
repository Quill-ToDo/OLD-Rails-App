
document.addEventListener('DOMContentLoaded', function () {
    completeTaskHandler();
    // showPopupHandler();
});


function showPopupHandler() {
    // Render popup for this task on click
    $(".task-wrapper .title a").on("click", function () {
        console.log("click on task name");
        var id = $(this).attr("data-task-id");
        $.get({
            url: `/tasks/${id}`,
            dataType: "json",
            success: function (data) {
                $("#show-wrapper").html(data.html);
                $("#show-wrapper").toggle();
                completeTaskHandler();
            }
        });

        // Hide and remove this handler on clicking something other than the show popup
        $("#show-wrapper").on('click', function (e) {
            if ($(e.target).closest("#show-wrapper .mid-section").length === 0) {
                console.log("click off show");
                $("#show-wrapper").toggle();
                // $("#show-wrapper").off('click');
            }
        });
    });
}

function completeTaskHandler(successCallback) {
    // Update task as completed on click
    $(".check-box-wrapper:first-child input").on("click", function () {
        var taskId = $(this).attr("data-task-id");
        console.log("completeTask")
        // Add or remove strike-through

        // Update task as complete
        $.post("/tasks/complete_task", {
            id: taskId,
            success: successCallback
        });

        if ($(this).prop("checked")) {
            $(`.title a[data-task-id='${taskId}']`).addClass("completed");
        } else {
            $(`.title a[data-task-id='${taskId}']`).removeClass("completed");
        }

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
}

function reRenderList() {
    console.log("rerender list");
    $.get({
        url: "/tasks/update_partials",
        dataType: "json",
        success: function (data) {
            $("#list-wrapper").html(data.html);
        }
    });
}