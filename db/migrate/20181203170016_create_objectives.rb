class CreateObjectives < ActiveRecord::Migration[5.2]
  def change
    create_table :objectives do |t|
      t.references :user, foreign_key: true
      t.references :race, foreign_key: true
      t.string :kind
      t.integer :duration
      t.integer :distance
      t.string :status

      t.timestamps
    end
  end
end
