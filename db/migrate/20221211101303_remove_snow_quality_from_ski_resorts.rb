class RemoveSnowQualityFromSkiResorts < ActiveRecord::Migration[6.1]
  def change
    remove_column :ski_resorts, :snow_quality, :string
  end
end
