# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_02_090341) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "eng_name"
    t.date "start_date"
    t.date "finish_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["eng_name"], name: "index_conferences_on_eng_name", unique: true
  end

  create_table "identifies", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "unionid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unionid"], name: "index_identifies_on_unionid", unique: true
    t.index ["user_id"], name: "index_identifies_on_user_id"
  end

  create_table "sign_up_data", force: :cascade do |t|
    t.integer "sign_up_form_id"
    t.integer "jsj_id"
    t.json "entry"
    t.string "use_data_type"
    t.datetime "jsj_created_at"
    t.datetime "jsj_updated_at"
    t.string "phone"
    t.string "email"
    t.string "openid"
    t.string "unionid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_sign_up_data_on_email"
    t.index ["jsj_id"], name: "index_sign_up_data_on_jsj_id"
    t.index ["openid"], name: "index_sign_up_data_on_openid"
    t.index ["phone"], name: "index_sign_up_data_on_phone"
    t.index ["sign_up_form_id"], name: "index_sign_up_data_on_sign_up_form_id"
    t.index ["unionid"], name: "index_sign_up_data_on_unionid"
  end

  create_table "sign_up_forms", force: :cascade do |t|
    t.integer "conference_id"
    t.string "form_identify"
    t.string "name"
    t.string "full_name"
    t.string "description"
    t.string "form_type"
    t.string "all_use_data_type"
    t.string "sign_up_link"
    t.json "form_struct"
    t.string "xml_fields"
    t.string "use_fields_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_sign_up_forms_on_conference_id"
    t.index ["form_identify"], name: "index_sign_up_forms_on_form_identify", unique: true
  end

  create_table "stream_codes", force: :cascade do |t|
    t.integer "sign_up_data_id"
    t.integer "sign_up_form_id"
    t.integer "conference_id"
    t.string "code"
    t.boolean "visible"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conference_id"], name: "index_stream_codes_on_conference_id"
    t.index ["sign_up_data_id"], name: "index_stream_codes_on_sign_up_data_id"
    t.index ["sign_up_form_id"], name: "index_stream_codes_on_sign_up_form_id"
  end

  create_table "twenty_one_junior_high_maths", force: :cascade do |t|
    t.integer "sign_up_form_id"
    t.integer "jsj_id"
    t.json "entry"
    t.string "use_data_type"
    t.datetime "jsj_last_modify"
    t.string "phone"
    t.string "email"
    t.string "openid"
    t.string "unionid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_twenty_one_junior_high_maths_on_email"
    t.index ["jsj_id"], name: "index_twenty_one_junior_high_maths_on_jsj_id"
    t.index ["openid"], name: "index_twenty_one_junior_high_maths_on_openid"
    t.index ["phone"], name: "index_twenty_one_junior_high_maths_on_phone"
    t.index ["sign_up_form_id"], name: "index_twenty_one_junior_high_maths_on_sign_up_form_id"
    t.index ["unionid"], name: "index_twenty_one_junior_high_maths_on_unionid"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "username"
    t.string "avatar"
    t.string "motto"
    t.string "otp_secret_key"
    t.integer "otp_counter"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sign_up_data", "sign_up_forms"
  add_foreign_key "sign_up_forms", "conferences"
  add_foreign_key "stream_codes", "conferences"
  add_foreign_key "stream_codes", "sign_up_data", column: "sign_up_data_id"
  add_foreign_key "stream_codes", "sign_up_forms"
  add_foreign_key "twenty_one_junior_high_maths", "sign_up_forms"
end
