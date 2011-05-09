class Department < ActiveRecord::Base
  has_many :employees
  has_many :projects
  validates_presence_of :name

  scope :active, where(:is_active => true)

  def self.dd
    @departments = []
    Department.active.each do |dep|
      @departments << [dep.name, dep.id]
    end
    @departments
  end

end

