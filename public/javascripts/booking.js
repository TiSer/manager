$(document).ready(function(){
	$("#test")
		.bind('click', function (evt) {
			console.log($('tr.employee'));
		});
});

