class AddNotes < ActiveRecord::Migration
  def self.up
    add_column :orders, :notes, :text, :default => ''
  end

  def self.down
    remove_column :orders, :notes
  end
end
