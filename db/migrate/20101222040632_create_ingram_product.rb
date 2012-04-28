class CreateIngramProduct < ActiveRecord::Migration
  def self.up
    create_table :ingram_micro_products do |t|
      t.integer :spex_essential_product_id, :null => false
      t.string :action_indicator, :default => ''
      t.string :ingram_sku, :default => '' #known as ingram_part_number in their docs
      t.string :vendor_number, :default => ''
      t.string :vendor_name, :default => ''
      t.string :part_description_1, :default => ''
      t.string :part_description_2, :default => ''
      t.float  :retail_price, :default => 0.0
      t.string :vendor_part_number, :default => ''
      t.float  :weight, :default => 0.0
      t.string :upc_code, :default => ''
      t.float  :legnth, :default => 0.0
      t.float  :width, :default => 0.0
      t.string :price_change_flag, :default => ''
      t.float  :customer_price, :default => 0.0
      t.float  :special_price_flag, :default => 0.0
      t.string :availability_flag, :default => ''
      t.string :sku_status, :default => ''
      t.string :alliance_flag, :default => ''
      t.string :cpu_code, :default => ''
      t.string :media_type, :default => ''
      t.string :ingram_category, :default => ''
      t.string :new_item_receipt_flag, :default => ''
      t.string :instant_rebate_flag, :default => ''
      t.string :restricted_flag, :default => ''
      t.timestamps
    end
    add_index :ingram_micro_products, :spex_essential_product_id, :unique => true
    add_index :ingram_micro_products, :ingram_sku, :unique => true
    remove_index :products, :title #we use the ID so it doesn't need to be unique
    add_column :products, :upc_code, :string, :default => ''
    #Category.create(:name => 'all')
  end

  def self.down
    remove_column :products, :upc_code
    add_index :products, :title #we use the ID so it doesn't need to be unique
    remove_index :ingram_micro_products, :column => :spex_essential_product_id
    drop_table :ingram_micro_products
  end
end
