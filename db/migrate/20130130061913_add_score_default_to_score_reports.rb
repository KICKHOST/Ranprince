class AddScoreDefaultToScoreReports < ActiveRecord::Migration
  def up
    change_column :score_reports, :score, :float, :default => 0.0
  end
  def down
    change_column :score_reports, :score, :float
  end
end
