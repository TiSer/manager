module ProjectsHelper
  def color_marking(this_bookings,date)
    if date.saturday? or date.sunday?
      marking = "weekend"
    else
      marking = "green_bg"
    end
    if this_bookings and this_bookings[@date]
      if this_bookings[@date][1] > 0 and this_bookings[@date][1] < 8
        marking = "yellow_bg"
      elsif this_bookings[@date][1] >= 8
        marking = "red_bg"
      end
    end
    marking
  end

  def color_marking_ajax(hours_sum)
    if hours_sum > 0 and hours_sum < 8
       marking = "yellow_bg"
    elsif hours_sum >= 8
       marking = "red_bg"
    else
       marking = "green_bg"
    end
    marking
  end

end

