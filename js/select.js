$(document).ready(function() {

$('body').on('change', '.select_all_cbs', function() {
	var cb_status = $(this).is(':checked');
	var container = $(this).attr('data-container');
	if(cb_status) {
		$('#'+container).find('input[type=checkbox]').prop('checked', true);
	} else {
		$('#'+container).find('input[type=checkbox]').prop('checked', false);
	}
});


$('body').on('click', '.item-actions-toggle-btn', function() {
	var itemsBlock = $(this).closest('.item-actions-dropdown');
	$('.item-actions-dropdown').not(itemsBlock).removeClass('toggled');
	$(itemsBlock).toggleClass('toggled');
});




});