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


ActiveRecord::Schema[7.1].define(version: 2024_06_28_165551) do
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

  create_table "adopter_applications", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "adopter_foster_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.boolean "profile_show", default: true
    t.bigint "organization_id", null: false
    t.bigint "form_submission_id", null: false
    t.index ["adopter_foster_account_id"], name: "index_adopter_applications_on_adopter_foster_account_id"
    t.index ["form_submission_id"], name: "index_adopter_applications_on_form_submission_id"
    t.index ["organization_id"], name: "index_adopter_applications_on_organization_id"
    t.index ["pet_id", "adopter_foster_account_id"], name: "index_adopter_applications_on_account_and_pet", unique: true
    t.index ["pet_id"], name: "index_adopter_applications_on_pet_id"
  end

  create_table "adopter_foster_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_adopter_foster_accounts_on_organization_id"
    t.index ["user_id"], name: "index_adopter_foster_accounts_on_user_id"
  end

  create_table "adopter_foster_profiles", force: :cascade do |t|
    t.bigint "adopter_foster_account_id", null: false
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
    t.bigint "organization_id", null: false
    t.index ["adopter_foster_account_id"], name: "index_adopter_foster_profiles_on_adopter_foster_account_id", unique: true
    t.index ["location_id"], name: "index_adopter_foster_profiles_on_location_id"
    t.index ["organization_id"], name: "index_adopter_foster_profiles_on_organization_id"
  end

  create_table "custom_pages", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "hero"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "adoptable_pet_info"
    t.index ["organization_id"], name: "index_custom_pages_on_organization_id"
  end

  create_table "default_pet_tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "due_in_days"
    t.boolean "recurring", default: false
    t.index ["organization_id"], name: "index_default_pet_tasks_on_organization_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question", null: false
    t.text "answer", null: false
    t.integer "order"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_faqs_on_organization_id"
  end

  create_table "form_profiles", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.string "profile_type", null: false
    t.integer "sort_order", default: 0, null: false
    t.index ["form_id", "profile_type"], name: "index_form_profiles_on_form_id_and_profile_type", unique: true
    t.index ["form_id"], name: "index_form_profiles_on_form_id"
  end

  create_table "form_submissions", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_form_submissions_on_organization_id"
    t.index ["person_id"], name: "index_form_submissions_on_person_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "title", null: false
    t.text "instructions"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["organization_id", "name"], name: "index_forms_on_organization_id_and_name", unique: true
    t.index ["organization_id", "title"], name: "index_forms_on_organization_id_and_title", unique: true
    t.index ["organization_id"], name: "index_forms_on_organization_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "adopter_foster_account_id", null: false
    t.bigint "pet_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adopter_foster_account_id", "pet_id"], name: "index_likes_on_adopter_foster_account_id_and_pet_id", unique: true
    t.index ["adopter_foster_account_id"], name: "index_likes_on_adopter_foster_account_id"
    t.index ["organization_id"], name: "index_likes_on_organization_id"
    t.index ["pet_id"], name: "index_likes_on_pet_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country"
    t.string "city_town"
    t.string "province_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "adopter_foster_account_id", null: false
    t.bigint "organization_id", null: false
    t.integer "match_type", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.index ["adopter_foster_account_id"], name: "index_matches_on_adopter_foster_account_id"
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
    t.text "facebook_url"
    t.text "instagram_url"
    t.text "donation_url"
    t.index ["location_id"], name: "index_organization_profiles_on_location_id"
    t.index ["organization_id"], name: "index_organization_profiles_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_people_on_email"
    t.index ["organization_id"], name: "index_people_on_organization_id"
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
    t.datetime "birth_date", null: false
    t.integer "weight_from", null: false
    t.integer "weight_to", null: false
    t.string "weight_unit", null: false
    t.integer "species", null: false
    t.integer "placement_type", null: false
    t.boolean "published", default: false, null: false
    t.index ["organization_id"], name: "index_pets_on_organization_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "label", null: false
    t.text "help_text"
    t.string "input_type", default: "short", null: false
    t.boolean "required", default: false, null: false
    t.json "options"
    t.integer "sort_order", default: 0, null: false
    t.bigint "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["form_id", "label"], name: "index_questions_on_form_id_and_label", unique: true
    t.index ["form_id", "name"], name: "index_questions_on_form_id_and_name", unique: true
    t.index ["form_id"], name: "index_questions_on_form_id"
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
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.datetime "deactivated_at"
    t.index ["organization_id"], name: "index_staff_accounts_on_organization_id"
    t.index ["user_id"], name: "index_staff_accounts_on_user_id"
  end

  create_table "submitted_answers", force: :cascade do |t|
    t.json "value", null: false
    t.json "question_snapshot", null: false
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_submission_id", null: false
    t.index ["form_submission_id"], name: "index_submitted_answers_on_form_submission_id"
    t.index ["question_id"], name: "index_submitted_answers_on_question_id"
    t.index ["user_id"], name: "index_submitted_answers_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "completed", default: false
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "due_date"
    t.boolean "recurring", default: false
    t.integer "next_due_date_in_days"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_tasks_on_organization_id"
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

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adopter_applications", "adopter_foster_accounts"
  add_foreign_key "adopter_applications", "form_submissions"
  add_foreign_key "adopter_applications", "pets"
  add_foreign_key "adopter_foster_accounts", "users"
  add_foreign_key "adopter_foster_profiles", "adopter_foster_accounts"
  add_foreign_key "adopter_foster_profiles", "locations"
  add_foreign_key "custom_pages", "organizations"
  add_foreign_key "default_pet_tasks", "organizations"
  add_foreign_key "faqs", "organizations"
  add_foreign_key "form_profiles", "forms"
  add_foreign_key "form_submissions", "organizations"
  add_foreign_key "form_submissions", "people"
  add_foreign_key "forms", "organizations"
  add_foreign_key "likes", "adopter_foster_accounts"
  add_foreign_key "likes", "organizations"
  add_foreign_key "likes", "pets"
  add_foreign_key "matches", "adopter_foster_accounts"
  add_foreign_key "matches", "pets"
  add_foreign_key "organization_profiles", "locations"
  add_foreign_key "organization_profiles", "organizations"
  add_foreign_key "people", "organizations"
  add_foreign_key "pets", "organizations"
  add_foreign_key "questions", "forms"
  add_foreign_key "staff_accounts", "organizations"
  add_foreign_key "staff_accounts", "users"
  add_foreign_key "submitted_answers", "form_submissions"
  add_foreign_key "submitted_answers", "questions"
  add_foreign_key "submitted_answers", "users"
  add_foreign_key "tasks", "pets"
end
