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

ActiveRecord::Schema.define(version: 20230110063027) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "hierarchies", force: :cascade do |t|
    t.integer  "technology_id"
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["category_id"], name: "index_hierarchies_on_category_id"
    t.index ["technology_id"], name: "index_hierarchies_on_technology_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name"
    t.string   "owner"
    t.integer  "stargazer_count"
    t.integer  "fork_count"
    t.integer  "since_last_commit"
    t.integer  "hierarchy_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["hierarchy_id", "name", "owner"], name: "index_repositories_on_hierarchy_id_and_name_and_owner"
    t.index ["hierarchy_id"], name: "index_repositories_on_hierarchy_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_technologies_on_name"
  end

end
