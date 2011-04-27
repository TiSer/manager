class Employee < ActiveRecord::Base

  has_and_belongs_to_many :skills
  belongs_to              :department
  has_and_belongs_to_many :projects
  has_many                :bookings, :dependent => :destroy

  validates_presence_of :name, :email
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :active, where(:is_active => true)
  
  # scope :skilled, lambda { |skill_id| {
  #  where("") 
  # }}

  def skilled(skill)
    
  end

end

