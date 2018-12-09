class AddPriceToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :price, :string
  end
end
