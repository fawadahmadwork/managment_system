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

ActiveRecord::Schema[7.0].define(version: 2023_12_25_102159) do
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
    t.string "role"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bank_account_details", force: :cascade do |t|
    t.string "account_title"
    t.string "account_number"
    t.string "bank_name"
    t.string "branch_code"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "IBAN"
    t.index ["employee_id"], name: "index_bank_account_details_on_employee_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "starting_salary"
    t.integer "signup_bonus"
    t.string "probation_period"
    t.date "probation_completed_date"
  end

  create_table "leaves", force: :cascade do |t|
    t.string "leave_type"
    t.string "category"
    t.string "duration"
    t.string "duration_type"
    t.date "start_date"
    t.date "end_date"
    t.decimal "total_days"
    t.string "status"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "leave_days"
    t.index ["employee_id"], name: "index_leaves_on_employee_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "phone_number"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_phone_numbers_on_employee_id"
  end

  create_table "pre_todo_items", force: :cascade do |t|
    t.string "description"
    t.string "type"
    t.boolean "done"
    t.datetime "done_at"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_pre_todo_items_on_employee_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "project_type"
    t.string "billing_type"
    t.string "source"
    t.decimal "rate"
    t.decimal "fee_percentage"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_completed"
    t.string "status"
    t.string "source_detail"
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "salary_detail_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
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
    t.bigint "salary_structure_id"
    t.index ["salary_structure_id"], name: "index_salary_detail_histories_on_salary_structure_id"
  end

  create_table "salary_slips", force: :cascade do |t|
    t.date "salary_month"
    t.bigint "employee_id", null: false
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
    t.string "name"
    t.string "designation"
    t.string "date_of_joining"
    t.boolean "email_sent"
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

  create_table "todos", force: :cascade do |t|
    t.string "description"
    t.boolean "done"
    t.datetime "done_at"
    t.string "todo_type"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_todos_on_employee_id"
  end

  create_table "weekly_hours", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.decimal "hours"
    t.decimal "external_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.date "week_date"
    t.string "week_number"
    t.decimal "rate"
    t.decimal "fee_percentage"
    t.index ["project_id"], name: "index_weekly_hours_on_project_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_account_details", "employees"
  add_foreign_key "emails", "employees"
  add_foreign_key "leaves", "employees"
  add_foreign_key "phone_numbers", "employees"
  add_foreign_key "pre_todo_items", "employees"
  add_foreign_key "projects", "clients"
  add_foreign_key "salary_detail_histories", "salary_structures"
  add_foreign_key "salary_slips", "employees"
  add_foreign_key "salary_structures", "employees"
  add_foreign_key "todos", "employees"
  add_foreign_key "weekly_hours", "projects"
end
