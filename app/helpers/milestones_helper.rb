module MilestonesHelper

  def bill
    start_data = @milestone.start_date
    end_data = @milestone.end_date
    bookings = @milestone.project.bookings.where(:date => start_data..end_data)
    bill_array = []
    @summ = 0

    bookings.each do |booking|
      activity_cos = ActivityCost.where(:project_id => @milestone.project.id, :activity_id => booking.activity_id).last.amount
      employee = booking.employee.name
      date = booking.date
      activity = booking.activity.name
      bill_array << [employee, date, activity, booking.hours, activity_cos]
      temp = booking.hours * activity_cos
      @summ += temp
    end

    return bill_array
  end

#  def bill_variables
#      bill.each do |b|
#       @a = b[0]
#       @b = b[1]
#      end
#    @a
#    @b
#  end

end

