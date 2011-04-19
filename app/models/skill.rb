class Skill < ActiveRecord::Base
  has_and_belongs_to_many :employee

  validates_presence_of :name
end
