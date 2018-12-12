class CleanupUsersAndTrainingSessions < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :level, :string
    add_column :users, :level, :string

    remove_column :training_sessions, :kind, :string
    add_column :training_sessions, :kind, :string
  end
end
