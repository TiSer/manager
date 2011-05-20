class ReportsController < ApplicationController

  def employees_bookings
    @employees = Employee.all
    calendar_prev_next

    booking_employees = {}
    @employees.each do |employee|
       proj_bks = []
       employee.projects.each do |project|
         proj_bks << [project, employee.bookings_from_monday_to_35th_day(@current_monday,project.id) ]
       end
       all_bks = employee.bookings_from_monday_to_35th_day(@current_monday)
       booking_employees.[]=(employee.id, {:projects => proj_bks, :all => all_bks})
    end
    @bookings = booking_employees
  end

end

