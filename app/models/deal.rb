class Deal < ActiveRecord::Base
  belongs_to :employee
  belongs_to :milestone
end

