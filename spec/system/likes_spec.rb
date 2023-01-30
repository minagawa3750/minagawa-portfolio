require 'rails_helper'

RSpec.describe Like, type: :system do
  let!(:user) { create(:user) }
  let!(:ski_resort) { create(:ski_resort) }

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
      let!(:like) { create(:like) }

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

  describe "いいねボタンの表示" do
    context "ログイン前の場合" do
      it "スキー場詳細ページにいいねボタンを表示しないこと" do
        visit ski_resort_path(ski_resort.id)
        expect(page).to have_no_selector '#not-like-btn'
        expect(page).to have_no_selector '#like-btn'
      end
    end
    
    context "ゲストログインの場合" do
      let!(:guest) { create(:user, :guest) }

      it "スキー場詳細ページにいいねボタンを表示しないこと" do
        login_as(guest)
        visit ski_resort_path(ski_resort.id)
        expect(page).to have_no_selector '#not-like-btn'
        expect(page).to have_no_selector '#like-btn'
      end
    end
  end

  describe "いいね一覧" do
    context "ログインした場合" do
      let!(:like) { create(:like) }

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

      it "いいね一覧にゲレンデが追加されていること" do
        visit likes_user_path(like.user_id)
        expect(page).to have_selector "img[alt='ゲレンデ画像']"
        expect(page).to have_content like.ski_resort.resort_name
        expect(page).to have_content like.ski_resort.address
        expect(page).to have_content like.ski_resort.phone_number
        expect(page).to have_content "詳細"
      end

      it "詳細をクリックしたらスキー場詳細ページに遷移すること" do
        visit likes_user_path(like.user_id)
        click_link "詳細"
        expect(current_path).to eq ski_resort_path(like.ski_resort_id)
      end

      it "トップページに戻るをクリックしたらトップページに遷移すること" do
        visit likes_user_path(like.user_id)
        click_link "トップページに戻る"
        expect(current_path).to eq root_path
      end
    end

    context "ゲストユーザーがログインした場合" do
      let(:guest) { create(:user, :guest) }

      it "ゲストユーザーでログインした際はヘッダーにいいね一覧は表示しないこと" do
        login_as(guest)
        find(".navbar-toggler-icon").click
        expect(page).to have_no_content "いいね一覧"
      end
    end
  end
end