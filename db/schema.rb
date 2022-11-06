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

ActiveRecord::Schema.define(version: 2022_11_06_215618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string "name"
    t.binary "data"
    t.string "filename"
    t.string "mime_type"
    t.bigint "candidate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_avatars_on_candidate_id"
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

  create_table "logotypes", force: :cascade do |t|
    t.string "name"
    t.binary "data"
    t.string "filename"
    t.string "mime_type"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_logotypes_on_company_id"
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

end
