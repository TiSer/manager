module ApplicationHelper

  def activity( obj )
    ("<div class=\"activity_box\" id=\"#{obj.is_active}\"></div>").html_safe
  end

  def activity_in_text( obj )
    if obj.is_active
      "Yes"
    else
      "No"
    end
  end

  def weekend?(date)
    date.strftime('%a') == "Sun" or date.strftime('%a') == "Sat"
  end

  def back_to_previous_page
   request.env['HTTP_REFERER']
  end

  def date_sql(mark_date)
    date_sql = Date.civil(mark_date.year,mark_date.month,mark_date.day)
  end


  def get_bookings_for_cell(hash,mark_date,employee_id = "none")
    date_sql = Date.civil(mark_date.year,mark_date.month,mark_date.day)
    if employee_id == "none"
      project_bks = hash[:project][date_sql]
      all_bks =  hash[:all][date_sql]
      activity = hash[:activity][date_sql]
    else
      project_bks = hash[employee_id][:project][date_sql]
      all_bks =  hash[employee_id][:all][date_sql]
      activity = hash[employee_id][:activity][date_sql]
    end
      @project_books = project_bks ||=0
      @all_books = all_bks ||=0
      @activity_id = activity ||=0
  end

  def bookings_out_to_cell(project_bks, all_bks)
    if all_bks !=0
      out_to_cell = "#{project_bks}/#{all_bks}"
    else
      out_to_cell = ""
    end
  end

  def calendar_period_link(direction, route_name, main_object, current_monday, options={})
    path_options = {:offset => direction, :day => current_monday.day,  :month => current_monday.month, :year => current_monday.year}
    path_options.merge! options
    case direction
    when "prev_month"
      link_caption = "<<"
    when "prev_week"
      link_caption = "<"
    when "next_week"
      link_caption = ">"
    when "next_month"
      link_caption = ">>"
    else
    end
    path = eval("#{route_name}_path(main_object, path_options)")
    link_to link_caption, path
  end

end

