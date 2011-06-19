class RenameTypeInSalary < ActiveRecord::Migration
  def self.up
    remove_column :salaries, :type
    add_column :salaries, :sal_type, :integer
  end

  def self.down
    add_column :salaries, :type, :integer
    remove_column :salaries, :sal_type
  end
end

