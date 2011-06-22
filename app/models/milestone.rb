class Milestone < ActiveRecord::Base
  
  belongs_to :project
#  has_many :bookings, :throught => ???

  def by_time_amount
    start_data = self.start_date
    end_data = self.end_date
    @bookings = self.project.bookings.where(:date => start_data..end_data)
    summ = 0
    @bookings.each do |booking|
        activity_cos = ActivityCost.where(:project_id => self.project.id, :activity_id => booking.activity_id).last.amount
        temp = booking.hours * activity_cos
        summ += temp
    end
    summ
  end

end
