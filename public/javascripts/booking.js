$(document).ready(function(){
	$("#test")
		.bind('click', function (evt) {
			console.log($('tr.employee'));
            RedBox.showInline('redbox'); return false;
		});
});

