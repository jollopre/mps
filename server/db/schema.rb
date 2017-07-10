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

ActiveRecord::Schema.define(version: 20170607202359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "reference"
    t.string   "company_name"
    t.string   "address"
    t.string   "telephone"
    t.string   "email"
    t.string   "contact_name"
    t.string   "contact_surname"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["reference"], name: "index_customers_on_reference", using: :btree
  end

  create_table "feature_labels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feature_labels_on_name", using: :btree
  end

  create_table "feature_options", force: :cascade do |t|
    t.string   "name"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_feature_options_on_feature_id", using: :btree
  end

  create_table "feature_values", force: :cascade do |t|
    t.string   "value"
    t.integer  "feature_id"
    t.integer  "order_item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["feature_id"], name: "index_feature_values_on_feature_id", using: :btree
    t.index ["order_item_id"], name: "index_feature_values_on_order_item_id", using: :btree
  end

  create_table "features", force: :cascade do |t|
    t.integer  "feature_type"
    t.integer  "product_id"
    t.integer  "feature_label_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["feature_label_id"], name: "index_features_on_feature_label_id", using: :btree
    t.index ["feature_type"], name: "index_features_on_feature_type", using: :btree
    t.index ["product_id"], name: "index_features_on_product_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email",            null: false
    t.string   "password",         null: false
    t.string   "token"
    t.datetime "token_created_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["token"], name: "index_users_on_token", using: :btree
  end

  add_foreign_key "feature_options", "features"
  add_foreign_key "feature_values", "features"
  add_foreign_key "feature_values", "order_items"
  add_foreign_key "features", "feature_labels"
  add_foreign_key "features", "products"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "customers"
end
