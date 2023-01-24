require "rails_helper"

RSpec.describe Review, type: :model do
  it "タイトルがなければ無効な状態であること" do
    review = Review.new(title: nil)
    review.valid?
    expect(review.errors[:title]).to include("を入力してください")
  end

  it "評価がなければ無効な状態であること" do
    review = Review.new(rate: nil)
    review.valid?
    expect(review.errors[:rate]).to include("を入力してください")
  end

  it "コメントがなければ無効な状態であること" do
    review = Review.new(comment: nil)
    review.valid?
    expect(review.errors[:comment]).to include("を入力してください")
  end
end