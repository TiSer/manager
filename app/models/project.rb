class Project < ActiveRecord::Base

  belongs_to              :department
  belongs_to              :customer
  has_and_belongs_to_many :employees
  has_many                :bookings, :dependent => :destroy
  has_many                :activity_costs
  has_many                :milestones

  scope :active, where("is_active = true")

    PAYMENT_MODEL =
  [
  ["By time", "1"],
  ["Fixed Cost", "2" ]
  ]

  validates :payment_model, :inclusion => PAYMENT_MODEL.map {|disp, value| value}
  validates_presence_of   :name, :department_id, :payment_model, :customer_id

  def participants_dd
    participants = []
    self.employees.each do |participant|
      participants << [participant.name, participant.id]
    end
    participants
  end

end

