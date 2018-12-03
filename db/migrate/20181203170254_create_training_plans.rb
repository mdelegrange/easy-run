class CreateTrainingPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :training_plans do |t|
      t.string :name
      t.integer :sessions_per_week

      t.timestamps
    end
  end
end
