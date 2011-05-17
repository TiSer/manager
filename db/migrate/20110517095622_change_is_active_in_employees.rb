class ChangeIsActiveInEmployees < ActiveRecord::Migration
  def self.up
    change_column :employees, :is_active, :boolean, :default => true
  end

  def self.down
    change_column :employees, :is_active, :boolean, :default => false
  end
end
