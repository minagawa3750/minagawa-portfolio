class ChangeDatatypeMaximumTiltOfSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :maximum_tilt, :integer
  end
end
