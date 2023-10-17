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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_180938) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "location_id", null: false
    t.index ["adopter_account_id"], name: "index_adopter_profiles_on_adopter_account_id"
    t.index ["location_id"], name: "index_adopter_profiles_on_location_id"
  end

  create_table "checklist_assignments", force: :cascade do |t|
    t.bigint "checklist_template_item_id", null: false
    t.bigint "match_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checklist_template_item_id"], name: "index_checklist_assignments_on_checklist_template_item_id"
    t.index ["match_id"], name: "index_checklist_assignments_on_match_id"
  end

  create_table "checklist_template_items", force: :cascade do |t|
    t.bigint "checklist_template_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "expected_duration_days", null: false
    t.boolean "required", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checklist_template_id"], name: "index_checklist_template_items_on_checklist_template_id"
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
    t.string "country"
    t.string "city_town"
    t.string "province_state"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "adopter_account_id", null: false
    t.bigint "organization_id", null: false
    t.index ["adopter_account_id"], name: "index_matches_on_adopter_account_id"
    t.index ["organization_id"], name: "index_matches_on_organization_id"
    t.index ["pet_id"], name: "index_matches_on_pet_id"
  end

  create_table "organization_profiles", force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.bigint "location_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_organization_profiles_on_location_id"
    t.index ["organization_id"], name: "index_organization_profiles_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "breed"
    t.text "description"
    t.string "sex"
    t.string "name"
    t.boolean "application_paused", default: false
    t.integer "pause_reason", default: 0
    t.datetime "birth_date", null: false
    t.integer "weight_from", null: false
    t.integer "weight_to", null: false
    t.string "weight_unit", null: false
    t.integer "species", null: false
    t.index ["organization_id"], name: "index_pets_on_organization_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
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

  create_table "staff_accounts_roles", id: false, force: :cascade do |t|
    t.bigint "staff_account_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_staff_accounts_roles_on_role_id"
    t.index ["staff_account_id", "role_id"], name: "index_staff_accounts_roles_on_staff_account_id_and_role_id"
    t.index ["staff_account_id"], name: "index_staff_accounts_roles_on_staff_account_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "completed", default: false
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_tasks_on_pet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tos_agreement"
    t.bigint "organization_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adopter_accounts", "users"
  add_foreign_key "adopter_applications", "adopter_accounts"
  add_foreign_key "adopter_applications", "pets"
  add_foreign_key "adopter_profiles", "adopter_accounts"
  add_foreign_key "adopter_profiles", "locations"
  add_foreign_key "checklist_assignments", "checklist_template_items"
  add_foreign_key "checklist_assignments", "matches"
  add_foreign_key "checklist_template_items", "checklist_templates"
  add_foreign_key "matches", "adopter_accounts"
  add_foreign_key "matches", "pets"
  add_foreign_key "organization_profiles", "locations"
  add_foreign_key "organization_profiles", "organizations"
  add_foreign_key "pets", "organizations"
  add_foreign_key "staff_accounts", "organizations"
  add_foreign_key "staff_accounts", "users"
  add_foreign_key "tasks", "pets"
end
