class RemoveActivityCostFromActivity < ActiveRecord::Migration
  def self.up
    remove_column :activities, :activity_cost
  end

  def self.down
    add_column :activities, :activity_cost, :integer
  end
end

