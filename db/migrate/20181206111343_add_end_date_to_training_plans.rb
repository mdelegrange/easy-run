class AddEndDateToTrainingPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :training_plans, :end_date, :date
  end
end
