class RemoveImageFromSkiResorts < ActiveRecord::Migration[6.1]
  def change
    remove_column :ski_resorts, :image, :string
  end
end
