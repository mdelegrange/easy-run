class AddQuizCompletedToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :quiz_completed, :boolean, :default => false
  end
end
