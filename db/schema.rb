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

ActiveRecord::Schema.define(version: 2018_09_23_073315) do

  create_table "admins", primary_key: "user_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "password", null: false
    t.string "name", null: false
    t.string "location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "found_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_type"
    t.string "color"
    t.string "brand"
    t.string "status"
    t.string "storage_loc"
    t.string "locker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lost_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_type"
    t.string "color"
    t.string "brand"
    t.date "date"
    t.string "status"
    t.string "user_id"
    t.integer "found_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "password", null: false
    t.string "name", null: false
    t.string "contact", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
