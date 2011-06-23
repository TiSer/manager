class Activity < ActiveRecord::Base

  has_many :bookings
  has_many :activity_costs

  validates_presence_of :name, :invoice_name


  def self.dd
    @activit = Activity.all
    @activities = []
    @activit.each do |activ|
      @activities << [activ.name, activ.id]
    end
    @activities
  end

end

