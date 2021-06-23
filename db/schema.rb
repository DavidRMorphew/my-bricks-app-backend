# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_23_184329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lego_sets", force: :cascade do |t|
    t.integer "theme_id"
    t.string "set_number"
    t.string "name"
    t.string "image_url"
    t.string "instructions_url"
    t.integer "year"
    t.boolean "owned"
    t.boolean "potential_build"
    t.integer "total_bricks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "part_categories", force: :cascade do |t|
    t.string "category_number"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parts", force: :cascade do |t|
    t.integer "part_category_id"
    t.string "part_number"
    t.string "name"
    t.string "color"
    t.string "image_url"
    t.boolean "for_match"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "set_part_specs", force: :cascade do |t|
    t.integer "lego_set_id"
    t.integer "part_id"
    t.integer "part_quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "themes", force: :cascade do |t|
    t.string "theme_number"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
