class ChangeDataAdultPriceToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :adult_price, :string
  end
end
