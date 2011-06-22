module ProjectsHelper
   def booking_color_marking(hours_sum,date)
    if hours_sum != 'N/A'
      if hours_sum > 0 and hours_sum < 8
         marking = "yellow_bg"
      elsif hours_sum >= 8
         marking = "red_bg"
      elsif weekend?(date)
         marking = "weekend"
      elsif hours_sum == 0
         marking = "green_bg"
      elsif hours_sum < 0
        marking = "red_bg"
      else
        marking = "not_available"
      end
    else
      marking = "not_available"
    end
    marking
  end

end

