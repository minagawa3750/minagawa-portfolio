class AddColumnsToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :maximum_tilt, :integer
    add_column :ski_resorts, :maximum_distance, :integer
  end
end
