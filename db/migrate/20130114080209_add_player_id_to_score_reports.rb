class AddPlayerIdToScoreReports < ActiveRecord::Migration
  def change
    add_column :score_reports, :player_id, :integer
    add_index :score_reports, :player_id
  end
end
