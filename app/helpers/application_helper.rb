module ApplicationHelper
  
  def activity( obj )
    ("<div class=\"activity_box\" id=\"#{obj.is_active}\"></div>").html_safe
  end

end
