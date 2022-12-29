class ChangeDataPhoneNumberToSkiResorts < ActiveRecord::Migration[6.1]
  def change
    change_column :ski_resorts, :phone_number, :string
  end
end
