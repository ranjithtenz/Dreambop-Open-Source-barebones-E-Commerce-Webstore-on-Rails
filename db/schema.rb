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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120511175217) do

  create_table "cart_products", :force => true do |t|
    t.integer  "cart_id",    :null => false
    t.integer  "product_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_products", ["cart_id"], :name => "index_cart_products_on_cart_id"

  create_table "carts", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id", :default => ""
  end

  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.integer  "parent_id",  :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name", "parent_id"], :name => "index_categories_on_name_and_parent_id"
  add_index "categories", ["parent_id", "name"], :name => "index_categories_on_parent_id_and_name"

  create_table "credit_cards", :force => true do |t|
    t.integer  "user_id"
    t.string   "number"
    t.integer  "month"
    t.integer  "year"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "verification_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",       :default => "5305148831"
    t.string   "address",            :default => ""
    t.string   "city",               :default => ""
    t.string   "state",              :default => ""
    t.string   "zip",                :default => ""
  end

  add_index "credit_cards", ["user_id"], :name => "index_credit_cards_on_user_id"

  create_table "dandh_products", :force => true do |t|
    t.string   "name",                  :default => ""
    t.text     "marketing_description"
    t.text     "tech_description"
    t.string   "manufacturer_url",      :default => ""
    t.string   "warranty_length",       :default => ""
    t.string   "dandh_item_number",     :default => ""
    t.string   "vendor_part_number",    :default => ""
    t.string   "upc_code",              :default => ""
    t.float    "weight",                :default => 0.0
    t.float    "msrp",                  :default => 0.0
    t.float    "reseller_price",        :default => 0.0
    t.string   "dandh_whs",             :default => ""
    t.string   "visalia_whs",           :default => ""
    t.string   "vendor_name",           :default => ""
    t.string   "category",              :default => ""
    t.string   "subcategory",           :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dsdi_products", :force => true do |t|
    t.string   "sku",                :default => ""
    t.string   "model",              :default => ""
    t.string   "manufacturers_name", :default => ""
    t.integer  "vendor_product_id",  :default => 0
    t.string   "name",               :default => ""
    t.text     "description"
    t.float    "quantity",           :default => 0.0
    t.string   "category",           :default => ""
    t.string   "master_category",    :default => ""
    t.datetime "product_added"
    t.string   "important_notes",    :default => ""
    t.string   "images_path",        :default => ""
    t.float    "reseller_price",     :default => 0.0
    t.float    "msrp",               :default => 0.0
    t.float    "ship_price",         :default => 0.0
    t.string   "ship_method",        :default => ""
    t.float    "weight",             :default => 0.0
    t.string   "map",                :default => ""
    t.string   "map_price",          :default => ""
    t.text     "product_specs"
    t.string   "product_image",      :default => ""
    t.string   "ship_eta",           :default => ""
    t.string   "ship_exception",     :default => ""
    t.string   "quick_ship",         :default => ""
    t.string   "product_warranty",   :default => ""
    t.string   "product_refunds",    :default => ""
    t.string   "zipcode",            :default => ""
  end

  add_index "dsdi_products", ["name"], :name => "index_dsdi_products_on_name", :unique => true
  add_index "dsdi_products", ["vendor_product_id"], :name => "index_dsdi_products_on_dsdi_product_id"

  create_table "ingram_micro_products", :force => true do |t|
    t.integer  "spex_essential_product_id",                  :null => false
    t.string   "action_indicator",          :default => ""
    t.string   "ingram_sku",                :default => ""
    t.string   "vendor_number",             :default => ""
    t.string   "vendor_name",               :default => ""
    t.string   "part_description_1",        :default => ""
    t.string   "part_description_2",        :default => ""
    t.float    "retail_price",              :default => 0.0
    t.string   "vendor_part_number",        :default => ""
    t.float    "weight",                    :default => 0.0
    t.string   "upc_code",                  :default => ""
    t.float    "legnth",                    :default => 0.0
    t.float    "width",                     :default => 0.0
    t.string   "price_change_flag",         :default => ""
    t.float    "customer_price",            :default => 0.0
    t.float    "special_price_flag",        :default => 0.0
    t.string   "availability_flag",         :default => ""
    t.string   "sku_status",                :default => ""
    t.string   "alliance_flag",             :default => ""
    t.string   "cpu_code",                  :default => ""
    t.string   "media_type",                :default => ""
    t.string   "ingram_category",           :default => ""
    t.string   "new_item_receipt_flag",     :default => ""
    t.string   "instant_rebate_flag",       :default => ""
    t.string   "restricted_flag",           :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingram_micro_products", ["ingram_sku"], :name => "index_ingram_micro_products_on_ingram_sku", :unique => true
  add_index "ingram_micro_products", ["spex_essential_product_id"], :name => "index_ingram_micro_products_on_spex_essential_product_id", :unique => true

  create_table "order_products", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_products", ["order_id"], :name => "index_order_products_on_order_id"
  add_index "order_products", ["product_id"], :name => "index_order_products_on_product_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "shipping_address_id"
    t.integer  "credit_card_id"
    t.float    "tax_cost"
    t.float    "shipping_cost"
    t.float    "subtotal"
    t.float    "total_cost"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_number",  :default => ""
    t.string   "tracking_number",     :default => ""
    t.string   "tracking_type",       :default => ""
    t.text     "notes"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "product_images", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "product_id",                      :null => false
    t.integer  "parent_id",    :default => 0
    t.boolean  "thumbnail"
    t.integer  "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hero",         :default => false
  end

  add_index "product_images", ["product_id", "parent_id"], :name => "index_product_images_on_product_id_and_parent_id"

  create_table "products", :force => true do |t|
    t.string   "title",          :default => ""
    t.text     "description"
    t.integer  "ds_vendor_id",   :default => 0
    t.string   "ds_vendor_type", :default => ""
    t.float    "msrp",           :default => 0.0
    t.float    "reseller_price", :default => 0.0
    t.string   "manufacturer",   :default => ""
    t.float    "weight",         :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "map",            :default => 0.0
    t.integer  "category_id",    :default => 0,    :null => false
    t.string   "upc_code",       :default => ""
    t.string   "availability",   :default => "NA"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["title", "description", "manufacturer"], :name => "fulltext_product"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shipping_addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current_default", :default => false
    t.string   "session_id",      :default => ""
  end

  add_index "shipping_addresses", ["user_id"], :name => "index_shipping_addresses_on_user_id"

  create_table "spex_essential_products", :force => true do |t|
    t.integer "etilize_product_id"
    t.string  "ingram_sku",            :limit => 100
    t.string  "dandh_sku",             :limit => 100
    t.string  "market",                :limit => 40
    t.integer "mfg_id"
    t.string  "manufacturer_name",     :limit => 60
    t.string  "mfgpartno",             :limit => 60
    t.string  "gtin"
    t.integer "etilize_category_id"
    t.string  "category"
    t.text    "name"
    t.text    "marketing_text"
    t.text    "tech_specs"
    t.string  "image_url",             :limit => 100
    t.string  "etilize_creation_date", :limit => 50
    t.string  "etilize_modified_date", :limit => 50
  end

  add_index "spex_essential_products", ["dandh_sku"], :name => "index_spex_essential_products_on_dandh_sku"
  add_index "spex_essential_products", ["etilize_product_id"], :name => "index_spex_essential_products_on_etilize_product_id"
  add_index "spex_essential_products", ["ingram_sku"], :name => "index_spex_essential_products_on_ingram_sku"

  create_table "users", :force => true do |t|
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
