class CreateSalaries < ActiveRecord::Migration
  def self.up
    create_table :salaries do |t|
      t.integer :employee_id
      t.date :year_month
      t.integer :day_work_hours
      t.integer :type
      t.integer :currency
      t.integer :amount
      t.integer :tax_currency
      t.integer :tax_amount
      t.integer :tax_percent

      t.timestamps
    end
  end

  def self.down
    drop_table :salaries
  end
end
