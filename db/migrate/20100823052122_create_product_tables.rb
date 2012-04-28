class CreateProductTables < ActiveRecord::Migration
  def self.up
    create_table :products, :options => 'ENGINE MyISAM' do |t|
      t.column :title, :string, :default => ''
      t.column :description, :text, :default => ''
      t.column :category, :string, :default => ''
      t.column :ds_vendor_id, :integer, :default => 0
      t.column :ds_vendor_name, :string, :default => ''
      t.column :ds_vendor_msrp, :float, :default => 0.0
      t.column :ds_vendor_reseller_price, :float, :default => 0
      t.column :manufacturer, :string, :default => ''
      t.column :quantity, :integer, :default => 0
      t.column :weight, :float, :default => 0.0
      t.timestamps
    end
    execute "CREATE FULLTEXT INDEX fulltext_product ON products (title, description, manufacturer);"
    add_index :products, :title, :unique => true

    create_table :dsdi_products do |t|
      t.column :dsdi_sku, :string, :default => ''
      t.column :model, :string, :default => ''
      t.column :manufacturers_name, :string, :default => ''
      t.column :dsdi_product_id, :integer, :default => 0
      t.column :dsdi_product_name, :string, :default => ''
      t.column :dsdi_product_description, :text, :default => ''
      t.column :quantity, :float, :default => 0.0
      t.column :category, :string, :default => ''
      t.column :master_category, :string, :default => ''
      t.column :product_added, :datetime 
      t.column :important_notes, :string, :default => ''
      t.column :images_path, :string, :default => ''
      t.column :reseller_price, :float, :default => 0.0
      t.column :msrp, :float, :default => 0.0
      t.column :ship_price, :float, :default => 0.0
      t.column :ship_method, :string, :default => ''
      t.column :weight, :float, :default => 0.0
      t.column :map, :string, :default => ''
      t.column :map_price, :string, :default => ''
      t.column :product_specs, :text, :default => ''
      t.column :product_image, :string, :default => ''
      t.column :ship_eta, :string, :default => ''
      t.column :ship_exception, :string, :default => ''
      t.column :quick_ship, :string, :default => ''
      t.column :product_warranty, :string, :default => ''
      t.column :product_refunds, :string, :default => ''
      t.column :zipcode, :string, :default => ''
    end
    add_index :dsdi_products, :dsdi_product_id
  end

  def self.down
    drop_table :dsdi_products
    drop_table :products
  end
end
