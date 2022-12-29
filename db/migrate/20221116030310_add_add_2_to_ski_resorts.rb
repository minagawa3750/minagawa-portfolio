class AddAdd2ToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :kid_price, :integer
    add_column :ski_resorts, :senior_price, :integer
  end
end
