class ReportsController < ApplicationController

  before_filter :authenticate_admin

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

  def free_hours
    @employees = Employee.all
    calendar_prev_next

    booking_employees = {}
    @employees.each do |employee|
       all_bks = employee.bookings_from_monday_to_35th_day(@current_monday)
       all_bks.each do |booking_hours|
         salary = employee.salaries.on_month(date_sql(booking_hours[0])).order("salaries.year_month DESC").first
         if salary
           free_hours = salary.day_work_hours - booking_hours[1]
         else
           free_hours = 'N/A'
         end
         all_bks[booking_hours[0]] = free_hours
       end
       all_bks
       booking_employees.[]=(employee.id, {:all => all_bks})
    end
    @booking_employees = booking_employees
  end

end

