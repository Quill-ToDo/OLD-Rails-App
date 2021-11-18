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
      eventSources: [
        {
          url: '/tasks/calendar_tasks',
          method: 'GET',
          failure: function() {
            alert('there was an error while fetching tasks!');
          }
        }
      ],
      select: function(info) {
        console.log(info);
        var title = prompt('Enter Title');
        if(title){
          jQuery.post(
            "/tasks", 
            {
              task: {
                title: title,
                start: info.start,
                due: info.end,
                calendar: true
              }
            }
          );
          calendar.refetchEvents();
          calendar.unselect();
        }
      },
      initialView: 'dayGridMonth',
      expandRows: true,
      height: "100%",
      dayCellClassNames: 'dark-section'
    });
    calendar.render();
});