$(document).on('turbolinks:load', function() {
    var siteKey = "";
    var env = window.location.hostname;
    switch (env){
        case "localhost":
            siteKey = "6LccRqMUAAAAANmQPqM9gC56734SwZl-y-52oXMh";
            break;
        case "test.en4pr.com":
            siteKey = "6LcmRqMUAAAAAEwEiRez8LTbeVIOYttNHrYnuaqU";
            break;
        case "en4pr.com":
            siteKey = "6LcvRqMUAAAAALwT1NkwbJH-IatKnkYtpYZxuyR0";
            break;
        default:
            siteKey = "";
            break;
    }

    $(".g-recaptcha").attr("data-sitekey", siteKey);
});