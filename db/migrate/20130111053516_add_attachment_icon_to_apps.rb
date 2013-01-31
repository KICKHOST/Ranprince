class AddAttachmentIconToApps < ActiveRecord::Migration
  def change
    add_column :apps, :icon_updated_at, :datetime
  end
end
