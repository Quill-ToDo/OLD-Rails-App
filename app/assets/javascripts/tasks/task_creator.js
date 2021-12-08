//= require popper
//= require tempus-dominus

document.addEventListener('DOMContentLoaded', function () {
  // Only run if body has tasks class
  if ($('body.tasks').length) {
    var options = {
      display: {
        buttons: {
          close: true
        },
        // toolbarPlacement: "top"
      }
    }
    new tempusDominus.TempusDominus(document.getElementById('datetime-picker-start'), options);
    new tempusDominus.TempusDominus(document.getElementById('datetime-picker-due'), options);
  }
});