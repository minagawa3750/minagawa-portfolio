require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '気になる機能' do
    context 'いいねできる場合' do
      let!(:like) { build(:like) }
      
      it "user_idとski_resort_idがあれば保存できる" do
        expect(like).to be_valid
      end
      
      context "user_idが違う場合" do
        let!(:other_like) { create(:like) }

        it "ski_resort_idが同じでもuser_idが違えばいいねできる" do 
          expect(FactoryBot.create(:like, user_id: other_like.user_id)).to be_valid
        end
      end
      
      context "ski_resort_idが違う場合" do
        let!(:other_like_2) { create(:like) }

        it "user_idが同じでもski_resort_idが違えばいいねできる" do
          expect(FactoryBot.create(:like, ski_resort_id: other_like_2.ski_resort_id)).to be_valid
        end
      end
    end

    context 'いいねできない場合' do
      it "user_idがなければ無効な状態であること" do
        like = Like.new(user_id: nil)
        like.valid?
        expect(like.errors[:user]).to include("を入力してください")
      end

      it "ski_resort_idがなければ無効な状態であること" do
        like = Like.new(ski_resort_id: nil)
        like.valid?
        expect(like.errors[:ski_resort]).to include("を入力してください")
      end
    end
  end
end
