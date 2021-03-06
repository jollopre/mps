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

ActiveRecord::Schema.define(version: 2019_03_07_183905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composed_emails", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.binary "attachment"
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "composed_emails_enquiries", id: false, force: :cascade do |t|
    t.bigint "composed_email_id"
    t.bigint "enquiry_id"
    t.index ["composed_email_id"], name: "index_composed_emails_enquiries_on_composed_email_id"
    t.index ["enquiry_id"], name: "index_composed_emails_enquiries_on_enquiry_id"
  end

  create_table "composed_emails_suppliers", id: false, force: :cascade do |t|
    t.bigint "composed_email_id"
    t.bigint "supplier_id"
    t.index ["composed_email_id"], name: "index_composed_emails_suppliers_on_composed_email_id"
    t.index ["supplier_id"], name: "index_composed_emails_suppliers_on_supplier_id"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "reference"
    t.string "company_name"
    t.string "address"
    t.string "telephone"
    t.string "email"
    t.string "contact_name"
    t.string "contact_surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.index ["reference"], name: "index_customers_on_reference"
  end

  create_table "enquiries", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 1
    t.integer "quotation_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity2", default: 0
    t.integer "quantity3", default: 0
    t.index ["product_id"], name: "index_enquiries_on_product_id"
    t.index ["quotation_id"], name: "index_enquiries_on_quotation_id"
  end

  create_table "feature_labels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feature_labels_on_name"
  end

  create_table "feature_options", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_feature_options_on_feature_id"
  end

  create_table "feature_values", id: :serial, force: :cascade do |t|
    t.string "value"
    t.integer "feature_id"
    t.integer "enquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enquiry_id"], name: "index_feature_values_on_enquiry_id"
    t.index ["feature_id"], name: "index_feature_values_on_feature_id"
  end

  create_table "features", id: :serial, force: :cascade do |t|
    t.integer "feature_type"
    t.integer "product_id"
    t.integer "feature_label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_label_id"], name: "index_features_on_feature_label_id"
    t.index ["feature_type"], name: "index_features_on_feature_type"
    t.index ["product_id"], name: "index_features_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotations", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_quotations_on_customer_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "reference"
    t.string "company_name"
    t.string "contact"
    t.string "email"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.index ["reference"], name: "index_suppliers_on_reference"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email", null: false
    t.string "password", null: false
    t.string "token"
    t.datetime "token_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["token"], name: "index_users_on_token"
  end

  add_foreign_key "enquiries", "products"
  add_foreign_key "enquiries", "quotations"
  add_foreign_key "feature_options", "features"
  add_foreign_key "feature_values", "enquiries"
  add_foreign_key "feature_values", "features"
  add_foreign_key "features", "feature_labels"
  add_foreign_key "features", "products"
  add_foreign_key "quotations", "customers"
end
