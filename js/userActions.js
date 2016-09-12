$(document).ready(function() {

 var csrf_token = $('meta[name=csrf]').attr('content');

$('.deleteUser').click(function() {
    var tr = $(this).closest('tr');
    var userId = $(tr).find('.userId').val();
    var login = $(tr).find('.userLogin').html();
    if(!userId || !login) {
        return false;
    }
    login = login.trim();
    $.confirm({
        title: 'Вы уверены?',
        content: 'вы точно уверены, что хотите удалить пользователя ' + login + '?',
        confirm: function () {
        var formData = { '_token': csrf_token, 'login' : login, 'userId': userId };
            $.ajax({
                method: 'POST',
                data: formData,
                url: '/users/deleteUser',
                success: function(data) {
                    var response = JSON.parse(data);
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




});

/*

*/