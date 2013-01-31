class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name, :null => false
      t.string :key, :null => false

      t.timestamps
    end
    add_index :devices, :key, :unique => true
  end
end
