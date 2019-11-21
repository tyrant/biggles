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

ActiveRecord::Schema.define(version: 2019_11_19_035451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "language_users", force: :cascade do |t|
    t.bigint "language_id"
    t.bigint "user_id"
    t.index ["language_id"], name: "index_language_users_on_language_id"
    t.index ["user_id"], name: "index_language_users_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "seen_at"
    t.bigint "messager_id"
    t.bigint "messagee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["messagee_id"], name: "index_messages_on_messagee_id"
    t.index ["messager_id"], name: "index_messages_on_messager_id"
  end

  create_table "postcodes", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "state"
    t.string "county"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.bigint "reviewer_id"
    t.bigint "reviewee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "saved_profiles", force: :cascade do |t|
    t.bigint "saver_id"
    t.bigint "savee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["savee_id"], name: "index_saved_profiles_on_savee_id"
    t.index ["saver_id"], name: "index_saved_profiles_on_saver_id"
  end

  create_table "student_subjects", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_subjects_on_student_id"
    t.index ["subject_id"], name: "index_student_subjects_on_subject_id"
  end

  create_table "subject_tutors", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "tutor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_subject_tutors_on_subject_id"
    t.index ["tutor_id"], name: "index_subject_tutors_on_tutor_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tutor_availabilities", force: :cascade do |t|
    t.bigint "tutor_id"
    t.bigint "availability_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["availability_id"], name: "index_tutor_availabilities_on_availability_id"
    t.index ["tutor_id"], name: "index_tutor_availabilities_on_tutor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.integer "age"
    t.integer "max_distance_available"
    t.decimal "hourly_rate"
    t.text "biography"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_seen"
    t.integer "postcode_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "messages", "users", column: "messagee_id"
  add_foreign_key "messages", "users", column: "messager_id"
  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "saved_profiles", "users", column: "savee_id"
  add_foreign_key "saved_profiles", "users", column: "saver_id"
  add_foreign_key "student_subjects", "users", column: "student_id"
  add_foreign_key "subject_tutors", "users", column: "tutor_id"
  add_foreign_key "users", "postcodes"
end
