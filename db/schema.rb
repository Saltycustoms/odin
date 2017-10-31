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

ActiveRecord::Schema.define(version: 20171009092215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_ons", force: :cascade do |t|
    t.string "description"
    t.integer "price_per_unit_cents", default: 0
    t.integer "quantity"
    t.integer "total_cents", default: 0
    t.bigint "job_request_id"
    t.bigint "quotation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_add_ons_on_deleted_at"
    t.index ["job_request_id"], name: "index_add_ons_on_job_request_id"
    t.index ["quotation_id"], name: "index_add_ons_on_quotation_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country_code"
    t.string "belongable_type"
    t.bigint "belongable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["belongable_type", "belongable_id"], name: "index_addresses_on_belongable_type_and_belongable_id"
    t.index ["deleted_at"], name: "index_addresses_on_deleted_at"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.string "app"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.text "attachment_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.datetime "deleted_at"
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
    t.index ["deleted_at"], name: "index_attachments_on_deleted_at"
  end

  create_table "deadlines", force: :cascade do |t|
    t.bigint "deal_id"
    t.date "deadline"
    t.text "reason"
    t.string "cause_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "rush_order"
    t.index ["deal_id"], name: "index_deadlines_on_deal_id"
    t.index ["deleted_at"], name: "index_deadlines_on_deleted_at"
  end

  create_table "deals", force: :cascade do |t|
    t.integer "department_id"
    t.string "name"
    t.integer "no_of_pcs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pic_id"
    t.integer "organization_id"
    t.integer "employee_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_deals_on_deleted_at"
  end

  create_table "departments", force: :cascade do |t|
    t.integer "organization_id"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_departments_on_deleted_at"
  end

  create_table "discounts", force: :cascade do |t|
    t.bigint "deal_id"
    t.integer "value"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deal_id"], name: "index_discounts_on_deal_id"
    t.index ["deleted_at"], name: "index_discounts_on_deleted_at"
  end

  create_table "gateways", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_gateways_on_deleted_at"
  end

  create_table "job_request_properties", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.bigint "job_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_job_request_properties_on_deleted_at"
    t.index ["job_request_id", "name"], name: "index_job_request_properties_on_job_request_id_and_name", unique: true
    t.index ["job_request_id"], name: "index_job_request_properties_on_job_request_id"
  end

  create_table "job_requests", force: :cascade do |t|
    t.integer "deal_id"
    t.integer "product_id"
    t.string "name"
    t.text "remark"
    t.integer "budget"
    t.text "client_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata"
    t.boolean "provide_artwork", default: false
    t.text "design_brief"
    t.text "concept"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_job_requests_on_deleted_at"
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
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at"
  end

  create_table "packing_list_items", force: :cascade do |t|
    t.bigint "packing_list_id"
    t.integer "design_id"
    t.integer "job_request_id"
    t.integer "quantity", default: 0
    t.integer "product_id"
    t.integer "size_id"
    t.integer "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_packing_list_items_on_deleted_at"
    t.index ["packing_list_id"], name: "index_packing_list_items_on_packing_list_id"
  end

  create_table "packing_lists", force: :cascade do |t|
    t.bigint "deal_id"
    t.string "department"
    t.integer "shipping_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "upload_attachment", default: false
    t.datetime "deleted_at"
    t.index ["deal_id"], name: "index_packing_lists_on_deal_id"
    t.index ["deleted_at"], name: "index_packing_lists_on_deleted_at"
  end

  create_table "pics", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "title"
    t.string "belongable_type"
    t.bigint "belongable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.datetime "deleted_at"
    t.index ["belongable_type", "belongable_id"], name: "index_pics_on_belongable_type_and_belongable_id"
    t.index ["deleted_at"], name: "index_pics_on_deleted_at"
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
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_print_details_on_deleted_at"
  end

  create_table "quotation_lines", force: :cascade do |t|
    t.bigint "quotation_id"
    t.string "description"
    t.integer "price_per_unit_cents", default: 0
    t.integer "quantity", default: 0
    t.integer "total_cents", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_request_id"
    t.integer "size_id"
    t.integer "color_id"
    t.integer "product_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quotation_lines_on_deleted_at"
    t.index ["job_request_id"], name: "index_quotation_lines_on_job_request_id"
    t.index ["quotation_id"], name: "index_quotation_lines_on_quotation_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.bigint "deal_id"
    t.bigint "discount_id"
    t.string "payment_term"
    t.string "currency"
    t.integer "shipping_cents", default: 0
    t.integer "net_total_cents", default: 0
    t.integer "sub_total_cents", default: 0
    t.integer "tax_cents", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount_amount_cents", default: 0
    t.datetime "deleted_at"
    t.index ["deal_id"], name: "index_quotations_on_deal_id"
    t.index ["deleted_at"], name: "index_quotations_on_deleted_at"
    t.index ["discount_id"], name: "index_quotations_on_discount_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_number"
    t.string "currency"
    t.integer "value_cents"
    t.integer "gateway_id"
    t.string "type"
    t.text "raw"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deal_id"
    t.datetime "deleted_at"
    t.index ["deal_id"], name: "index_transactions_on_deal_id"
    t.index ["deleted_at"], name: "index_transactions_on_deleted_at"
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
    t.datetime "deleted_at"
    t.integer "roles_mask"
    t.string "name"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "add_ons", "job_requests"
  add_foreign_key "add_ons", "quotations"
  add_foreign_key "deadlines", "deals"
  add_foreign_key "discounts", "deals"
  add_foreign_key "job_request_properties", "job_requests"
  add_foreign_key "orders", "deals"
  add_foreign_key "packing_list_items", "packing_lists"
  add_foreign_key "packing_lists", "deals"
  add_foreign_key "quotation_lines", "job_requests"
  add_foreign_key "quotation_lines", "quotations"
  add_foreign_key "quotations", "deals"
  add_foreign_key "quotations", "discounts"
  add_foreign_key "transactions", "deals"
end
