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

ActiveRecord::Schema.define(version: 2019_06_20_033512) do

  create_table "courses", force: :cascade do |t|
    t.text "skill"
    t.text "quality"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "day_id"
  end

  create_table "has", force: :cascade do |t|
    t.integer "cong_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ipas", force: :cascade do |t|
    t.string "name"
    t.text "list_words"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "read_aloud_charts", force: :cascade do |t|
    t.integer "sentence"
    t.integer "rate"
    t.integer "total"
    t.date "date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "result"
  end

  create_table "read_aloud_reports", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sentence"
    t.integer "percent"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "read_alouds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "audio_user"
    t.string "content"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string "auth_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "write_fr_dics", force: :cascade do |t|
    t.string "audio"
    t.text "content"
    t.text "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wrong_pronunciations", force: :cascade do |t|
    t.integer "user_id"
    t.string "wrong_words"
    t.string "wrong_phonetic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
