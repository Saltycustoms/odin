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

ActiveRecord::Schema.define(version: 20170309074717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "att"
    t.string   "line1"
    t.string   "line2"
    t.string   "state"
    t.string   "post_code"
    t.string   "country_code"
    t.string   "city"
    t.string   "tel"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "blanks", force: :cascade do |t|
    t.integer  "price_cents", default: 0
    t.string   "name"
    t.jsonb    "meta"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "designs", force: :cascade do |t|
    t.integer  "order_id"
    t.jsonb    "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gateways", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.boolean  "disabled"
    t.jsonb    "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_lines", force: :cascade do |t|
    t.string   "description"
    t.integer  "price_per_unit_cents", default: 0
    t.integer  "price_cents",          default: 0
    t.integer  "quantity",             default: 0
    t.integer  "design_id"
    t.integer  "order_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "status",               default: 0
    t.integer  "shipment_total_cents", default: 0
    t.integer  "subtotal_cents",       default: 0
    t.integer  "net_total_cents",      default: 0
    t.integer  "tax_cents",            default: 0
    t.integer  "grand_total_cents",    default: 0
    t.string   "coupon"
    t.string   "currency"
    t.integer  "customer_id"
    t.datetime "due_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "ref"
    t.string   "amount_cents", default: "0"
    t.integer  "order_id"
    t.integer  "gateway_id"
    t.string   "type"
    t.text     "raw_data"
    t.integer  "status"
    t.jsonb    "properties"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "shipping_method_id"
    t.integer  "status",             default: 0
    t.integer  "address_id"
    t.integer  "amount_cents",       default: 0
    t.string   "tracking"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.string   "type"
    t.integer  "shipping_zone_id"
    t.integer  "calculator_id"
    t.string   "name"
    t.jsonb    "properties"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "shipping_zone_locations", force: :cascade do |t|
    t.string   "country_code"
    t.string   "state"
    t.integer  "shipping_zone_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "shipping_zones", force: :cascade do |t|
    t.string   "name"
    t.boolean  "disabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statement_items", force: :cascade do |t|
    t.string   "description"
    t.integer  "price_per_unit_cents", default: 0
    t.integer  "price_cents",          default: 0
    t.integer  "quantity",             default: 0
    t.integer  "statement_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "statements", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "shipment_total_cents", default: 0
    t.integer  "subtotal_cents",       default: 0
    t.integer  "net_total_cents",      default: 0
    t.integer  "tax_cents",            default: 0
    t.integer  "grand_total_cents",    default: 0
    t.string   "type"
    t.integer  "order_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "currency"
  end

  create_table "surfaces", force: :cascade do |t|
    t.text     "image_data"
    t.integer  "blank_id"
    t.integer  "side"
    t.integer  "width"
    t.integer  "height"
    t.integer  "width_mm"
    t.integer  "height_mm"
    t.integer  "left"
    t.integer  "top"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
