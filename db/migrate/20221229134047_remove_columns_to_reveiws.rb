class RemoveColumnsToReveiws < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :ski_resort_id, :integer
    remove_column :reviews, :user_id, :integer
  end
end
