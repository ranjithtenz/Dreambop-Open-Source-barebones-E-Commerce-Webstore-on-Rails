class CreateCreditCards < ActiveRecord::Migration
  def self.up
    create_table :credit_cards do |t|
      t.integer :user_id
      t.string :number
      t.integer :month
      t.integer :year
      t.string :first_name
      t.string :last_name
      t.string :verification_value

      t.timestamps
    end
    add_index :credit_cards, :user_id
  end

  def self.down
    drop_table :credit_cards
  end
end
