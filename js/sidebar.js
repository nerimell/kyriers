
$(document).ready(function() {

$('#sidebar-menu > li > a').click(function(e) {
	var li = $(this).closest('li');
	var smenu = $(li).find('ul').length;
	if(smenu == 0) {
		return true;
	}
	e.preventDefault();
	var hc = $(li).hasClass('open');
	if(hc == false) {
		$(li).addClass('open');
		$(li).find('ul').slideDown(300);
		$('#sidebar-menu li').not(li).removeClass('open');
		$('#sidebar-menu li').not(li).find('ul').slideUp(300);	
	} else {
		$('#sidebar-menu li').removeClass('open');
		$('#sidebar-menu li').find('ul').slideUp(300);
	}
});


});