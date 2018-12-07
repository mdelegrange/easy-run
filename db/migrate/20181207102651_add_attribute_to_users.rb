class AddAttributeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_already_run, :string
  end
end
