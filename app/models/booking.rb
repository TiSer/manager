class Booking < ActiveRecord::Base

  belongs_to :employee
  belongs_to :project

  named_scope :date_greather_than, lambda { |date| { :conditions => ["date > ?", date] } }

  def self.find_by_object(booking)
    finded_booking = self.where(:employee_id => booking.employee.id, :project_id => booking.project.id, :date => booking.date).first
  end

  def self.destroy_bookings_by_object(booking, end_date)
    self.destroy_all(:date => booking.date..end_date, :employee_id => booking.employee.id, :project_id => booking.project.id)
  end

  def update_or_this(&block)
    if finded_booking = Booking.find_by_object(self)
      finded_booking.hours = self.hours
      finded_booking.save
    else
      block.call
    end
  end

end

