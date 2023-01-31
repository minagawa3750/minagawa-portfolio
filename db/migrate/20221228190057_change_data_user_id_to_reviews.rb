class ChangeDataUserIdToReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :user_id, :integer
  end
end
