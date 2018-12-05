class AddAttributesToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :event_name, :string
    add_column :races, :department, :integer
  end
end
