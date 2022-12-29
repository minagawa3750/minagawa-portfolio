class AddLatitudeToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :latitude, :float
  end
end
