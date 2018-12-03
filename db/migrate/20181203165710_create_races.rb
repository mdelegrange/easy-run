class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name
      t.date :date
      t.integer :distance
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :url
      t.date :limit_date

      t.timestamps
    end
  end
end
