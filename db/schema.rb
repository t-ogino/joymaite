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

ActiveRecord::Schema.define(version: 20140730003100) do

  create_table "gift_masters", force: true do |t|
    t.string   "gift_div"
    t.string   "condition"
    t.integer  "condition_year"
    t.string   "amount"
    t.string   "year_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_msts", force: true do |t|
    t.string   "menber_no"
    t.string   "menber_name"
    t.date     "admission_date"
    t.date     "withdrawal_date"
    t.date     "birth_date"
    t.date     "enter_date"
    t.date     "marry_date"
    t.string   "memo"
    t.string   "del_flg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "msg_code"
    t.text     "message"
    t.string   "upd_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "name_msts", force: true do |t|
    t.string   "code_id"
    t.string   "code_id_name"
    t.string   "code"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "sex"
    t.date     "birth"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
