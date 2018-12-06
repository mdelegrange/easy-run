class AddTargetedDistanceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :targeted_distance, :integer
  end
end
