class CreateScoreReports < ActiveRecord::Migration
  def change
    create_table :score_reports do |t|
      t.references :app, :null => false
      t.float :score, :null => false
      t.references :device, :null => false

      t.timestamps
    end
    add_index :score_reports, :app_id
    add_index :score_reports, :device_id
  end
end
