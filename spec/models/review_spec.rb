require "rails_helper"

RSpec.describe Review, type: :model do

  describe "タイトル" do
    it "タイトルがなければ無効な状態であること" do
      review = Review.new(title: nil)
      review.valid?
      expect(review.errors[:title]).to include("を入力してください")
    end

    it "タイトルが16文字以上のときは無効な状態であること" do
      review = Review.new(title: "あああああああああああああああa")
      review.valid?
      expect(review.errors[:title]).to include("は15文字以内で入力してください")
    end
  end
  
  describe "評価" do
    it "評価がなければ無効な状態であること" do
      review = Review.new(rate: nil)
      review.valid?
      expect(review.errors[:rate]).to include("を入力してください")
    end
  end
  
  describe "コメント" do
    it "コメントがなければ無効な状態であること" do
      review = Review.new(comment: nil)
      review.valid?
      expect(review.errors[:comment]).to include("を入力してください")
    end
  end

  describe "user_id" do
    it "user_idがなければ無効な状態であること" do
      review = Review.new(user_id: nil)
      review.valid?
      expect(review.errors[:user]).to include("を入力してください")
    end
  end

  describe "ski_resort_id" do
    it "ski_resort_idがなければ無効な状態であること" do
      review = Review.new(ski_resort_id: nil)
      review.valid?
      expect(review.errors[:ski_resort]).to include("を入力してください")
    end
  end
end