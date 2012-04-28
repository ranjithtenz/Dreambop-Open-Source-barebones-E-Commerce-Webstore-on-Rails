class AddUniqueTitleToDsdi < ActiveRecord::Migration
  def self.up
    rename_column :dsdi_products, :dsdi_product_name, :name
    rename_column :dsdi_products, :dsdi_product_description, :description
    rename_column :dsdi_products, :dsdi_sku, :sku
    rename_column :dsdi_products, :dsdi_product_id, :vendor_product_id
    add_index :dsdi_products, :name, :unique => true
  end

  def self.down
    remove_index :dsdi_products, :column => :name
    rename_column :dsdi_products, :vendor_product_id, :dsdi_product_id
    rename_column :dsdi_products, :sku, :dsdi_sku
    rename_column :dsdi_products, :description, :dsdi_product_description
    rename_column :dsdi_products, :name, :dsdi_product_name
  end
end
