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

ActiveRecord::Schema.define(version: 20141003051644) do

  create_table "accommodations", force: true do |t|
    t.integer  "travel_leg_id"
    t.string   "preffered_location"
    t.datetime "check_in"
    t.datetime "check_out"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "booked"
    t.string   "booking_comment"
  end

  create_table "car_hires", force: true do |t|
    t.integer  "travel_leg_id"
    t.string   "driver"
    t.string   "pickup_location"
    t.datetime "pickup_date"
    t.datetime "dropoff_date"
    t.string   "dropoff_location"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "booked"
    t.string   "booking_comment"
  end

  create_table "flights", force: true do |t|
    t.integer  "travel_leg_id"
    t.string   "preffered_flight"
    t.string   "preffered_time"
    t.string   "takeoff_location"
    t.string   "landing_location"
    t.datetime "flight_date"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "booked"
    t.string   "booking_comment"
    t.boolean  "return"
    t.datetime "return_date"
  end

  create_table "leave_requests", force: true do |t|
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "leave_type"
    t.string   "comment"
    t.string   "approved"
  end

  create_table "part_days", force: true do |t|
    t.integer  "leave_request_id"
    t.date     "part_date"
    t.datetime "part_start"
    t.datetime "part_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_days", ["leave_request_id"], name: "index_part_days_on_leave_request_id"

  create_table "spend_toils", force: true do |t|
    t.integer  "user_id"
    t.integer  "initial_amount"
    t.integer  "amount"
    t.date     "leave_date"
    t.string   "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "travel_legs", force: true do |t|
    t.integer  "travel_request_id"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_requests", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_audits", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.string   "description"
    t.string   "end_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_audits", ["user_id"], name: "index_user_audits_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.string   "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "manager_email"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
