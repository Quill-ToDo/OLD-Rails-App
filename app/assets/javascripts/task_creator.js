//= require_tree .
//= require main
//= require locales-all
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require tempusdominus-bootstrap-4.js
//= require jquery_ujs

$('#datetimepicker1').datetimepicker({
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
  buttons: {showClose: true }
});

$('#datetimepicker2').datetimepicker({
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
  buttons: {showClose: true }
});

$("#datetimepicker1").on("change.datetimepicker", function (e) {
  $('#datetimepicker2').datetimepicker('minDate', e.date);
  console.log(e.date);
});

$("#datetimepicker2").on("change.datetimepicker", function (e) {
  $('#datetimepicker1').datetimepicker('maxDate', e.date);
});