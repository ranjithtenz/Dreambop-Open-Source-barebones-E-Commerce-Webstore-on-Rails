class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :shipping_address_id
      t.integer :credit_card_id
      t.float :tax_cost
      t.float :shipping_cost
      t.float :subtotal
      t.float :total_cost
      t.string :status

      t.timestamps
    end
    add_index :orders, :user_id
  end

  def self.down
    drop_table :orders
  end
end
