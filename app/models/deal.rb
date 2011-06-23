class Deal < ActiveRecord::Base
  belongs_to :employee
  belongs_to :milestone
  validates_presence_of :description, :cost
  validates_numericality_of :cost, :greater_than => 0

end

