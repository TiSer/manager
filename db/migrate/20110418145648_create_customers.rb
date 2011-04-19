class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :country
      t.string :name
      t.text :details
      t.boolean :is_active

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
