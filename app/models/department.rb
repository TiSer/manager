class Department < ActiveRecord::Base
  has_many :employees
  has_many :projects
  validates_presence_of :name
end
