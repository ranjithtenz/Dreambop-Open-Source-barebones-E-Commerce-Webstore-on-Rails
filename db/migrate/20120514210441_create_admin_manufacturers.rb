class CreateAdminManufacturers < ActiveRecord::Migration
  def up
    create_table :manufacturers do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    remove_column :products, :manufacturer
    add_column :products, :manufacturer_id, :integer, :default => '1'
  end

  def down
    remove_column :products, :manufacturer_id
    add_column :products, :manufacturer
    drop_table :manufacturers
  end
end
