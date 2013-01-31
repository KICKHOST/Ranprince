class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, :null => false
      t.string :store_url
      t.binary :icon
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size

      t.timestamps
    end
  end
end
