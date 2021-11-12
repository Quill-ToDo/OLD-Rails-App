//
//= require_tree .
//= require main
//= require locales-all
//= require jquery
//= require moment 
//= require jquery_ujs

var calendar;

document.addEventListener('DOMContentLoaded', function() {

    var calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
      selectable: true,
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      select: function(info) {
        console.log(info);
        var title = prompt('Enter Title');
        if(title){
          // AJAX call to DB
          jQuery.get(
            "tasks/create", 
            {
              task: {
                title: title,
                start: info.start,
                due: info.end
              }
            }
          );
          //render
          calendar.render();
          // calendar.addEvent({
          //   title: title,
          //   start: info.start,
          //   allDay: true
          // });
        }
        console.log(title);
        var newEvent = new Object();
        newEvent.title = title;
        newEvent.start = moment(info.start).format();
        console.log(newEvent)
        console.log(this)
        // alert('selected ' + info.startStr + ' to ' + info.endStr);
      },
      initialView: 'dayGridMonth',
      events: "/tasks/get_tasks"
      // events: [
      //   { // this object will be "parsed" into an Event Object
      //     title: 'First Event Ever!!', // a property!
      //     start: '2021-11-05', // a property!
      //     end: '2021-11-07' // a property! ** see important note below about 'end' **
      //   }
      // ]
    });
    calendar.render();
  });

