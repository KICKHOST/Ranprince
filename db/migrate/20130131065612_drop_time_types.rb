class DropTimeTypes < ActiveRecord::Migration
  def up
    drop_table :time_types
  end

  def down
    create_table :time_types do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :time_types, :name, :unique => true
  end
end
