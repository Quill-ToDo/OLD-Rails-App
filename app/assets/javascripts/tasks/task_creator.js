//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require tempusdominus-bootstrap-4.js
//= require jquery_ujs

$('#datetime-picker-start').datetimepicker({
  format: moment().format(),
  icons: {
    time: 'far fa-clock',
    date: 'far fa-calendar',
    up: 'fas fa-arrow-up',
    down: 'fas fa-arrow-down',
    previous: 'fas fa-chevron-left',
    next: 'fas fa-chevron-right',
    today: 'far fa-calendar-check',
    clear: 'fas fa-trash',
    close: "fas fa-times"
  },
  buttons: {
    showClose: true
  }
});

$('#datetime-picker-due').datetimepicker({
  // format: 'YYYY-MM-DDTHH:mm:ssZ',
  format: moment().format(),
  icons: {
    time: 'far fa-clock',
    date: 'far fa-calendar',
    up: 'fas fa-arrow-up',
    down: 'fas fa-arrow-down',
    previous: 'fas fa-chevron-left',
    next: 'fas fa-chevron-right',
    today: 'far fa-calendar-check',
    clear: 'fas fa-trash',
    close: "fas fa-times"
  },
  buttons: {
    showClose: true
  }
});

$("#datetime-picker-start").on("change.datetimepicker", function (e) {
  $('#datetime-picker-due').datetimepicker('minDate', e.date);
  console.log(e.date);
});

$("#datetime-picker-due").on("change.datetimepicker", function (e) {
  $('#datetime-picker-start').datetimepicker('maxDate', e.date);
});