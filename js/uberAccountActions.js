$(document).ready(function() {

 var csrf_token = $('meta[name=csrf]').attr('content');
 var uberModal = $('#uberModal');
 var uberModalPass = $(uberModal).find('input[name=password]');
 var uberModalMail = $(uberModal).find('input[name=email]');
 var uberModalCity = $(uberModal).find('#city_input');

$('#addUberAccount').click(function() {
    $(uberModal).modal('show');
    $(uberModalMail).val('');
    $(uberModalPass).val('');
});

$('#createNewUberAccount').click(function () {
    var email = $(uberModalMail).val();
    var pass = $(uberModalPass).val();
    var city = $(uberModalCity).val();
    $(uberModalPass).removeClass('requiredRed');
    $(uberModalCity).removeClass('requiredRed');
    $(uberModalMail).removeClass('requiredRed');
    if(email == '') {
        $(uberModalMail).addClass('requiredRed');
    }

    if(pass == '') {
        $(uberModalPass).addClass('requiredRed');
    }
    if(city == '' || city.length < 2) {
        $(uberModalCity).addClass('requiredRed');
    }
    if(email == '' || pass == '' || city == '') {
        return false;
    }
    var formData = { 'email': email, 'password': pass, 'city': city, '_token': csrf_token };
    $.ajax({
        method: 'POST',
        url: '/uber/submitNewUberAccount',
        data: formData,
        success: function(data) {
            var response = JSON.parse(data);
            if(response.result == true) {

            var newTr = '<tr><input type="hidden" class="userId" value="' + response.userId + '"><td class="userMail">' + response.email + '</td><td class="userPassword">' + response.password + '</td><td class="createdAt">' + response.created_at + '</td><td class="parsedAt"></td><td class="t-a-r"><button type="button" class="editUberAccount smBtn btn btn-default"><i class="fa fa-edit"></i></button><button type="button" class="deleteUberAccount smBtn btn btn-danger"><i class="fa fa-close"></i></button></td></tr>';
                $('#uberAccountsListTable').prepend(newTr);
            } else {
            $(uberModal).modal('hide');
                var alertFail = $.alert({
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
    $(uberModal).modal('hide');
});




$('.deleteUberAccount').click(function() {
    var tr = $(this).closest('tr');
    var userMail = $(tr).find('.userMail').html();
    if(!userMail) {
        return false;
    }
    $.confirm({
        title: 'Вы уверены?',
        content: 'вы точно уверены, что хотите удалить Uber аккаунт ' + userMail + '?',
        confirm: function () {
        var formData = { '_token': csrf_token, 'email' : userMail};
            $.ajax({
                method: 'POST',
                data: formData,
                url: '/uber/deleteAccount',
                success: function(data) {
                var response = JSON.parse(data);
                if(response.result) {
                    var alertSuccess = $.alert({
                        title: '',
                        content: '<span class="alertCentered">' + response.display + '</span>',
                        confirmButton: '',
                        cancelButton: '',
                        closeIcon: false,
                        columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 autoCloseAlert'
                    });
                        $(tr).fadeOut(1200, function() {
                          $(tr).remove();
                        });
                    setTimeout(function() {
                        alertSuccess.close();
                    }, 1200);
                } else {
                    var alertFail = $.alert({
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
        },
        confirmButton: 'Да',
        cancelButton: 'Нет'
    });

});

    $('.editUberAccount').click(function () {
        var currentTr = $(this).closest('tr');
        var email = $(currentTr).find('td.userMail span').html().trim();
        var password = $(currentTr).find('td.userPassword span').html().trim();
        $('#uberAccountsListTable tr').not(currentTr).removeClass('toggledTr');
        $(currentTr).find('td.userMail input').val(email);
        $(currentTr).find('td.userPassword input').val(password);
        $(currentTr).toggleClass('toggledTr');



    });




$('#city_input').attr('placeholder', 'Введите город...');


});

/*

*/