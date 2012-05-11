class AddHeroField < ActiveRecord::Migration
  def up
    add_column :product_images, :hero, :boolean, :default => false
  end

  def down
    remove_column :product_images, :hero
  end
end
