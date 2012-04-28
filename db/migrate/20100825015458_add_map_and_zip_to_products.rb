class AddMapAndZipToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :map, :float, :default => 0.0
    rename_column :products, :ds_vendor_name, :ds_vendor_type
    rename_column :products, :ds_vendor_msrp, :msrp
    rename_column :products, :ds_vendor_reseller_price, :reseller_price
  end

  def self.down
    rename_column :products, :reseller_price, :ds_vendor_reseller_price
    rename_column :products, :msrp, :ds_vendor_msrp
    rename_column :products, :ds_vendor_type, :ds_vendor_name
    remove_column :products, :map
  end
end
