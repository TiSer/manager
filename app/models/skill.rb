class Skill < ActiveRecord::Base
  has_and_belongs_to_many :employees

  validates_presence_of :name

  def self.dd
    @skills = []
    Skill.all.each do |skill|
      @skills << [skill.name, skill.id]
    end
    @skills
  end
end

