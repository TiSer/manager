class Booking < ActiveRecord::Base
  
  belongs_to :employee
  belongs_to :project

end
