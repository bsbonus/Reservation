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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130418224348) do

  create_table "exclusions", :force => true do |t|
    t.date     "reserv_exclusion"
    t.integer  "recurrance_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "recurrances", :force => true do |t|
    t.date     "start_date"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "duration"
    t.string   "recur"
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "parent_id"
    t.string   "integer"
  end

  create_table "reservations", :force => true do |t|
    t.date     "date"
    t.time     "time_in"
    t.time     "time_out"
    t.string   "room"
    t.string   "recur"
    t.integer  "recurrance_duration"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "recurrance_id"
  end

end
