class ChangeIsActiveInEmployees < ActiveRecord::Migration
  def self.up
    change_column :employees, :is_active, :boolean, :default => true
    change_column :departments, :is_active, :boolean, :default => true
    change_column :customers, :is_active, :boolean, :default => true
    change_column :projects, :is_active, :boolean, :default => true
  end

  def self.down
    change_column :employees, :is_active, :boolean, :default => false
    change_column :departments, :is_active, :boolean, :default => false
    change_column :customers, :is_active, :boolean, :default => false
    change_column :projects, :is_active, :boolean, :default => false
  end
end
