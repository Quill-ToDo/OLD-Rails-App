document.addEventListener('DOMContentLoaded', function () {
    handleAlerts();
});

// Alerts 

function handleAlerts() {
    // delete alert on exit click
    $(".alert-pop-up img").on("click", function () {
        $(this).parent().remove()
    })
}