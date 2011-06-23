class Customer < ActiveRecord::Base

  has_many :projects

  validates_presence_of :country, :name

  scope :active, where(:is_active => true)

  def self.dd
    @customers = []
    Customer.active.each do |customer|
      @customers << [customer.name, customer.id]
    end
    @customers
  end

end

