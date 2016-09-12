$(document).ready(function () {

    // Timer
    timerInit();

});

function timerInit() {
    var serverTime = $('.ServerTime');
    var currentSecond = $(serverTime).find('.seconds').html();
    currentSecond = parseInt(currentSecond);
    var timeToRenew = 60 - currentSecond;
    timeToRenew = timeToRenew * 1000;
    setTimeout(function () {
        incrementMinute();
        setInterval(function () {
            incrementMinute();
        }, 60000);
    }, timeToRenew);

}


function incrementMinute() {
    var serverTime = $('.ServerTime');
    var currentMinute = $(serverTime).find('.minute').html();
    currentMinute = parseInt(currentMinute);
    var insertMinute = currentMinute + 1;
    if (currentMinute < 10) {
        insertMinute = '0' + insertMinute;
    }

    if (currentMinute < 59) {
        $(serverTime).find('.minute').html(insertMinute);
    } else {
        incrementHour();
    }
}

function incrementHour() {
    var serverTime = $('.ServerTime');
    $(serverTime).find('.minute').html('00');
    var currentHour = parseInt($(serverTime).find('.hour').html());
    if (currentHour < 24) {
        $(serverTime).find('.hour').html(currentHour + 1);
    } else {
        $(serverTime).find('.hour').html('00');
    }
}


