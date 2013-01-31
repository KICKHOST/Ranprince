class AddDeviceUniqueCodeToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :uid, :string, :null => false, :default => ' '
    add_index :players, :uid, :unique => true
    remove_column :players, :email
    remove_column :players, :password
  end
  def down
    remove_column :players, :uid
    remove_index :players, :uid
    add_column :players, :email, :string, :null => false
    add_column :players, :password, :string, :null => false
  end
end
