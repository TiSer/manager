module ProjectsHelper
   def booking_color_marking(hours_sum,date)
    if hours_sum > 0 and hours_sum < 8
       marking = "yellow_bg"
    elsif hours_sum >= 8
       marking = "red_bg"
    elsif weekend?(date)
       marking = "weekend"
    else
       marking = "green_bg"
    end
    marking
  end

end

