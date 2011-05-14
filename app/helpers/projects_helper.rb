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
      else this_bookings[@date][1] >= 8
        marking = "red_bg"
      end
    end
    marking
  end

end

