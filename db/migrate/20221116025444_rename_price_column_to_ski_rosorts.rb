class RenamePriceColumnToSkiRosorts < ActiveRecord::Migration[6.1]
  def change
    rename_column :ski_resorts, :price, :adult_price
  end
end
