$(document).ready(function(){

    $.datepicker.setDefaults({firstDay: 1, changeYear: true, dateFormat: 'dd.mm.yy', minDate: "0"});
    $("#booking_end_date").datepicker({
        onClose: function() { $("#RB_window #booking_end_date").val($("#booking_end_date").val()); }
        // onClose: function() { RedBox.close(); RedBox.showInline('redbox'); }
    });

    $('td.bookable')
		.bind('click', function (evt) {
            employee_id = parseInt(this.parentNode.id.split('e')[1], 10)

            th_date = $('tr#date th#' + this.id)

            day = $('div#day', th_date).text()
            month = $('div#month', th_date).text()
            year = $('div#year', th_date).text()


            $("#booking_employee_id").val(employee_id)
            employee_name = $('a.employee_link' ,this.parentNode).text();
            $("div#employee_name").text('Employee: ' + employee_name)
            $("div#current_date").text('Begin Date: ' + day+'.'+month+'.'+year)

            $("#booking_date_3i").val(day)
            $("#booking_date_2i").val(month)
            $("#booking_date_1i").val(year)

            RedBox.showInline('redbox');
            return false;
		});
});

