class AddSpexEssential < ActiveRecord::Migration
  def self.up
    create_table "spex_essential_products", :force => true do |t|
      t.integer  :etilize_product_id, :limit => 11
      t.string   :ingram_sku, :limit => 100
      t.string   :dandh_sku, :limit => 100
      t.string   :market, :limit => 40
      t.integer  :mfg_id, :limit => 11
      t.string   :manufacturer_name, :limit => 60
      t.string   :mfgpartno, :limit => 60
      t.string   :gtin, :limit => 255
      t.integer  :etilize_category_id, :limit => 11
      t.string   :category, :limit => 255
      t.text     :name
      t.text     :marketing_text
      t.text     :tech_specs
      t.string   :image_url, :limit => 100
      t.string   :etilize_creation_date, :limit => 50
      t.string   :etilize_modified_date, :limit => 50
    end
    add_index :spex_essential_products, :etilize_product_id
    add_index :spex_essential_products, :ingram_sku
    add_index :spex_essential_products, :dandh_sku
  end

  def self.down
    drop_table "spex_essential_products"
  end
end
