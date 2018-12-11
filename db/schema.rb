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

ActiveRecord::Schema.define(version: 2018_12_06_165447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "objectives", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "race_id"
    t.string "kind"
    t.integer "duration"
    t.integer "distance"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_objectives_on_race_id"
    t.index ["user_id"], name: "index_objectives_on_user_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.integer "distance"
    t.string "address"
    t.string "zipcode"
    t.string "city"
    t.string "url"
    t.date "limit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_name"
    t.integer "department"
  end

  create_table "runs", force: :cascade do |t|
    t.bigint "objective_id"
    t.bigint "race_id"
    t.integer "targeted_time"
    t.integer "final_time"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["objective_id"], name: "index_runs_on_objective_id"
    t.index ["race_id"], name: "index_runs_on_race_id"
  end

  create_table "training_plans", force: :cascade do |t|
    t.string "name"
    t.integer "sessions_per_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "begin_date"
    t.date "end_date"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.bigint "training_plan_id"
    t.text "description"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["training_plan_id"], name: "index_training_sessions_on_training_plan_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "training_plan_id"
    t.date "begin_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_plan_id"], name: "index_trainings_on_training_plan_id"
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.string "level"
    t.integer "targeted_distance"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "objectives", "races"
  add_foreign_key "objectives", "users"
  add_foreign_key "runs", "objectives"
  add_foreign_key "runs", "races"
  add_foreign_key "training_sessions", "training_plans"
  add_foreign_key "trainings", "training_plans"
  add_foreign_key "trainings", "users"
end
