$(document).ready(function () {

    var csrf_token = $('meta[name=csrf]').attr('content');

$('#submitNewRate').click(function() {
    var rateName = $('input[name=rateName]').val();
    var ratePercent = $('input[name=ratePercent').val();
    if(rateName.length < 1) {
        $.alert({
            title: '',
            content: '<span class="alertCentered">' + 'Укажите название тарифа' + '</span>',
            confirmButton: '',
            cancelButton: '',
            closeIcon: true,
            columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
        });
        return false;
    }

    if(ratePercent.length < 1) {
        $.alert({
            title: '',
            content: '<span class="alertCentered">' + 'Введите процентную ставку' + '</span>',
            confirmButton: '',
            cancelButton: '',
            closeIcon: true,
            columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
        });
        return false;
    }

    var formData = { '_token': csrf_token, 'rateName': rateName, 'ratePercent': ratePercent };
    $.ajax({
        method: 'POST',
        url: '/rates/submitNewRate',
        data: formData,
        success: function(data) {
            var response = JSON.parse(data);
            if (response.result == true) {
                var newTr = '<tr><td class="rateName"><span class="toggledHide">' + response.rateName + '</span><input type="text" class="toggleableInput" value="' + response.rateName + '"></td><td class="ratePercent"><span class="toggledHide">' + response.ratePercent + '</span><input class="toggleableInput" type="text" maxlength="2" value="' + response.ratePercent + '"></td><td class="t-a-r"><button type="button" class="editRateSubmit toggleableBtn btn">ок</button><button type="button" class="editRate smBtn btn btn-default"><i class="fa fa-edit"></i></button><button type="button" class="deleteRate smBtn btn btn-danger"><i class="fa fa-close"></i></button></td></tr>';
                $('#ratesListTable').prepend(newTr);
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


    $('body').on('click', '.editRate', function () {
        var currentTr = $(this).closest('tr');
        var rateName = $(currentTr).find('td.rateName span').html().trim();
        var ratePercent = $(currentTr).find('td.ratePercent span').html().trim();
        $('#ratesListTable tr').not(currentTr).removeClass('toggledTr');
        $(currentTr).find('td.rateName input').val(rateName);
        $(currentTr).find('td.ratePercent input').val(ratePercent);
        $(currentTr).toggleClass('toggledTr');
    });


$('body').on('click', '.editRateSubmit', function() {
    var currentTr = $(this).closest('tr');
    var rateName = $(currentTr).find('.rateName span').html();
    var newRateName = $(currentTr).find('.rateName input').val();
    var ratePercent = $(currentTr).find('.ratePercent input').val();

    if (newRateName.length < 1) {
        $.alert({
            title: '',
            content: '<span class="alertCentered">' + 'Укажите название тарифа' + '</span>',
            confirmButton: '',
            cancelButton: '',
            closeIcon: true,
            columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
        });
        return false;
    }

    if (ratePercent.length < 1) {
        $.alert({
            title: '',
            content: '<span class="alertCentered">' + 'Введите процентную ставку' + '</span>',
            confirmButton: '',
            cancelButton: '',
            closeIcon: true,
            columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
        });
        return false;
    }

    var formData = {'_token': csrf_token, 'rateName': rateName, 'newRateName': newRateName, 'ratePercent': ratePercent};
    $.ajax({
        method: 'POST',
        url: '/rates/editRate',
        data: formData,
        success: function(data) {
            var response = JSON.parse(data);
            console.log(response);
            if(response.result) {
                $(currentTr).find('.rateName span').html(response.rateName);
                $(currentTr).find('.ratePercent span').html(response.ratePercent);
                $(currentTr).removeClass('toggledTr');
            } else {
                var alertFail =$.alert({
                    title: '',
                    content: '<span class="alertCentered">' + response.display + '</span>',
                    confirmButton: '',
                    cancelButton: '',
                    closeIcon: true,
                    columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
                });

                setTimeout(function() {
                    alertFail.close();
                }, 1500);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#testDiv').html(JSON.stringify(jqXHR)); // !temp
        }
    });

});


    $('body').on('click', '.deleteRate', function () {
        var currentTr = $(this).closest('tr');
        var rateName = $(currentTr).find('.rateName span').html();



        var formData = {
            '_token': csrf_token,
            'rateName': rateName
        };
        $.ajax({
            method: 'POST',
            url: '/rates/deleteRate',
            data: formData,
            success: function (data) {
                var response = JSON.parse(data);
                console.log(response);
                if (response.result) {
                    $(currentTr).remove();
                }

                    var alertFail = $.alert({
                        title: '',
                        content: '<span class="alertCentered">' + response.display + '</span>',
                        confirmButton: '',
                        cancelButton: '',
                        closeIcon: true,
                        columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
                    });

            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#testDiv').html(JSON.stringify(jqXHR)); // !temp
            }
        });

    });































});