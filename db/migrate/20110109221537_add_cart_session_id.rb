class AddCartSessionId < ActiveRecord::Migration
  def self.up
    add_column :carts, :session_id, :string, :default => ''
  end

  def self.down
    remove_column :carts, :session_id
  end
end
