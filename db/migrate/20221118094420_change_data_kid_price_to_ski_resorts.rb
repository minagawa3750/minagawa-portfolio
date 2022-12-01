class ChangeDataKidPriceToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :kid_price, :string
  end
end
