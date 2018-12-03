class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.references :user, foreign_key: true
      t.references :training_plan, foreign_key: true
      t.date :begin_date
      t.string :status

      t.timestamps
    end
  end
end
