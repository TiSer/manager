class Project < ActiveRecord::Base
  
  belongs_to              :department
  belongs_to              :customer
  has_and_belongs_to_many :employees
  has_many                :bookings

end
