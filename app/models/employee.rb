class Employee < ActiveRecord::Base
  has_and_belongs_to_many :skills
  belongs_to :department

  validates_presence_of :name, :email
end
