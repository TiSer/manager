class Salary < ActiveRecord::Base
  belongs_to  :employee

  scope :on_month, lambda { |date| { :conditions => ["salaries.year_month <= ?", date] } }

  SALARY_TYPE =
  [
   ["Monthly", 1 ],
   ["Hourly", 2 ],
   ["Deal", 3 ]
  ]

  def self.find_by_object(salary)
    date_sql = Date.civil(salary.year_month.year,salary.year_month.month,salary.year_month.day)
    finded_salary = self.where(:employee_id => salary.employee.id, :year_month => date_sql).first
  end

end

