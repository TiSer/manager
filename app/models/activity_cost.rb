class ActivityCost < ActiveRecord::Base

  belongs_to :activity

  validates_presence_of :amount #wtf?

end
