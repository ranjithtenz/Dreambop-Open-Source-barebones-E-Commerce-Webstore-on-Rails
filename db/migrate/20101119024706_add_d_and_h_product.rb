class AddDAndHProduct < ActiveRecord::Migration
  def self.up
    create_table :dandh_products do |t|
      t.column :name, :string, :default => ''
      t.column :marketing_description, :text, :default => ''
      t.column :tech_description, :text, :default => ''
      t.column :manufacturer_url, :string, :default => ''
      t.column :warranty_length, :string, :default => ''
      t.column :dandh_item_number, :string, :default => ''
      t.column :vendor_part_number, :string, :default => ''
      t.column :upc_code, :string, :default => ''
      t.column :weight, :float, :default => 0.0
      t.column :msrp, :float, :default => 0.0
      t.column :reseller_price, :float, :default => 0.0
      t.column :dandh_whs, :string, :default => ''
      t.column :visalia_whs, :string, :default => ''
      t.column :vendor_name, :string, :default => ''
      t.column :category, :string, :default => ''
      t.column :subcategory, :string, :default => ''
      t.timestamps
    end
    remove_column :products, :quantity
  end

  def self.down
    add_column :products, :quantity, :integer
    drop_table :dandh_products
  end
end
