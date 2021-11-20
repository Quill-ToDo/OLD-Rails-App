//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require main
//= require locales-all
//= require moment 

"use strict";

document.addEventListener('DOMContentLoaded', function () {
  var calendarEl = document.getElementById('calendar');
  // TODO: Don't make this global :)
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
        jQuery.post(
          "/tasks", {
            task: {
              title: title,
              start: info.start,
              due: info.end,
              calendar: true
            }
          }).done(function() {
            calendar.refetchEvents();
            reRenderList();
          })
          .fail(function() {
            alert( "ERROR: Task could not be created!" );
          })
          .always(function() {
            calendar.unselect();
          })
        }
      },
      initialView: 'dayGridMonth',
      expandRows: true,
      height: "100%",
      dayCellClassNames: 'dark-section'
    });
    calendar.render();
});

function reRenderList() {
  $.get("/tasks/update_partials")
}