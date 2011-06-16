class Project < ActiveRecord::Base

  belongs_to              :department
  belongs_to              :customer
  has_and_belongs_to_many :employees
  has_many                :bookings, :dependent => :destroy
  has_many                :activity_costs
  has_many                :milestones

  scope :active, where("is_active = true")


end

