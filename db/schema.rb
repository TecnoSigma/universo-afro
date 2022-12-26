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

ActiveRecord::Schema.define(version: 2022_12_26_151852) do

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "state"
    t.string "city"
    t.boolean "ethnicity_self_declaration", default: false
    t.string "afro_id"
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "candidatures", force: :cascade do |t|
    t.bigint "company_vacant_job_id"
    t.bigint "candidate_vacant_job_id"
    t.index ["candidate_vacant_job_id"], name: "index_candidatures_on_candidate_vacant_job_id"
    t.index ["company_vacant_job_id"], name: "index_candidatures_on_company_vacant_job_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "complement"
    t.string "cnpj"
    t.string "district"
    t.string "email"
    t.string "nickname"
    t.string "name"
    t.string "number"
    t.string "password"
    t.string "postal_code"
    t.string "state"
    t.integer "status"
    t.string "afro_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "credits", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "professionals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cpf"
    t.string "email"
    t.string "password"
    t.string "address"
    t.string "number"
    t.string "complement"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.integer "status", default: 1
    t.bigint "profession_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profession_id"], name: "index_professionals_on_profession_id"
  end

  create_table "professions", force: :cascade do |t|
    t.string "name"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "uf"
    t.integer "external_id"
  end

  create_table "vacant_jobs", force: :cascade do |t|
    t.string "type"
    t.string "category"
    t.string "state"
    t.string "city"
    t.boolean "alert"
    t.boolean "remote"
    t.integer "status", default: 1
    t.string "vacant_job_id"
    t.text "details"
    t.integer "availabled_quantity", default: 0
    t.integer "filled_quantity", default: 0
    t.bigint "profession_id"
    t.bigint "candidate_id"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_vacant_jobs_on_candidate_id"
    t.index ["company_id"], name: "index_vacant_jobs_on_company_id"
    t.index ["profession_id"], name: "index_vacant_jobs_on_profession_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
