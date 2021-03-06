# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110623095601) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.string   "invoice_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_costs", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "project_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.integer  "project_id"
    t.integer  "employee_id"
    t.integer  "activity_id"
    t.date     "date"
    t.integer  "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "country"
    t.string   "name"
    t.text     "details"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "milestone_id"
    t.text     "description"
    t.integer  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.integer  "department_id"
    t.string   "name"
    t.string   "email"
    t.boolean  "is_active",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_activity_id"
  end

  create_table "employees_projects", :id => false, :force => true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees_skills", :id => false, :force => true do |t|
    t.integer  "employee_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "milestones", :force => true do |t|
    t.integer  "project_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "amount"
    t.string   "name"
    t.string   "invoice_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_working_days", :force => true do |t|
    t.date     "year_month"
    t.integer  "working_days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.string   "payment_model"
    t.boolean  "is_active",     :default => true
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salaries", :force => true do |t|
    t.integer  "employee_id"
    t.date     "year_month"
    t.integer  "day_work_hours"
    t.integer  "amount"
    t.integer  "tax_amount"
    t.integer  "tax_percent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sal_type"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                            :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
