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
  calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    events: "/tasks/get_tasks",
    expandRows: true,
    height: "100%",
    // events: [
    //   { // this object will be "parsed" into an Event Object
    //     title: 'First Event Ever!!', // a property!
    //     start: '2021-11-05', // a property!
    //     end: '2021-11-07' // a property! ** see important note below about 'end' **
    //   }
    // ]
    dayCellClassNames: 'dark-section'
  });
  calendar.render();
});