class Milestone < ActiveRecord::Base

  belongs_to :project
  has_many   :deals

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
          elem_cost = booking.hours.to_f / (MonthWorkingDay.on_month(date).first.working_days) * salary.amount  #???????????????
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

