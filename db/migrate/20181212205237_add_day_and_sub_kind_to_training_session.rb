class AddDayAndSubKindToTrainingSession < ActiveRecord::Migration[5.2]
  def change
    add_column :training_sessions, :subkind, :string
    add_column :training_sessions, :day, :date
  end
end
