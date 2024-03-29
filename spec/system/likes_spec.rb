require 'rails_helper'

RSpec.describe Like, type: :system do
  let!(:user) { create(:user) }
  let!(:ski_resort) { create(:ski_resort) }
  let!(:like) { create(:like) }
  
  describe "Likes #create,#destroy", js:true do
    describe "#create" do
      before do
        login_as(user)
        visit ski_resort_path(ski_resort.id)
      end

      it 'いいねする' do
        find('#not-like-btn').click
        expect(current_path).to eq ski_resort_path(ski_resort.id)
        expect(page).to have_content "いいねしました。"
        expect(page).to have_selector '#like-btn'
        expect(user.likes.count).to eq(1)
      end
    end

    describe "#destroy" do
      before do
        login_as(like.user)
        visit ski_resort_path(like.ski_resort_id)
      end

      it "いいねをはずす" do
        find('#like-btn').click
        expect(current_path).to eq ski_resort_path(like.ski_resort_id)
        expect(page).to have_content "いいねをはずしました。"
        expect(page).to have_selector '#not-like-btn'
        expect(like.user.likes.count).to eq(0)
      end
    end
  end

  describe "未ログインユーザー" do
    it "スキー場詳細ページにいいねボタンを表示しないこと" do
      visit ski_resort_path(ski_resort.id)
      expect(page).to have_no_selector '#not-like-btn'
      expect(page).to have_no_selector '#like-btn'
    end 
  end

  describe "いいね一覧" do
    before do
      login_as(like.user)
    end

    it "ヘッダーにいいね一覧が表示されていること" do
      find(".navbar-toggler-icon").click
      expect(page).to have_content "いいね一覧"
    end

    it "いいね一覧をクリックしたらユーザーのいいね一覧に遷移すること" do
      find(".navbar-toggler-icon").click
      click_link "いいね一覧"
      expect(current_path).to eq likes_user_path(like.user_id)
    end
    
    describe "いいね一覧ページ" do
      before do
        visit likes_user_path(like.user_id)
      end

      it "いいね一覧にゲレンデが追加されていること" do
        expect(page).to have_selector "img[alt='ゲレンデ画像']"
        expect(page).to have_content like.ski_resort.resort_name
        expect(page).to have_content like.ski_resort.reviews.average(:rate)
        expect(page).to have_content like.ski_resort.address
        expect(page).to have_content like.ski_resort.phone_number
      end
  
      it "画像をクリックしたらスキー場詳細ページに遷移すること" do
        click_link "ゲレンデ画像"
        expect(current_path).to eq ski_resort_path(like.ski_resort_id)
      end
  
      it "トップページに戻るをクリックしたらトップページに遷移すること" do
        click_link "トップページに戻る"
        expect(current_path).to eq root_path
      end
    end
  end
end