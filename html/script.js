window.addEventListener('message', function(event) {
    if (event.data.action === "showScreenshot") {
        $("#screenshot").attr("src", event.data.image);
        $("body").fadeIn();
    }
});

function closeUI() {
    $("body").fadeOut();
}

$("#saveBtn").click(() => {
    closeUI();
    $.post("https://sb-takescreenshot/screenshotResponse", JSON.stringify({ choice: "save" }));
});

$("#retakeBtn").click(() => {
    //closeUI();
    $.post("https://sb-takescreenshot/screenshotResponse", JSON.stringify({ choice: "retake" }));
});

$("#cancelBtn").click(() => {
    closeUI();
    $.post("https://sb-takescreenshot/screenshotResponse", JSON.stringify({ choice: "cancel" }));
});
