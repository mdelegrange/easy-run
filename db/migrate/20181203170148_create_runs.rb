class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|
      t.references :objective, foreign_key: true
      t.references :race, foreign_key: true
      t.integer :targeted_time
      t.integer :final_time
      t.string :status

      t.timestamps
    end
  end
end
