class AddAvailability < ActiveRecord::Migration
  def self.up
    add_column :products, :availability, :string, :default => 'NA'
  end

  def self.down
    remove_column :products, :availability
  end
end
