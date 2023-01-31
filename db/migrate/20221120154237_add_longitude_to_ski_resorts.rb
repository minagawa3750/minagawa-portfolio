class AddLongitudeToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :longitude, :float
  end
end
