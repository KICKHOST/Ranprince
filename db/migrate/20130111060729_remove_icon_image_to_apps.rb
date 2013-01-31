class RemoveIconImageToApps < ActiveRecord::Migration
  def up
    remove_column :apps, :icon
  end
  def down
    add_column :apps, :icon, :binary
  end
end
