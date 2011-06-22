class AddActivityCostToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :activity_cost, :integer
  end

  def self.down
    remove_column :activities, :activity_cost, :integer
  end
end
