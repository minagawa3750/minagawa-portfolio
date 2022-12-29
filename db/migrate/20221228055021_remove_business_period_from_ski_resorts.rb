class RemoveBusinessPeriodFromSkiResorts < ActiveRecord::Migration[6.1]
  def change
    remove_column :ski_resorts, :business_period, :string
  end
end
