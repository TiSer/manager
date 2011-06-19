class RemoveCurrencyFromSalary < ActiveRecord::Migration
  def self.up
    remove_column :salaries, :currency
    remove_column :salaries, :tax_currency
  end

  def self.down
    add_column :salaries, :currency, :integer
    add_column :salaries, :tax_currency, :integer
  end
end

