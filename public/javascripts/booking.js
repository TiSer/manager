$(document).ready(function(){
    $("#booking_end_date").datepicker();

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
            employee_name = $('a.employee_link' ,this.parentNode).text();
            $("div#employee_name").text('Employee: ' + employee_name)
            $("div#current_date").text('Begin Date: ' + day+'.'+month+'.'+year)

            $("#booking_date_3i").val(day)
            $("#booking_date_2i").val(month)
            $("#booking_date_1i").val(year)
            console.log($('#booking_end_date'));
            RedBox.showInline('redbox');
            return false;
		});
});

