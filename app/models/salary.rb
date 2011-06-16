class Salary < ActiveRecord::Base
  belongs_to  :employee

  scope :on_month, lambda { |date| { :conditions => ["salaries.year_month <= ?", date] } }

end

