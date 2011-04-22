class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      
      t.string :name
      t.integer :department_id
      t.string :payment_model
      t.boolean :is_active
      t.integer :customer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
