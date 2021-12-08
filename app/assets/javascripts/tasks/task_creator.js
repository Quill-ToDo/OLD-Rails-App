//= require popper
//= require tempus-dominus

document.addEventListener('DOMContentLoaded', function () {
  // Only run if body has tasks class
  if ($('body.tasks').length) {
    new tempusDominus.TempusDominus(document.getElementById('datetime-picker-start'));
    new tempusDominus.TempusDominus(document.getElementById('datetime-picker-due'));
  }

  $(document).on("click", function (e) {
    if (e.target) {
      let target = e.target;
      calendarButtonHandler(target, e);
    }
  });
});

function calendarButtonHandler(target, e) {
  var input_box = $(target).parents(".input-group-text");
  if (input_box.length) {
    e.preventDefault();
  }
}