module ApplicationHelper

  def activity( obj )
    ("<div class=\"activity_box\" id=\"#{obj.is_active}\"></div>").html_safe
  end

  def weekend?(date)
    date.strftime('%a') == "Sun" or date.strftime('%a') == "Sat"
  end

end

