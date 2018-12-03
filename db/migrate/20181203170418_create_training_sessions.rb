class CreateTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :training_sessions do |t|
      t.references :training_plan, foreign_key: true
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
