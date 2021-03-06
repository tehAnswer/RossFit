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

ActiveRecord::Schema.define(version: 20140811170747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diets", force: true do |t|
    t.string   "name"
    t.text     "comment"
    t.string   "diet_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "diets", ["user_id"], name: "index_diets_on_user_id", using: :btree

  create_table "item_meals", force: true do |t|
    t.decimal  "quantity"
    t.integer  "item_id"
    t.integer  "meal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_meals", ["item_id"], name: "index_item_meals_on_item_id", using: :btree
  add_index "item_meals", ["meal_id"], name: "index_item_meals_on_meal_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.decimal  "calories"
    t.decimal  "fat"
    t.decimal  "carbohydrates"
    t.decimal  "protein"
    t.text     "description"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: true do |t|
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "diet_id"
  end

  add_index "meals", ["diet_id"], name: "index_meals_on_diet_id", using: :btree

  create_table "measures", force: true do |t|
    t.integer  "height"
    t.decimal  "weight"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_code"
  end

end
