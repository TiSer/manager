class CreateEmployeesProjects < ActiveRecord::Migration
  def self.up
    create_table :employees_projects, :id => false do |t|
      t.integer :employee_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employees_projects
  end
end

