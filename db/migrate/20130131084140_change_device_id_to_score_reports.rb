class ChangeDeviceIdToScoreReports < ActiveRecord::Migration
  def up
    remove_column :score_reports, :device_id
    add_column :score_reports, :device_id, :integer, :null => true
  end

  def down
    remove_column :score_reports, :device_id
    add_column :score_reports, :device_id, :integer, :null => false, :default => 0
  end
end
