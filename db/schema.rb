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

ActiveRecord::Schema.define(version: 20151111220010) do

  create_table "measurements", force: :cascade do |t|
    t.integer  "sensor_id"
    t.datetime "time"
    t.integer  "amount"
  end

  add_index "measurements", ["sensor_id"], name: "index_measurements_on_sensor_id"

  create_table "programs", force: :cascade do |t|
    t.string "name"
  end

  create_table "room_program_time_mappings", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "program_id"
    t.datetime "start"
    t.datetime "end"
  end

  add_index "room_program_time_mappings", ["program_id"], name: "index_room_program_time_mappings_on_program_id"
  add_index "room_program_time_mappings", ["room_id"], name: "index_room_program_time_mappings_on_room_id"

  create_table "rooms", force: :cascade do |t|
    t.string  "name"
    t.integer "sensor_id"
  end

  add_index "rooms", ["sensor_id"], name: "index_rooms_on_sensor_id"

  create_table "sensor_types", force: :cascade do |t|
    t.string "name"
    t.string "resource"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer "sensor_type_id"
  end

  add_index "sensors", ["sensor_type_id"], name: "index_sensors_on_sensor_type_id"

end
