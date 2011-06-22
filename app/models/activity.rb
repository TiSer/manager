class Activity < ActiveRecord::Base

  has_many :bookings
  has_many :activity_costs

  def self.dd
    @activit = Activity.all
    @activities = []
    @activit.each do |activ|
      @activities << [activ.name, activ.id]
    end
    @activities
  end

end
