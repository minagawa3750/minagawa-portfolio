require "rails_helper"

RSpec.describe SkiResort, type: :system do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let!(:ski_resort) { create(:ski_resort) }

  describe "SkiResort CRUD" do
    before do
      login_as(admin_user)
    end

    describe "ゲレンデ新規登録" do
      before do
        visit new_ski_resort_path 
      end
      
      context "フォームの入力値が正常" do
        it "ゲレンデの新規作成が成功" do
          attach_file "ski_resort[resort_image]", "#{Rails.root}/spec/fixtures/test.jpeg"
          fill_in "ski_resort[resort_name]", with: "resort"
          fill_in "ski_resort[address]", with: "栃木県那須塩原市湯本塩原字前黒"
          fill_in "ski_resort[phone_number]", with: "123-45-8910"
          fill_in "ski_resort[start_day]", with: "2023-01-01"
          fill_in "ski_resort[end_day]", with: "2023-03-31"
          fill_in "ski_resort[start_time]", with: "09:00"
          fill_in "ski_resort[end_time]", with: "16:00"
          fill_in "ski_resort[business_remarks]", with: "営業時間変動あり"
          fill_in "ski_resort[adult_price]", with: "¥4,000"
          fill_in "ski_resort[kid_price]", with: "¥3,000"
          fill_in "ski_resort[senior_price]", with: "¥2,000"
          fill_in "ski_resort[ski_lift]", with: "1"
          fill_in "ski_resort[courses]", with: "1"
          fill_in "ski_resort[maximum_tilt]", with: "1"
          fill_in "ski_resort[maximum_distance]", with: "1"
          fill_in "ski_resort[resort_feature]", with: "特徴"
          fill_in "ski_resort[introduction]", with: "ここがおすすめ"
          fill_in "ski_resort[hp_url]", with: "http"
          expect do
            click_button "登録する"
          end.to change(SkiResort, :count).by(1)
          expect(current_path).to eq ski_resorts_path
          expect(page).to have_content "ゲレンデの情報を登録しました。"
        end
      end

      context "ゲレンデ名が未記入" do
        it "ゲレンデの新規作成が失敗" do
          attach_file "ski_resort[resort_image]", "#{Rails.root}/spec/fixtures/test.jpeg"
          fill_in "ski_resort[resort_name]", with: nil
          fill_in "ski_resort[address]", with: "address"
          fill_in "ski_resort[phone_number]", with: "123-45-8910"
          fill_in "ski_resort[start_day]", with: "2023-01-21"
          fill_in "ski_resort[end_day]", with: "2023-03-05"
          fill_in "ski_resort[start_time]", with: "09:00"
          fill_in "ski_resort[end_time]", with: "16:00"
          fill_in "ski_resort[adult_price]", with: "¥4,000"
          fill_in "ski_resort[kid_price]", with: "¥3,000"
          fill_in "ski_resort[senior_price]", with: "¥2,000"
          fill_in "ski_resort[ski_lift]", with: "1"
          fill_in "ski_resort[courses]", with: "1"
          fill_in "ski_resort[maximum_tilt]", with: "1"
          fill_in "ski_resort[maximum_distance]", with: "1"
          fill_in "ski_resort[resort_feature]", with: "特徴"
          fill_in "ski_resort[introduction]", with: "ここがおすすめ"
          fill_in "ski_resort[hp_url]", with: "http"
          click_button "登録する"
          expect(current_path).to eq ski_resorts_path
        end
      end
    end

    describe "ゲレンデ編集" do
      before do
        visit edit_ski_resort_path(ski_resort.id)
      end

      context "フォームの入力値が正常" do
        it "ゲレンデの編集が成功" do
          attach_file "ski_resort[resort_image]", "#{Rails.root}/spec/fixtures/test.jpeg"
          fill_in "ski_resort[resort_name]", with: "ski_resort"
          fill_in "ski_resort[address]", with: "栃木県那須塩原市"
          fill_in "ski_resort[phone_number]", with: "123-45-8910"
          fill_in "ski_resort[start_day]", with: "2023-01-21"
          fill_in "ski_resort[end_day]", with: "2023-03-05"
          fill_in "ski_resort[start_time]", with: "09:00"
          fill_in "ski_resort[end_time]", with: "16:00"
          fill_in "ski_resort[adult_price]", with: "¥4,000"
          fill_in "ski_resort[kid_price]", with: "¥3,000"
          fill_in "ski_resort[senior_price]", with: "¥2,000"
          fill_in "ski_resort[ski_lift]", with: "1"
          fill_in "ski_resort[courses]", with: "1"
          fill_in "ski_resort[maximum_tilt]", with: "1"
          fill_in "ski_resort[maximum_distance]", with: "1"
          fill_in "ski_resort[resort_feature]", with: "特徴"
          fill_in "ski_resort[introduction]", with: "ここがおすすめ"
          fill_in "ski_resort[hp_url]", with: "http"
          click_button "更新する"
          expect(current_path).to eq ski_resort_path(ski_resort.id)
          expect(page).to have_content "ゲレンデの情報を更新しました。"
        end
      end

      context "営業開始日が営業終了日より日付が後" do
        it "ゲレンデの編集が失敗" do
          attach_file "ski_resort[resort_image]", "#{Rails.root}/spec/fixtures/test.jpeg"
          fill_in "ski_resort[resort_name]", with: "resort"
          fill_in "ski_resort[address]", with: "栃木県那須塩原市"
          fill_in "ski_resort[phone_number]", with: "123-45-8910"
          fill_in "ski_resort[start_day]", with: "2023/1/21"
          fill_in "ski_resort[end_day]", with: "2022/03/05"
          fill_in "ski_resort[start_time]", with: "09:00"
          fill_in "ski_resort[end_time]", with: "16:00"
          fill_in "ski_resort[adult_price]", with: "¥4,000"
          fill_in "ski_resort[kid_price]", with: "¥3,000"
          fill_in "ski_resort[senior_price]", with: "¥2,000"
          fill_in "ski_resort[ski_lift]", with: "1"
          fill_in "ski_resort[courses]", with: "1"
          fill_in "ski_resort[maximum_tilt]", with: "1"
          fill_in "ski_resort[maximum_distance]", with: "1"
          fill_in "ski_resort[resort_feature]", with: "特徴"
          fill_in "ski_resort[introduction]", with: "ここがおすすめ"
          fill_in "ski_resort[hp_url]", with: "http"
          click_button "更新する"
          expect(current_path).to eq ski_resort_path(ski_resort.id) 
        end
      end
    end

    describe "ゲレンデ削除", js:true do
      it "ゲレンデの削除が成功" do
        visit ski_resorts_path
        click_link "削除"
        expect(page.accept_confirm).to eq "削除します。よろしいですか。"
        expect(current_path).to eq ski_resorts_path
        expect(page).to have_content "ゲレンデの情報を削除しました。"
      end
    end
  end

  describe "SkiResort CRUDにアクセスするユーザーが管理者ではないとき" do
    before do
      login_as(user)
    end

    it "スキー場登録ページにアクセスした際はトップページに遷移すること" do
      visit new_ski_resort_path
      expect(current_path).to eq root_path
      expect(page).to have_content "このページは閲覧できません。"
    end

    it "スキー場編集ページにアクセスした際はトップページに遷移すること" do
      visit edit_ski_resort_path(ski_resort.id)
      expect(current_path).to eq root_path
      expect(page).to have_content "このページは閲覧できません。"
    end
  end

  describe "各リンクへのアクセス" do
    describe "スキー場詳細ページ下部リンク" do
      before do
        visit ski_resort_path(ski_resort.id)
      end

      it "スキー場詳細ページからトップページへ遷移できること" do
        click_on "トップページ"
        expect(current_path).to eq root_path
      end
      it "スキー場詳細ページから初心者Q&Aへ遷移できること" do
        click_on "初心者Q&Aはこちら!"
        expect(current_path).to eq page_path("question")
      end
    end

    describe "スキー場一覧ページからの遷移" do
      before do
        login_as(admin_user)
        visit ski_resorts_path
      end

      it "各詳細ページに遷移できること" do
        click_link "詳細"
        expect(current_path).to eq ski_resort_path(ski_resort.id)
      end
      it "各編集ページに遷移できること" do
        click_link "編集"
        expect(current_path).to eq edit_ski_resort_path(ski_resort.id)
      end
    end

    describe "reviewへのアクセス" do
      let!(:review) { create(:review) }

      before do
        login_as(review.user)
        visit ski_resort_path(review.ski_resort_id)
      end

      it "スキー場詳細ページから口コミ新規投稿へ遷移できること" do
        click_on "レビュー投稿はこちら"
        expect(current_path).to eq new_ski_resort_review_path(review.ski_resort_id)
      end

      it "スキー場詳細ページから口コミ詳細へアクセスできること" do
        click_link review.title
        expect(current_path).to eq ski_resort_review_path(review.ski_resort_id, review.id)
      end
    end
  end
end