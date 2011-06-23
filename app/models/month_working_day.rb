class MonthWorkingDay < ActiveRecord::Base

  scope :on_month, lambda { |date| { :conditions => ["month_working_days.year_month = ?", date] } }

  validates_numericality_of :working_days, :greater_than => 0

  def self.find_by_object(mwday)
    date_sql = Date.civil(mwday.year_month.year,mwday.year_month.month,mwday.year_month.day)
    finded_mwday = self.where(:year_month => date_sql).first
  end

end

