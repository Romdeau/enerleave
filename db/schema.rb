# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140310025250) do

  create_table "costcenters", force: true do |t|
    t.string   "cost_code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_requests", force: true do |t|
    t.string   "employee"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "leave_type"
    t.string   "comment"
  end

  create_table "projects", force: true do |t|
    t.string   "project_number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spend_toils", force: true do |t|
    t.integer  "user_id"
    t.integer  "initial_amount"
    t.integer  "amount"
    t.date     "leave_date"
    t.string   "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeitems", force: true do |t|
    t.integer  "user_id"
    t.integer  "timesheet_id"
    t.date     "start_time"
    t.date     "end_time"
    t.string   "description"
    t.integer  "cost_center_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeitems", ["cost_center_id"], name: "index_timeitems_on_cost_center_id"
  add_index "timeitems", ["project_id"], name: "index_timeitems_on_project_id"
  add_index "timeitems", ["timesheet_id"], name: "index_timeitems_on_timesheet_id"
  add_index "timeitems", ["user_id"], name: "index_timeitems_on_user_id"

  create_table "timesheets", force: true do |t|
    t.integer  "user_id"
    t.integer  "timeweek_id"
    t.date     "timesheet_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timesheets", ["timeweek_id"], name: "index_timesheets_on_timeweek_id"
  add_index "timesheets", ["user_id"], name: "index_timesheets_on_user_id"

  create_table "timeweeks", force: true do |t|
    t.integer  "user_id"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeweeks", ["user_id"], name: "index_timeweeks_on_user_id"

  create_table "toil_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "initial_amount"
    t.integer  "amount"
    t.date     "date_accrued"
    t.string   "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_accrued_end"
  end

  add_index "toil_requests", ["user_id"], name: "index_toil_requests_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",            null: false
    t.string   "crypted_password", null: false
    t.string   "salt",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
