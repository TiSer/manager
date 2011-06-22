class Milestone < ActiveRecord::Base
  
  belongs_to :project
  has_many   :deals
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

  def expence
    @bookings = Booking.where(:date => self.start_date..self.end_date)
    expence = 0.0
    not_available = false
    @bookings.each do |booking|
      salary = booking.employee.salaries.on_month(booking.date).order("salaries.year_month DESC").first
      if salary
        salary_type = salary.sal_type
        if salary_type == 1
          date = booking.date
          date = Date.civil(date.year, date.month, 1)
          mwd = MonthWorkingDay.on_month(date).first
          if mwd 
            wd = mwd.working_days
          else
            wd = 17
            not_available = true    
          end
          elem_cost = booking.hours.to_f / (wd) * salary.amount  #???????????????
        elsif salary_type == 2
          elem_cost = booking.hours * salary.amount
        end
        expence += elem_cost
      else
        not_available = true
      end
    end
    elem_cost = 0
    self.deals.each do |deal|
      elem_cost += deal.cost
    end
    expence += elem_cost
    if !not_available
      "%0.2f" %expence
    else
      "N/A"
    end
  end

end
