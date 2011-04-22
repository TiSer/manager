class AddDefaultActivityIdToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :default_activity_id, :integer
  end

  def self.down
    remove_column :employees, :default_activity_id
  end
end
