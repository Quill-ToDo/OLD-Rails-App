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

    // document.getElementById('test-add').addEventListener('click', function() {
    //   calendar.addEvent({title: "Test", start:'2021-11-10', end:'2021-11-11'});
    //   calendar.render();
    // });
  });

