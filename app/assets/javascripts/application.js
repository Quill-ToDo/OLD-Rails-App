//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require main
//= require locales-all
//= require moment 

"use strict";

var calendar;

document.addEventListener('DOMContentLoaded', function () {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
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
      var task = {
        title: title,
        start: info.start,
        due: info.end,
        calendar: true
      };
      if (title) {
        jQuery.post(
          "/tasks", {
            task: task
          }
        );
        calendar.addEvent(task)
        calendar.unselect();
      }
    },
    initialView: 'dayGridMonth',
    expandRows: true,
    height: "100%",
    dayCellClassNames: 'dark-section',
    eventAdd: reRenderList,
    eventRemove: reRenderList,
    eventChange: reRenderList
  });
  calendar.render();
});

function reRenderList() {
  $.get("/tasks/update_partials");
}