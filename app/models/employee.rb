class Employee < ActiveRecord::Base

  has_and_belongs_to_many :skills
  belongs_to              :department
  has_and_belongs_to_many :projects
  has_many                :bookings, :dependent => :destroy
  has_many                :salaries, :dependent => :destroy

  validates_presence_of :name, :email
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :active, where("is_active = true")

  # scope :skilled, lambda { |skill_id| {
  #  where("")
  # }}

  def self.skilled(skill)
    Skill.find(skill).employees
  end

  def bookings_on_interval(beg_d, end_d, project_id = "all")
    begin_date = beg_d.strftime('%Y-%m-%d')
    end_date = end_d.strftime('%Y-%m-%d')
    if project_id == "all"
      bookings.where(:date => begin_date..end_date).group(:date).order(:date).sum(:hours)
    else
      bookings.where(:date => begin_date..end_date,:project_id => project_id).group(:date).order(:date).sum(:hours)
    end
  end


  def bookings_from_monday_to_35th_day(current_monday,project_id = "all")
    begin_date = current_monday
    end_date = current_monday.midnight + 35.day
    self.bookings_on_interval(begin_date, end_date, project_id)
  end


end

