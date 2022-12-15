class RenameBusinessHoursColumnToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    rename_column :ski_resorts, :business_hours, :business_remarks
  end
end
