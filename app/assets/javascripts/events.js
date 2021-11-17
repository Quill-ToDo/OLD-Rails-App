//= require_tree .
//= require main
//= require locales-all
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require tempusdominus-bootstrap-4.js
//= require jquery_ujs

// $(document).ready(function() {
//   $('#datetimepicker1').datetimepicker({
//     format: 'MMMM D, YYYY h:mm A',
//     sideBySide: true,
//     icons: {
//       time: 'far fa-clock',
//       date: 'far fa-calendar',
//       up: 'fas fa-arrow-up',
//       down: 'fas fa-arrow-down',
//       previous: 'fas fa-chevron-left',
//       next: 'fas fa-chevron-right',
//       today: 'far fa-calendar-check',
//       clear: 'fas fa-trash',
//       close: "fas fa-times"
//     },
//     buttons: {showClose: true}
//   });
//   $('#datetimepicker2').datetimepicker({
//     format: 'MMMM D, YYYY h:mm A',
//     sideBySide: true,
//     icons: {
//       up: 'fas fa-arrow-up',
//       down: 'fas fa-arrow-down',
//       previous: 'fas fa-chevron-left',
//       next: 'fas fa-chevron-right',
//       close: "fas fa-times"
//     },
//     buttons: {showClose: true}
//   });
// });

$('#datetimepicker1').datetimepicker({
  // format: 'MMMM D, YYYY h:mm A',
  minDate: Date(),
  maxDate: new Date(Date.now() + (365 * 24 * 60 * 60 * 1000)),
  sideBySide: true,
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
  // format: 'MMMM D, YYYY h:mm A',
  useCurrent: false,
  sideBySide: true,
  icons: {
    up: 'fas fa-arrow-up',
    down: 'fas fa-arrow-down',
    previous: 'fas fa-chevron-left',
    next: 'fas fa-chevron-right',
    close: 'fas fa-times'
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