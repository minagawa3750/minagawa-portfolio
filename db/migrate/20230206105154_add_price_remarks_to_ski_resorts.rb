class AddPriceRemarksToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :price_remarks, :string
  end
end
