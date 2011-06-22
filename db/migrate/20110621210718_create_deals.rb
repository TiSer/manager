class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :employee_id
      t.integer :milestone_id
      t.text :description
      t.integer :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
