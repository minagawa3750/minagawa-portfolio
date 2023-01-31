require "rails_helper"

RSpec.describe SkiResort, type: :system do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let!(:ski_resort) { create(:ski_resort) }

  describe "SkiResort CRUD" do
    describe "管理者ユーザーがログイン" do
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
            expect(page).to have_content "ゲレンデ名を入力してください"
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
            expect(page).to have_content "営業終了日は営業開始日以降のものを選択してください"
          end
        end
      end

      describe "ゲレンデ削除", js:true do
        it "ゲレンデの削除が成功" do
          visit ski_resorts_path
          click_link "削除"
          expect do
            expect(page.accept_confirm).to eq "削除します。よろしいですか。"
            expect(current_path).to eq ski_resorts_path
            expect(page).to have_content "ゲレンデの情報を削除しました。"
          end.to change(SkiResort, :count).by(-1)  
        end
      end
    end

    describe "一般ユーザーがログイン" do
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
  end
  
  describe "スキー場一覧ページ" do
    before do
      login_as(admin_user)
      visit ski_resorts_path
    end

    it "登録したスキー場が表示されていること" do
      expect(page).to have_selector "img[alt='ゲレンデ画像']"
      expect(page).to have_content ski_resort.resort_name
      expect(page).to have_content ski_resort.address
      expect(page).to have_content ski_resort.resort_name
      expect(page).to have_content "詳細"
      expect(page).to have_content "編集"
      expect(page).to have_content "削除"
    end

    it "詳細をクリックしたらスキー場詳細に遷移すること" do
      click_link "詳細"
      expect(current_path).to eq ski_resort_path(ski_resort.id)
    end

    it "編集をクリックしたらスキー場編集ページに遷移すること" do
      click_link "編集"
      expect(current_path).to eq edit_ski_resort_path(ski_resort.id)
    end

    it "削除をクリックしたらスキー場を削除できること", js:true do
      click_link "削除"
      expect do
        expect(page.accept_confirm).to eq "削除します。よろしいですか。"
        expect(current_path).to eq ski_resorts_path
        expect(page).to have_content "ゲレンデの情報を削除しました。"
      end.to change(SkiResort, :count).by(-1)  
    end

    it "トップページに戻るをクリックしたらトップページに遷移すること" do
      click_link "トップページに戻る"
      expect(current_path).to eq root_path
    end
  end
  describe "スキー場詳細ページ" do
    before do
      visit ski_resort_path(ski_resort.id)
    end

    it "ゲレンデ画像が表示されていること" do
      expect(page).to have_selector "img[alt='ゲレンデ画像']"
    end

    it "ゲレンデ名が表示されていること" do
      expect(page).to have_content ski_resort.resort_name
    end

    it "住所が表示されていること" do
      expect(page).to have_content ski_resort.address
    end

    it "電話番号が表示されていること" do
      expect(page).to have_content ski_resort.phone_number
    end

    it "営業開始日が表示されていること" do
      expect(page).to have_content ski_resort.start_day.to_s(:date_jp)
    end

    it "営業終了日が表示されていること" do
      expect(page).to have_content ski_resort.end_day.to_s(:date_jp)
    end

    it "営業開始時間が表示されていること" do
      expect(page).to have_content ski_resort.start_time.to_s(:time_jp)
    end

    it "営業終了時間が表示されていること" do
      expect(page).to have_content ski_resort.end_time.to_s(:time_jp)
    end

    it "営業備考が表示されていること" do
      expect(page).to have_content ski_resort.business_remarks
    end

    it "おとな料金が表示されていること" do
      expect(page).to have_content ski_resort.adult_price
    end

    it "こども料金が表示されていること" do
      expect(page).to have_content ski_resort.kid_price
    end

    it "シニア料金が表示されていること" do
      expect(page).to have_content ski_resort.senior_price
    end

    it "リフト数が表示されていること" do
      expect(page).to have_content ski_resort.ski_lift
    end

    it "コース数が表示されていること" do
      expect(page).to have_content ski_resort.courses
    end

    it "最大傾斜が表示されていること" do
      expect(page).to have_content ski_resort.maximum_tilt
    end

    it "最大滑走距離が表示されていること" do
      expect(page).to have_content ski_resort.maximum_distance
    end

    it "特徴が表示されていること" do
      expect(page).to have_content ski_resort.resort_feature
    end

    it "ここがおすすめが表示されていること" do
      expect(page).to have_content ski_resort.introduction
    end

    it "ホームページはこちら！が表示されていること" do
      expect(page).to have_content "ホームページはこちら！"
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

    describe "スキー場詳細のレビュー一覧" do
      let!(:review) { create(:review) }

      before do
        visit ski_resort_path(review.ski_resort_id)
      end

      describe "レビュー一覧の表示" do
        it "ユーザー画像が表示されていること" do
          expect(page).to have_selector "img[alt='ユーザー画像']"
        end

        it "ユーザー名が表示されていること" do
          expect(page).to have_content review.user.name
        end

        it "レビュー日が表示されていること" do
          expect(page).to have_content review.created_at.to_s(:date2_jp)
        end

        it "評価が表示されていること" do
          expect(page).to have_content review.rate
        end

        it "タイトルが表示されていること" do
          expect(page).to have_content review.title
        end
      end

      describe "レビュー詳細ページ" do
        it "スキー場詳細ページからレビュー詳細へアクセスできること" do
          click_link review.title
          expect(current_path).to eq ski_resort_review_path(review.ski_resort_id, review.id)
        end
      end
      
      describe "レビュー投稿" do
        context "ログインしている場合" do
          before do
            login_as(review.user)
            visit ski_resort_path(review.ski_resort_id)
          end

          it "スキー場詳細ページからレビュー新規投稿へ遷移できること" do
            click_on "レビュー投稿はこちら"
            expect(current_path).to eq new_ski_resort_review_path(review.ski_resort_id)
          end
        end

        context "ログインしていない場合" do
          it "スキー場詳細ページからレビュー新規投稿へアクセスした際はログイン画面に遷移すること" do
            click_on "レビュー投稿はこちら"
            expect(current_path).to eq new_user_session_path
            expect(page).to have_content "ログインもしくはアカウント登録してください。"
          end
        end
      end
    end
  end
  
  describe "#search" do
    let!(:result) { create(:review) }

    describe "スキー場検索" do
      it "トップページの検索フォームからスキー場検索ができること" do
        visit root_path
        fill_in 'q[resort_name_or_address_or_resort_feature_or_introduction_cont]', with: '栃木県'
        click_button '検索'
        expect(current_path).to eq search_ski_resorts_path
        expect(page).to have_selector "img[alt='ゲレンデ画像']"
        expect(page).to have_content result.ski_resort.resort_name
        expect(page).to have_content result.rate
        expect(page).to have_content result.ski_resort.address
        expect(page).to have_content result.ski_resort.phone_number
      end
    end

    describe "スキー場検索結果ページ" do
      before do
        visit search_ski_resorts_path
      end

      it "検索結果の画像にアクセスするとゲレンデ詳細画面に遷移すること" do
        click_link "ゲレンデ画像", match: :first
        expect(current_path).to eq ski_resort_path(ski_resort.id)
      end

      it "トップページに戻るをクリックしたらトップページに遷移すること" do
        click_link "トップページに戻る" 
        expect(current_path). to eq root_path
      end
    end
  end

  describe "#liked?(user)" do
    let!(:like) { create(:like) }

    before do
      login_as(like.user)
    end

    context "ログインしたユーザーがいいねしたスキー場詳細ページに遷移した場合" do
      it "#like-btnが表示されていること" do
        visit ski_resort_path(like.ski_resort_id)
        expect(page).to have_selector '#like-btn'
      end
    end

    context "ログインしたユーザーがいいねしていないスキー場詳細ページに遷移した場合" do
      it "#not-like-btnが表示されていること" do
        visit ski_resort_path(ski_resort.id)
        expect(page).to have_selector '#not-like-btn'
      end
    end
  end
end