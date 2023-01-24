require "rails_helper"

RSpec.describe Review, type: :system do
  let(:review) { create(:review) }
  
  describe "Review CRUD", js:true do
    before do
      login_as(review.user)
    end

    describe "レビュー新規投稿" do
      before do
        visit new_ski_resort_review_path(review.ski_resort_id)
      end

      context "フォームの入力値が正常" do
        it "レビューの新規投稿が成功" do
          fill_in "review[title]", with: "たのしかった"
          find("#star").find("img[alt='4']").click
          fill_in "review[comment]", with: "たのしめました！"
          expect do
            click_button "投稿する"
          end.to change(Review, :count).by(1)
          expect(current_path).to eq ski_resort_path(review.ski_resort_id)
          expect(page).to have_content 'レビューを投稿しました。'
        end
      end

      context "タイトルが未記入" do
        it "レビューの新規投稿が失敗" do
          fill_in "review[title]", with: nil
          find("#star").find("img[alt='4']").click
          fill_in "review[comment]", with: "たのしめました！"
          click_button "投稿する"
          expect(current_path).to eq ski_resort_reviews_path(review.ski_resort_id)
        end
      end
    end
    
    describe "レビュー編集" do
      before do
        visit edit_ski_resort_review_path(review.ski_resort_id, review.id)
      end

      context "フォームの入力値が正常" do
        it "レビューの編集が成功" do
          fill_in "review[title]", with: "みんなとっても楽しんでました！"
          find("#star").find("img[alt='5']").click
          fill_in "review[comment]", with: "とっても楽しかったです！また行きたいです！"
          click_button "投稿する"
          expect(current_path).to eq ski_resort_review_path(review.ski_resort_id, review.id)
          expect(page).to have_content 'レビューを更新しました。'
        end
      end

      context "タイトルが未記入" do
        it "レビューの編集が失敗" do
          fill_in "review[title]", with: nil
          find("#star").find("img[alt='5']").click
          fill_in "review[comment]", with: "たのしめました！"
          click_button "投稿する"
          expect(current_path).to eq ski_resort_review_path(review.ski_resort_id, review.id)
        end
      end
    end

    describe "レビュー削除" do
      it "レビューの削除が成功" do
        visit ski_resort_review_path(review.ski_resort_id, review.id)
        click_link "レビューを削除する"
        expect(page.accept_confirm).to eq "削除します。よろしいですか。"
        expect(current_path).to eq ski_resort_path(review.ski_resort_id)
        expect(page).to have_content 'レビューを削除しました。'
      end
    end 
  end

  describe "スキー場詳細ページリンク" do
    before do
      login_as(review.user)
    end

    it "新規投稿ページからスキー場詳細ページに遷移できること" do
      visit new_ski_resort_review_path(review.ski_resort_id)
      click_on "スキー場詳細ページに戻る"
      expect(current_path).to eq ski_resort_path(review.ski_resort_id)
    end

    it "レビュー詳細ページからスキー場詳細ページに遷移できること" do
      visit ski_resort_review_path(review.ski_resort_id, review.id)
      click_on "スキー場詳細ページに戻る"
      expect(current_path).to eq ski_resort_path(review.ski_resort_id)
    end

    it "レビュー編集ページからスキー場詳細ページに遷移できること" do
      visit edit_ski_resort_review_path(review.ski_resort_id, review.id)
      click_on "スキー場詳細ページに戻る"
      expect(current_path).to eq ski_resort_path(review.ski_resort_id)
    end
  end

  describe "レビュー詳細ページのリンク" do
    let!(:review_1) { create(:review) } 
    let!(:review_2) { create(:review) }

    context "ログインしたユーザーが自身の投稿したレビュー詳細に遷移した場合" do
      before do
        login_as(review_1.user)
        visit ski_resort_review_path(review_1.ski_resort_id, review_1.id)
      end

      it "レビューを編集するが表示されていること" do
        expect(page).to have_content "レビューを編集する"
      end

      it "レビュー編集をクリックするとレビュー編集ページに遷移すること" do
        click_link "レビューを編集する"
        expect(current_path).to eq edit_ski_resort_review_path(review_1.ski_resort_id, review_1.id)
      end

      it "レビューを削除するが表示されていること" do
        expect(page).to have_content "レビューを削除する"
      end
    end

    context "ログインしたユーザーが他のユーザーが投稿したレビュー詳細に遷移した場合" do
      before do
        login_as(review_2.user)
        visit ski_resort_review_path(review_1.ski_resort_id, review_1.id)
      end

      it "レビューを編集するが表示されていないこと" do
        expect(page).to have_no_content "レビューを編集する"
      end

      it "レビューを削除するが表示されていないこと" do
        expect(page).to have_no_content "レビューを削除する"
      end
    end
  end
end
