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

ActiveRecord::Schema.define(version: 20160421201312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: :cascade do |t|
    t.integer "sensor_id"
    t.date    "date"
    t.integer "amount"
  end

  add_index "measurements", ["sensor_id"], name: "index_measurements_on_sensor_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string "name"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer "subtype_id"
    t.integer "program_id"
  end

  add_index "sensors", ["program_id"], name: "index_sensors_on_program_id", using: :btree
  add_index "sensors", ["subtype_id"], name: "index_sensors_on_subtype_id", using: :btree

  create_table "subtypes", force: :cascade do |t|
    t.integer "type_id"
    t.string  "name"
    t.boolean "usage?"
  end

  add_index "subtypes", ["type_id"], name: "index_subtypes_on_type_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string "resource"
  end

  add_foreign_key "measurements", "sensors"
  add_foreign_key "sensors", "subtypes"
  add_foreign_key "subtypes", "types"
end
