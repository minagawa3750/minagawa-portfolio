class AddAddToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    add_column :ski_resorts, :price, :integer
    add_column :ski_resorts, :introduction, :text
  end
end
