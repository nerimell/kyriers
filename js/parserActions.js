$(document).ready(function() {

    var csrf_token = $('meta[name=csrf]').attr('content');

    $('body').on('click', '.scanUberAccount', function() {
        var button = $(this);
        if($(button).hasClass('scanning')) {
            return false;
        }
        var tr = $(this).closest('tr');
        var email = $(tr).find('.userMail').html();
        var formData = { 'email': email, '_token': csrf_token };
        $.ajax({
            method: 'POST',
            data: formData,
            url: '/scanAccount',
            beforeSend: function() {
                $(button).addClass('scanning');
                $('.ajaxPreloadWrapper').fadeIn();
            },
            success: function(dataBack) {
                $('.ajaxPreloadWrapper').fadeOut();
                var response = JSON.parse(dataBack);
                $(button).removeClass('scanning');
                if(response.result) {
                    $(tr).find('.ParsedAt').html(response.parsedTime);
                } else {
                    alertFail = $.alert({
                        title: '',
                        content: '<span class="alertCentered">' + response.display + '</span>',
                        confirmButton: '',
                        cancelButton: '',
                        closeIcon: true,
                        columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
                    });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#testDiv').html(JSON.stringify(jqXHR)); // !temp
            }
        });




    });



    completeCurrentScanning();









});


function completeCurrentScanning() {
    var currentScanning = $('.scanning');
    if (!currentScanning.length) {
        return false;
    }

    var scanningMails = [];
    $('.scanning').each(function() {
        var mail = $(this).closest('tr').find('.userMail').html();
        scanningMails.push(mail);
    });
    if(!scanningMails.length) {
        return false;
    }
    var csrf_token = $('meta[name=csrf]').attr('content');
    var formData = { '_token': csrf_token, 'mails': scanningMails };

    var completeTheScan = setInterval(function() {
        $.ajax({
            method: 'POST',
            data: formData,
            url: '/parser/checkCurrentScanning',
            success: function (data) {
                var response = JSON.parse(data);
                $('#uberAccountsListActions tr').each(function() {
                    var tr = $(this);
                    var mail = $(tr).find('td.userMail').html().trim();
                    var newTime = response.lastScanTimes[mail];
                    $(tr).find('.ParsedAt').html(newTime);
                });
                if(response.result) {
                    $('.scanning').each(function() {
                        var button = $(this);
                        var email = $(button).closest('tr').find('.userMail').html();
                        if(response.emails.indexOf(email) == -1) {
                            $(button).removeClass('scanning');
                        } else {
                            return;
                        }
                    });
                } else {
                    clearInterval(completeTheScan);
                    $('.scanning').removeClass('scanning');
                    return;
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#testDiv').html(JSON.stringify(jqXHR)); // !temp
            }

        });
    }, 12000);


}



