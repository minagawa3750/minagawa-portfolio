class AddSkiResortIdToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :ski_resort, null: false, foreign_key: true
  end
end
