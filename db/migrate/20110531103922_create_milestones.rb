class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.integer :project_id
      t.date :start_date
      t.date :end_date
      t.integer :amount
      t.string :name
      t.string :invoice_name

      t.timestamps
    end
  end

  def self.down
    drop_table :milestones
  end
end
