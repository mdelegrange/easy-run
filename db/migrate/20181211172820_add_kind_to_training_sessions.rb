class AddKindToTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :training_sessions, :kind, :string
  end
end
