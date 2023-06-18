class CreateTapStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :tap_statistics do |t|
      t.json :tap_statistic_json

      t.timestamps
    end
  end
end
