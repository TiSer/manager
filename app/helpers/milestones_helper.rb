module MilestonesHelper

  def bill
    start_data = @milestone.start_date
    end_data = @milestone.end_date
    bookings = @milestone.project.bookings.where(:date => start_data..end_data)
    bill_array = []
    @summ = 0

    bookings.each do |booking|
      activity_cos = ActivityCost.where(:project_id => @milestone.project.id, :activity_id => booking.activity_id).last.amount
      bill_array << [booking.hours,activity_cos]
      temp = booking.hours * activity_cos
      @summ += temp
    end

    return bill_array
  end

end
