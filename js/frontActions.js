$(document).ready(function() {

	$('body').on('click', '#loginIntoSystem', function() {
		$('.authActionsTogglers').hide();
		$('.loginAction').show();
		$('#loginForm').modal('show');
	});


	$('body').on('click', '#registerIntoSystem', function() {
		$('.authActionsTogglers').hide();
		$('.registerAction').show();
		$('#loginForm').modal('show');
	});










});