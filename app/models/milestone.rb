class Milestone < ActiveRecord::Base

  belongs_to :project
  has_many   :deals
#  has_many :bookings, :throught => ???

  validates_presence_of :name, :invoice_name


  def by_time_amount
    start_data = self.start_date
    end_data = self.end_date
    @bookings = self.project.bookings.where(:date => start_data..end_data)
    summ = 0
    activity_cost_absent = false
    @bookings.each do |booking|
        activity_cos = ActivityCost.where(:project_id => self.project.id, :activity_id => booking.activity_id).last
        if activity_cos
          temp = 0
          if !activity_cos.amount
            activity_cost_absent = true
          else
            temp = booking.hours * activity_cos.amount
          end
          summ += temp
        else
          activity_cost_absent = true
        end
    end
    if activity_cost_absent
      "N/A"
    else
      summ
    end
  end

  def expence
    @bookings = self.project.bookings.where(:date => self.start_date..self.end_date)
    expence = 0.0
    not_salary = false
    not_working_days = false

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
            not_working_days = true
          end
          elem_cost = booking.hours.to_f / (wd) * salary.amount  #???????????????
        elsif salary_type == 2
          elem_cost = booking.hours * salary.amount
        end
        expence += elem_cost
      else
        not_salary = true
      end
    end
    elem_cost = 0
    self.deals.each do |deal|
      elem_cost += deal.cost
    end
    expence += elem_cost
    not_available = []

    if not_salary
      not_available << "salaries"
    end
    if not_working_days
      not_available << "working days"
    end

    if !not_salary and !not_working_days
      expence
    else
      not_available
    end
  end

  def expence_details_in_hash
    bookings = self.project.bookings.where(:date => self.start_date..self.end_date).order("bookings.date")
    expence = 0.0
    not_salary = false
    not_working_days = false
    exp_det_arr = []
    bookings.each do |booking|
      details = {}
      details.[]=(:booking, booking)
      details.[]=(:employee, booking.employee.name)
      salary = booking.employee.salaries.on_month(booking.date).order("salaries.year_month DESC").first
      if salary
        details.[]=(:salary, salary)
        salary_type = salary.sal_type
        if salary_type == 1
          date = booking.date
          date = Date.civil(date.year, date.month, 1)
          mwd = MonthWorkingDay.on_month(date).first
          if mwd
            wd = mwd.working_days
            details.[]=(:month_working_days, wd)
          else
            wd = 17
            not_working_days = true
          end
          elem_cost = booking.hours.to_f / (wd) * salary.amount  #???????????????
          details.[]=(:cost, elem_cost)
        elsif salary_type == 2
          elem_cost = booking.hours * salary.amount
          details.[]=(:cost, elem_cost)
        end
        expence += elem_cost
        exp_det_arr << details
      else
        not_salary = true
      end
    end
    elem_cost = 0
    deals = []
    self.deals.each do |deal|
      elem_cost += deal.cost
      deals << {:employee => deal.employee.name, :description => deal.description, :cost => deal.cost}
    end
    expence += elem_cost

    not_available = []

    if not_salary
      not_available << "salaries"
    end
    if not_working_days
      not_available << "working days"
    end

    if !not_salary and !not_working_days
      {:array => exp_det_arr, :deals => deals, :sum => expence}
    else
      not_available
    end
  end


end

