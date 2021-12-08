document.addEventListener('DOMContentLoaded', function () {
    initHandlers();
});

function initHandlers() {
    $(document).on("click", function (e) {
        if (e.target) {
            let target = e.target;
            collapseSectionHandler(target);
            completeTaskHandler(target);
            showPopupHandler(target, e);
        }
    });
}

function collapseSectionHandler(target) {
    // Collapse sections on click 
    var toggle_section = $(target).parents(".expandable-section-header");
    if (toggle_section.length) {
        var section = $(toggle_section.siblings(".section-collapsible"));
        section.toggle(150, "swing");
        var symbol = toggle_section.children(".expand-symbol");
        var rotation = symbol.css("rotate");
        if (rotation == "45deg") {
            symbol.css("rotate", "-135deg");
        } else {
            symbol.css("rotate", "45deg");
        }
    };
}

function completeTaskHandler(target) {
    // On checkbox click, update tasks as completed and rerender all partials that 
    // contain tasks
    var input_box = $(target).parents(".check-box-wrapper");
    if (input_box.length) {
        input_box = input_box.children("input");
        var taskId = input_box.attr("data-task-id");

        $.post("/tasks/complete_task", {
            id: taskId
        }).then(() => reRenderAllTasks());


    }
}

function showPopupHandler(target, event) {
    // Render popup for this task on click
    var task_title = $(target).parents(".task-wrapper .title");
    if (task_title.length) {
        event.preventDefault();
        var link = $(task_title.children("a"));
        var id = link.attr("data-task-id");
        renderShow(id).catch(err => console.log(err));
    } else if (target.matches(".filter")) {
        // Hide popup
        $("#show-wrapper").toggle();
    }
}


function reRenderAllTasks() {
    if ($("#show-wrapper").is(":visible")) {
        var id = $("#show-wrapper .title a").attr("data-task-id");
        renderShow(id).then(function () {
            // Works when there's a breakpoint here???
            renderList().catch(err => console.log(err));
        });
    } else {
        renderList().catch(err => console.log(err));
    }
    // Calendar is breaking this for some reason. 
    // calendar.render();
}

function renderShow(id) {
    return new Promise(function (resolve, reject) {
        if ($("#show-wrapper").is(":visible")) {
            $.get({
                data: {
                    'inner': true
                },
                url: `/tasks/${id}`,
                dataType: "json"
            }).done((data) => {
                $("#show-wrapper .mid-section").html(data.html);
                $("#show-wrapper").css("display", "flex")
                resolve("Rendered");
            }).fail(() => {
                reject("Show could not render.");
            });
        } else {
            $.get({
                data: {
                    'full': true
                },
                url: `/tasks/${id}`,
                dataType: "json"
            }).done((data) => {
                $("#show-wrapper").html(data.html);
                $("#show-wrapper").css("display", "flex")
                resolve("Rendered");
            }).fail(() => {
                reject("Show could not render.");
            });
        };
    });
}

function renderList() {
    return new Promise(function (resolve, reject) {
        $.get({
            data: {
                'inner': true
            },
            url: '/tasks/list',
            dataType: "json"
        }).done(data => {
            $("#list-wrapper").html(data.html);
            resolve();
        }).fail(err => {
            reject("Could not render list - " + err);
        });
    });
}