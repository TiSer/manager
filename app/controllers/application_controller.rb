class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def authenticate_admin
    unless current_user.admin?
      flash[:error] = "Need administrator rights"
      redirect_to root_path
    end
  end

  def weekend?(date)
    date.strftime('%a') == "Sun" or date.strftime('%a') == "Sat"
  end


  def calendar_prev_next
    @current_date = Time.now
    if params[:month] and params[:year] and params[:day]
      @current_monday = Time.parse(params[:year]+'/'+params[:month]+'/'+params[:day])
    else
      @current_monday = @current_date.monday
    end

    if params[:offset]
      case params[:offset]
        when "prev_week"
          @current_monday -= 1.week
        when "prev_month"
          @current_monday -= 4.week
        when "next_month"
          @current_monday += 4.week
        when "next_week"
          @current_monday += 1.week
      end
    end
  end


  def make_bokings_hash_for(employees)
    booking_employees = {}
    employees.each do |employee|
       proj_bks = employee.bookings_from_monday_to_35th_day(@current_monday,@project.id)
       all_bks = employee.bookings_from_monday_to_35th_day(@current_monday)
       booking_employees.[]=(employee.id, {:project => proj_bks, :all => all_bks})
    end
    booking_employees
  end

  def date_sql(mark_date)
    date_sql = Date.civil(mark_date.year,mark_date.month,mark_date.day)
  end

end

