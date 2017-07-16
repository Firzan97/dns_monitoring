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

ActiveRecord::Schema.define(version: 20170714042658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "dnsname"
    t.string "ttl"
    t.string "recordtype"
    t.string "ipaddress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "graphinterval"
    t.string "question"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "details", force: :cascade do |t|
    t.decimal "average"
    t.decimal "maximum"
    t.decimal "minimum"
    t.decimal "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.integer "total_query"
    t.integer "total_fail"
    t.index ["question_id"], name: "index_details_on_question_id"
  end

  create_table "performances", force: :cascade do |t|
    t.integer "responsetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_performances_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "dnsname"
    t.string "recordtype"
    t.string "server"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "timeperiod"
    t.bigint "user_id"
    t.string "query"
    t.string "answer"
    t.string "authority"
    t.string "additional"
    t.string "status"
    t.string "udp"
    t.string "version"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "server"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "choices", "questions"
  add_foreign_key "details", "questions"
  add_foreign_key "performances", "questions"
  add_foreign_key "questions", "users"
end
