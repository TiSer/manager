class ActivityCost < ActiveRecord::Base

  belongs_to :activity
  belongs_to :project

#  validates_presence_of :amount #wtf?

end
