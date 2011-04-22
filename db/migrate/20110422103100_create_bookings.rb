class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.integer :project_id
      t.integer :employee_id
      t.integer :activity_id
      t.datetime :date
      t.integer :hours

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
