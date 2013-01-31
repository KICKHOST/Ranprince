class CreateTimeTypes < ActiveRecord::Migration
  def change
    create_table :time_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
    add_index :time_types, :name, :unique => true
  end
end
