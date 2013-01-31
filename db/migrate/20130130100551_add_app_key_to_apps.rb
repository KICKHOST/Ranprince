class AddAppKeyToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_key, :string, :null => false, :default => ' '
    add_index :apps, :app_key, :unique => true
  end
end
