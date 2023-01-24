class ChangeDataSkiLiftToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :ski_lift, :integer
  end
end
