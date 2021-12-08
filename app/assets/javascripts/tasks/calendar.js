document.addEventListener('DOMContentLoaded', function () {
    // Only run if body has tasks class
    if ($('body.tasks').length) {

        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            selectable: true,
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            eventSources: [{
                url: '/tasks/calendar_tasks',
                method: 'GET',
                failure: function () {
                    alert('there was an error while fetching tasks!');
                }
            }],
            select: function (info) {
                var title = prompt('Enter Title');
                if (title) {
                    $.post(
                            "/tasks", {
                                task: {
                                    title: title,
                                    start: info.start,
                                    due: info.end,
                                    data: JSON,
                                    calendar: true,
                                    dataType: 'json'
                                }
                            }).fail((status) => {
                            console.log(status)
                            alert("ERROR: Task could not be created!");
                        }).done(function () {
                            calendar.refetchEvents();
                            renderList().catch(err => {
                                console.log(err)
                            });
                        })
                        .always(function () {
                            calendar.unselect();
                        });
                }
            },
            editable: true,
            droppable: true,
            eventDrop: function (info) {
                if (info.event.id != undefined) {
                    $.ajax({
                        url: '/tasks/' + info.event.id,
                        type: 'PATCH',
                        data: {
                            task: {
                                title: info.event.title,
                                description: info.event._def.extendedProps.description,
                                start: info.event.start,
                                due: info.event.end,
                                calendar: true,
                                update: true
                            }
                        },
                        success: function () {
                            calendar.refetchEvents();
                            renderList().catch(err => {
                                console.log(err)
                            });
                        },
                        error: function () {
                            alert("ERROR: Task information could not be updated!");
                        }
                    });
                }
            },
            initialView: 'dayGridMonth',
            expandRows: true,
            height: "100%",
            dayCellClassNames: 'dark-section'
        });
        calendar.render();
    }
});