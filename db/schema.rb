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

ActiveRecord::Schema.define(version: 20170430211237) do

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "slots"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "classroom_id"
    t.index ["classroom_id"], name: "index_companies_on_classroom_id"
  end

  create_table "pairings", force: :cascade do |t|
    t.integer  "placement_id"
    t.integer  "student_id"
    t.integer  "company_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["company_id"], name: "index_pairings_on_company_id"
    t.index ["placement_id"], name: "index_pairings_on_placement_id"
    t.index ["student_id"], name: "index_pairings_on_student_id"
  end

  create_table "placements", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "classroom_id"
    t.index ["classroom_id"], name: "index_placements_on_classroom_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "company_id"
    t.integer  "student_ranking"
    t.integer  "interview_result"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["company_id"], name: "index_rankings_on_company_id"
    t.index ["student_id"], name: "index_rankings_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "classroom_id"
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "oauth_provider"
    t.string   "oauth_uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "token_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
