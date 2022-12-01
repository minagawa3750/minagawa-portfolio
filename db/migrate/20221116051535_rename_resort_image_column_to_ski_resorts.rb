class RenameResortImageColumnToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    rename_column :ski_resorts, :resort_image, :image
  end
end
