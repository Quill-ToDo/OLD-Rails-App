//
//= require_tree .
//= require main
//= require locales-all
//= require jquery
//= require moment 
//= require jquery_ujs

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth'
    });
    calendar.render();
  });