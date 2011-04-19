class CreateEmployeesSkills < ActiveRecord::Migration
  def self.up
    create_table :employees_skills, :id => false do |t|
      t.integer :employee_id
      t.integer :skill_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employees_skills
  end
end
