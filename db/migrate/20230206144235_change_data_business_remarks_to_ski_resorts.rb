class ChangeDataBusinessRemarksToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :business_remarks, :text
  end
end
