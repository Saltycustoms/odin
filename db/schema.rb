# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170711094723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deadlines", force: :cascade do |t|
    t.bigint "deal_id"
    t.date "deadline"
    t.text "reason"
    t.string "cause_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deadlines_on_deal_id"
  end

  create_table "deals", force: :cascade do |t|
    t.integer "department_id"
    t.string "name"
    t.integer "no_of_pcs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pic_id"
    t.integer "organization_id"
  end

  create_table "departments", force: :cascade do |t|
    t.integer "organization_id"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.bigint "deal_id"
    t.integer "value"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_discounts_on_deal_id"
  end

  create_table "job_requests", force: :cascade do |t|
    t.integer "deal_id"
    t.integer "product_id"
    t.integer "color_id"
    t.string "name"
    t.string "sleeve"
    t.string "relabeling"
    t.string "woven_tag"
    t.string "hang_tag"
    t.string "pantone_code"
    t.text "remark"
    t.string "sample_required"
    t.integer "budget"
    t.text "client_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_orders_on_deal_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "industry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pics", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "title"
    t.string "belongable_type"
    t.bigint "belongable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["belongable_type", "belongable_id"], name: "index_pics_on_belongable_type_and_belongable_id"
  end

  create_table "print_details", force: :cascade do |t|
    t.integer "job_request_id"
    t.string "position"
    t.string "block"
    t.string "color_count"
    t.string "print_method"
    t.text "attachment_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotation_lines", force: :cascade do |t|
    t.bigint "quotation_id"
    t.string "description"
    t.integer "price_per_unit_cents"
    t.integer "quantity"
    t.integer "total_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quotation_id"], name: "index_quotation_lines_on_quotation_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.bigint "deal_id"
    t.bigint "discount_id"
    t.bigint "job_request_id"
    t.string "payment_term"
    t.string "currency"
    t.integer "shipping"
    t.integer "net_total_cents"
    t.integer "sub_total_cents"
    t.integer "tax_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_quotations_on_deal_id"
    t.index ["discount_id"], name: "index_quotations_on_discount_id"
    t.index ["job_request_id"], name: "index_quotations_on_job_request_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "order_id"
    t.string "transaction_number"
    t.string "currency"
    t.integer "value_cents"
    t.integer "gateway_id"
    t.string "type"
    t.text "raw"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "roles"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deadlines", "deals"
  add_foreign_key "discounts", "deals"
  add_foreign_key "orders", "deals"
  add_foreign_key "quotation_lines", "quotations"
  add_foreign_key "quotations", "deals"
  add_foreign_key "quotations", "discounts"
  add_foreign_key "quotations", "job_requests"
  add_foreign_key "transactions", "orders"
end
