class AddBeginDateToTrainingPlans < ActiveRecord::Migration[5.2]
  def change
        add_column :training_plans, :begin_date, :date

  end
end
