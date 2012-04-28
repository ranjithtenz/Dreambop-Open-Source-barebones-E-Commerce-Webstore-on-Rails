class CreateOrderProducts < ActiveRecord::Migration
  def self.up
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
    add_index :order_products, :order_id
    add_index :order_products, :product_id
  end

  def self.down
    drop_table :order_products
  end
end
