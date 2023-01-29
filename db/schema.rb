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

ActiveRecord::Schema[7.0].define(version: 2023_01_29_114114) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "body_parts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "body_part_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "meal_title", null: false
    t.integer "meal_weight", null: false
    t.integer "meal_calorie", null: false
    t.uuid "meal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_details_on_meal_id"
  end

  create_table "meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "meal_date"
    t.integer "meal_period"
    t.integer "meal_type"
    t.text "meal_memo"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "introduction"
    t.float "height"
    t.float "body_weight"
    t.integer "age"
    t.integer "sex"
    t.integer "active_level"
    t.float "target_weight"
    t.datetime "target_date"
    t.integer "maintenance_calorie"
    t.integer "adjustment_calorie"
    t.integer "target_calorie"
    t.string "twitter_link"
    t.string "facebook_link"
    t.string "instagram_link"
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workout_body_parts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "workout_id", null: false
    t.uuid "body_part_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_part_id"], name: "index_workout_body_parts_on_body_part_id"
    t.index ["workout_id"], name: "index_workout_body_parts_on_workout_id"
  end

  create_table "workouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "workout_date"
    t.string "workout_title"
    t.integer "workout_time"
    t.float "workout_weight"
    t.integer "repetition_count"
    t.integer "set_count"
    t.text "workout_memo"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "meal_details", "meals"
  add_foreign_key "meals", "users"
  add_foreign_key "workout_body_parts", "body_parts"
  add_foreign_key "workout_body_parts", "workouts"
  add_foreign_key "workouts", "users"
end
