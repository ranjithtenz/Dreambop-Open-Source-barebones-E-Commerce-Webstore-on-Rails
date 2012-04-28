class AddBillingAddress < ActiveRecord::Migration
  def self.up
    add_column :credit_cards, :address, :string, :default => ''
    add_column :credit_cards, :city, :string, :default => ''
    add_column :credit_cards, :state, :string, :default => ''
    add_column :credit_cards, :zip, :string, :default => ''
    add_column :orders, :transaction_number, :string, :default => ''
    add_column :orders, :tracking_number, :string, :default => ''
    add_column :orders, :tracking_type, :string, :default => ''
  end

  def self.down
    remove_column :orders, :tracking_type
    remove_column :orders, :tracking_number
    remove_column :orders, :transaction_number
    remove_column :credit_cards, :zip
    remove_column :credit_cards, :state
    remove_column :credit_cards, :city
    remove_column :credit_cards, :address
  end
end
