document.addEventListener('DOMContentLoaded', function () {
    initHandlers();
});

function initHandlers() {
    console.log("handlers");
    $(document).on("click", function (e) {
        if (e.target) {
            let target = e.target;
            console.log(target);
            collapseSectionHandler(target);
            // completeTaskHandler(target);
            // showPopupHandler();
        }
        // showPopupHandler()
    })
    // completeTaskHandler();
}

function collapseSectionHandler(target) {
    // Collapse sections on click 
    if ($(target).parents(".expandable-section-header").length) {
        // $(".expandable-section-header").on("click", function () {
        var section = $($(this).siblings(".section-collapsible"));
        section.toggle(150, "swing");
        var symbol = $(this).children(".expand-symbol");
        var rotation = symbol.css("rotate");
        if (rotation == "45deg") {
            symbol.css("rotate", "-135deg");
        } else {
            symbol.css("rotate", "45deg");
        }
    };
}

function showPopupHandler(e) {
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

function completeTaskHandler(target) {
    // On checkbox click, update tasks as completed and rerender all partials that 
    // contain tasks
    if (target.matches(".check-box-wrapper:first-child input")) {
        // $(".check-box-wrapper:first-child input").on("click", function () {
        var taskId = $(this).attr("data-task-id");
        console.log("completeTask")

        $.post("/tasks/complete_task", {
            id: taskId,
            success: reRenderAllTasks
        });
    }
}

function reRenderAllTasks() {
    if ($("#show-wrapper").is(":visible")) {
        reRenderShow();
    }
    reRenderList();
    calendar.render();
    // initHandlers();
}

function reRenderShow() {
    console.log("rerender show")
    var id = $(".show-wrapper .title a").attr("data-task-id");
    $.get({
        url: `/tasks/${id}`,
        dataType: "json",
        success: function (data) {
            $("#show-wrapper").html(data.html);
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