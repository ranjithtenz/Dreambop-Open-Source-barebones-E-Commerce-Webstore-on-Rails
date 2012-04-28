class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :null => false, :default => ''
      t.integer :parent_id, :null => false, :default => 0
      t.timestamps
    end
    add_index :categories, [:name, :parent_id]
    add_index :categories, [:parent_id, :name]
    remove_column :products, :category
    add_column :products, :category_id, :integer, :null => false, :default => 0
    add_index :products, :category_id
  end

  def self.down
    remove_index :products, :column => :category_id
    remove_column :products, :category_id
    add_column :products, :category, :string
    drop_table :categories
  end
end
