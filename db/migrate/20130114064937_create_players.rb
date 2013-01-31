class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :password, :null => false

      t.timestamps
    end
    add_index :players, :name, :unique => true
    add_index :players, :email, :unique => true
  end
end
