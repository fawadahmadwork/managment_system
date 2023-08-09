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

ActiveRecord::Schema[7.0].define(version: 2023_08_09_151517) do
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

  create_table "bank_account_details", force: :cascade do |t|
    t.string "account_title"
    t.string "account_number"
    t.string "bank_name"
    t.string "branch_name"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "iban"
    t.index ["employee_id"], name: "index_bank_account_details_on_employee_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_emails_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "age"
    t.string "gender"
    t.date "date_of_joining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.string "address"
    t.string "national_id_card"
    t.string "designation"
    t.string "department"
    t.date "termination_date"
    t.string "avatar"
    t.text "notes"
    t.string "employment_status"
    t.string "first_name"
    t.string "last_name"
    t.string "employment_type"
    t.date "freezing_date"
    t.string "freezing_comment"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "phone_number"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_phone_numbers_on_employee_id"
  end

  create_table "salary_detail_histories", force: :cascade do |t|
    t.integer "salary"
    t.integer "allowances"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "basic_salary"
    t.integer "fuel"
    t.integer "medical_allownce"
    t.integer "house_ren"
    t.integer "opd"
    t.integer "arrears"
    t.integer "other_bonus"
    t.integer "gross_salary"
    t.integer "provident_fund"
    t.integer "unpaid_leaves"
    t.integer "net_salary"
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_salary_detail_histories_on_employee_id"
  end

  create_table "salary_details", force: :cascade do |t|
    t.string "name"
    t.integer "salary"
    t.integer "allowances"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_salary_details_on_employee_id"
  end

  create_table "salary_slips", force: :cascade do |t|
    t.integer "salary"
    t.integer "allownces"
    t.date "date"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_salary_slips_on_employee_id"
  end

  create_table "salary_structures", force: :cascade do |t|
    t.string "name"
    t.integer "salary"
    t.integer "allowances"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "basic_salary"
    t.integer "fuel"
    t.integer "medical_allownce"
    t.integer "house_rent"
    t.integer "opd"
    t.integer "arrears"
    t.integer "other_bonus"
    t.integer "gross_salary"
    t.integer "provident_fund"
    t.integer "unpaid_leaves"
    t.integer "net_salary"
    t.bigint "employee_id"
    t.index ["employee_id"], name: "index_salary_structures_on_employee_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_account_details", "employees"
  add_foreign_key "emails", "employees"
  add_foreign_key "phone_numbers", "employees"
  add_foreign_key "salary_detail_histories", "employees"
  add_foreign_key "salary_details", "employees"
  add_foreign_key "salary_slips", "employees"
  add_foreign_key "salary_structures", "employees"
end
