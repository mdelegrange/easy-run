class ChangeDayToWeekToTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    remove_column :training_sessions, :day, :date
    add_column :training_sessions, :week, :integer
  end
end
