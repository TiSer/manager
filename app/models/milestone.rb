class Milestone < ActiveRecord::Base
  
  belongs_to :project

  def by_time_amount(mile)
    stada = mile.start_date
    enda = mile.end_date
    @bookings = self.project.bookings.where(:date => stada..enda)
    summ = 0
    @bookings.each do |boo|
        temp = boo.hours * boo.activity.activity_cost
        summ += temp
    end
    summ
  end

end
