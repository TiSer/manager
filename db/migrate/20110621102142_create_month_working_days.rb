class CreateMonthWorkingDays < ActiveRecord::Migration
  def self.up
    create_table :month_working_days do |t|
      t.date :year_month
      t.integer :working_days

      t.timestamps
    end
  end

  def self.down
    drop_table :month_working_days
  end
end
