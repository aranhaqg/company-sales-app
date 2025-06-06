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

ActiveRecord::Schema[8.0].define(version: 2025_04_05_203559) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "description", null: false
    t.integer "price_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchasers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "count", null: false
    t.bigint "purchaser_id", null: false
    t.bigint "product_id", null: false
    t.bigint "merchant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_price_cents", null: false
    t.bigint "sale_report_id"
    t.index ["merchant_id"], name: "index_purchases_on_merchant_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["purchaser_id"], name: "index_purchases_on_purchaser_id"
    t.index ["sale_report_id"], name: "index_purchases_on_sale_report_id"
  end

  create_table "sale_reports", force: :cascade do |t|
    t.string "file_path", null: false
    t.integer "total_gross_income_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_all_time_gross_income_cents", default: 0, null: false
  end
end
