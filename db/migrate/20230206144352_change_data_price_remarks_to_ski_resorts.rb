class ChangeDataPriceRemarksToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :price_remarks, :text
  end
end
