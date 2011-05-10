$(document).ready(function(){
	$("#test")
		.bind('click', function (evt) {
			console.log($('td.bookable'));
            RedBox.showInline('redbox'); return false;
		});
    $('td.bookable')
		.bind('click', function (evt) {
            employee_id = this.parentNode.id
    	 /*	console.log('emploee_id = ' + this.parentNode.id + ' day_id = ' + this.id); */
            th_date = $('tr#date th#' + eval(this.id))
            day = $('div#day', th_date).text()
            month = $('div#month', th_date).text()
            year = $('div#year', th_date).text()
          /*  console.log('date = ' + day+'/'+month+'/'+year); */
            $("#booking_employee_id").val(employee_id)

            $("#booking_date_3i").val(day)
            $("#booking_date_2i").val(month)
            $("#booking_date_1i").val(year)

            RedBox.showInline('redbox'); return false;
		});
});

