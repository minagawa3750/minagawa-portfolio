class ChangeInterestsToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_table :interests, :likes
  end
end
