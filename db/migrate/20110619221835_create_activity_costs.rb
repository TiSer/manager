class CreateActivityCosts < ActiveRecord::Migration
  def self.up
    create_table :activity_costs do |t|
      t.integer :activity_id
      t.integer :project_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_costs
  end
end
