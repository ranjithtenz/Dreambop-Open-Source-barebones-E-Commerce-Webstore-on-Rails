class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_index :carts, :user_id

    create_table :cart_products do |t|
      t.integer :cart_id, :null => false
      t.integer :product_id, :null => false
      t.timestamps
    end
    add_index :cart_products, :cart_id
  end

  def self.down
    drop_table :cart_products
    drop_table :carts
  end
end
