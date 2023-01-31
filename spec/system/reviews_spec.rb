require "rails_helper"

RSpec.describe Review, type: :system do
  let!(:review) { create(:review) }

  describe "Review CRUD", js:true do
    describe "レビュー新規投稿" do
      let!(:user) { create(:user) }
      let!(:ski_resort) { create(:ski_resort) }

      before do
        login_as(user)
        visit new_ski_resort_review_path(ski_resort.id)
      end

      context "フォームの入力値が正常" do
        it "レビューの新規投稿が成功" do
          fill_in "review[title]", with: "たのしかった"
          find("#star").find("img[alt='4']").click
          fill_in "review[comment]", with: "たのしめました！"
          expect do
            click_button "投稿する"
          end.to change(Review, :count).by(1)
          expect(current_path).to eq ski_resort_path(ski_resort.id)
          expect(page).to have_content 'レビューを投稿しました。'
        end
      end

      context "タイトルが未記入" do
        it "レビューの新規投稿が失敗" do
          fill_in "review[title]", with: nil
          find("#star").find("img[alt='4']").click
          fill_in "review[comment]", with: "たのしめました！"
          click_button "投稿する"
          expect(current_path).to eq ski_resort_reviews_path(ski_resort.id)
          expect(page).to have_content "タイトルを入力してください"
        end
      end
    end
    
    describe "レビュー編集と削除" do
      before do
        login_as(review.user)
        visit edit_ski_resort_review_path(review.ski_resort_id, review.id)
      end

      describe "レビュー編集" do
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
            expect(page).to have_content "タイトルを入力してください"
          end
        end
      end

      describe "レビュー削除" do
        it "レビューの削除が成功" do
          click_link "レビューを削除する"
          expect do
            expect(page.accept_confirm).to eq "削除します。よろしいですか。"
            expect(current_path).to eq ski_resort_path(review.ski_resort_id)
            expect(page).to have_content "レビューを削除しました。"
          end.to change(Review, :count).by(-1)
        end
      end 
    end
  end

  describe "レビュー詳細ページ" do
    before do
      login_as(review.user)
      visit ski_resort_review_path(review.ski_resort_id, review.id)
    end

    it "ゲレンデ名が表示されていること" do
      expect(page).to have_content review.ski_resort.resort_name
    end

    it "評価が表示されていること" do
      expect(page).to have_content review.rate
    end

    it "タイトルが表示されていること" do
      expect(page).to have_content review.title
    end

    it "コメントが表示されていること" do
      expect(page).to have_content review.comment
    end

    it "ユーザー画像が表示されていること" do
      expect(page).to have_selector "img[alt='ユーザー画像']"
    end

    it "ユーザー名が表示されていること" do
      expect(page).to have_content review.user.name
    end

    it "レビュー日が表示されていること" do
      expect(page).to have_content review.created_at.to_s(:date2_jp)
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

      it "レビュー削除ができること", js:true do
        click_link "レビューを削除する"
        expect do
          expect(page.accept_confirm).to eq "削除します。よろしいですか。"
          expect(current_path).to eq ski_resort_path(review_1.ski_resort_id)
          expect(page).to have_content "レビューを削除しました。"
        end.to change(Review, :count).by(-1)
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

      it "レビュー編集に遷移しようとした場合、スキー場詳細ページに遷移すること" do
        visit edit_ski_resort_review_path(review_1.ski_resort_id, review_1.id)
        expect(current_path).to eq ski_resort_path(review_1.ski_resort_id)
        expect(page).to have_content "このページは閲覧できません。"
      end
    end
  end
end
