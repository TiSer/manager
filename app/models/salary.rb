class Salary < ActiveRecord::Base
  belongs_to  :employee

  scope :on_month, lambda { |date| { :conditions => ["salaries.year_month <= ?", date] } }

  SALARY_TYPE =
  [
   ["Monthly", 1 ],
   ["Hourly", 2 ],
   ["Deal", 3 ]
  ]

  validates_numericality_of :day_work_hours, :amount, :tax_amount, :tax_percent
  validates :sal_type, :inclusion => SALARY_TYPE.map {|disp, value| value}
  validates_numericality_of :day_work_hours, :amount, :greater_than => 0

  def self.find_by_object(salary)
    date_sql = Date.civil(salary.year_month.year,salary.year_month.month,salary.year_month.day)
    finded_salary = self.where(:employee_id => salary.employee.id, :year_month => date_sql).first
  end

  def bookings_on_interval(beg_d, end_d)
    begin_date = beg_d.strftime('%Y-%m-%d')
    end_date = end_d.strftime('%Y-%m-%d')
    bookings = self.employee.bookings.where(:date => begin_date..end_date)
    amount = 0
    hours = 0
    bookings.each do |booking|
      amount += booking.activity.activity_cost
      hours += booking.hours
    end
    @amount = amount
    @hours = hours
  end

end

