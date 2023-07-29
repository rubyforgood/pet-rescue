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

ActiveRecord::Schema[7.0].define(version: 2023_07_29_193411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
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

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "adopter_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 0, null: false
    t.index ["user_id"], name: "index_adopter_accounts_on_user_id"
  end

  create_table "adopter_applications", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "adopter_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.boolean "profile_show", default: true
    t.index ["adopter_account_id"], name: "index_adopter_applications_on_adopter_account_id"
    t.index ["pet_id"], name: "index_adopter_applications_on_pet_id"
  end

  create_table "adopter_profiles", force: :cascade do |t|
    t.bigint "adopter_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "contact_method"
    t.string "country"
    t.string "province_state"
    t.string "city_town"
    t.text "ideal_pet"
    t.text "lifestyle_fit"
    t.text "activities"
    t.integer "alone_weekday"
    t.integer "alone_weekend"
    t.text "experience"
    t.text "contingency_plan"
    t.boolean "shared_ownership"
    t.text "shared_owner"
    t.string "housing_type"
    t.boolean "fenced_access"
    t.text "fenced_alternative"
    t.text "location_day"
    t.text "location_night"
    t.boolean "do_you_rent"
    t.boolean "pets_allowed"
    t.integer "adults_in_home"
    t.integer "kids_in_home"
    t.boolean "other_pets"
    t.text "describe_pets"
    t.boolean "checked_shelter"
    t.boolean "surrendered_pet"
    t.text "describe_surrender"
    t.string "annual_cost"
    t.boolean "visit_laventana"
    t.text "visit_dates"
    t.text "referral_source"
    t.index ["adopter_account_id"], name: "index_adopter_profiles_on_adopter_account_id"
  end

  create_table "checklist_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.string "amount"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "adopter_profile_id", null: false
    t.string "country"
    t.string "city_town"
    t.string "province_state"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adopter_profile_id"], name: "index_locations_on_adopter_profile_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "adopter_account_id", null: false
    t.index ["adopter_account_id"], name: "index_matches_on_adopter_account_id"
    t.index ["pet_id"], name: "index_matches_on_pet_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subdomain"
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.string "breed"
    t.text "description"
    t.string "sex"
    t.string "name"
    t.boolean "application_paused", default: false
    t.integer "pause_reason", default: 0
    t.integer "age_unit", default: 0
    t.index ["organization_id"], name: "index_pets_on_organization_id"
  end

  create_table "staff_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", default: 1, null: false
    t.boolean "verified", default: false, null: false
    t.bigint "user_id", default: 0, null: false
    t.index ["organization_id"], name: "index_staff_accounts_on_organization_id"
    t.index ["user_id"], name: "index_staff_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tos_agreement"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adopter_accounts", "users"
  add_foreign_key "adopter_applications", "adopter_accounts"
  add_foreign_key "adopter_applications", "pets"
  add_foreign_key "adopter_profiles", "adopter_accounts"
  add_foreign_key "locations", "adopter_profiles"
  add_foreign_key "matches", "adopter_accounts"
  add_foreign_key "matches", "pets"
  add_foreign_key "pets", "organizations"
  add_foreign_key "staff_accounts", "organizations"
  add_foreign_key "staff_accounts", "users"
end
