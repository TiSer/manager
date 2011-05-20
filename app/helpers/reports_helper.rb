module ReportsHelper
  def get_all_bookings(hash,employee_id,mark_date)
    hash[employee_id][:all][date_sql(mark_date)] ||=0
  end

  def date_cycle
    id = 0
    5.times do |j|
      7.times do |i|
        @mark_date = @current_monday + id.day
        id +=1
        yield
       end
     end
  end

  def to_cell(value)
    if value !=0
      value
    end
  end

  def style_if_weekend(date)
    if weekend?(date)
     color = "weekend"
    else
     color =""
    end
    color
  end

  def get_projects_bookings(hash,employee_id)
    hash[employee_id][:projects]
  end

  def get_project_from(project_bookings)
    project_bookings[0]
  end

  def get_bookings_from(project_bookings,mark_date)
    project_bookings[1][date_sql(mark_date)]
  end
end

