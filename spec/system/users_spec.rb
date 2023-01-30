require "rails_helper"

RSpec.describe User, type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }

  describe "User CRUD" do
    describe "ログイン前" do
      describe "ユーザー新規登録" do
        context "フォームの入力値が正常" do
          it "ユーザーの新規作成が成功" do
            visit new_user_registration_path
            attach_file 'user[image]', "#{Rails.root}/spec/fixtures/user_test.jpeg"
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: "test@example.com"
            fill_in "user[password]", with: "password"
            fill_in "user[password_confirmation]", with: "password"
            expect do
              click_button "アカウント登録"
            end.to change(User, :count).by(1)
            expect(current_path).to eq root_path
            expect(page).to have_content "アカウント登録が完了しました。"
          end
        end
        context "メールアドレス未記入" do
          it "ユーザーの新規作成が失敗" do
            visit new_user_registration_path
            attach_file 'user[image]', "#{Rails.root}/spec/fixtures/user_test.jpeg"
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: nil
            fill_in "user[password]", with: "password"
            fill_in "user[password_confirmation]", with: "password"
            click_button "アカウント登録"
            expect(current_path).to eq users_path
            expect(page).to have_content "メールアドレスを入力してください"
          end
        end
      end
    end

    describe "ログイン後" do
      before do
        login_as(user)
        visit edit_user_registration_path
      end

      describe "ユーザー編集" do
        context "フォームの入力値が正常" do
          it "ユーザーの編集が成功" do
            attach_file 'user[image]', "#{Rails.root}/spec/fixtures/user_test.jpeg"
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: "test@example.com"
            fill_in "user[password]", with: "aaabbbcccc"
            fill_in "user[password_confirmation]", with: "aaabbbcccc"
            fill_in "user[current_password]", with: "password"
            click_button "更新"
            expect(current_path).to eq root_path
            expect(page).to have_content "アカウント情報を変更しました。"
          end
        end
        
        context "現在のパスワードが未記入" do
          it "ユーザーの編集が失敗" do
            attach_file 'user[image]', "#{Rails.root}/spec/fixtures/user_test.jpeg"
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: "test@example.com"
            fill_in "user[password]", with: "aaabbbcccc"
            fill_in "user[password_confirmation]", with: "aaabbbcccc"
            fill_in "user[current_password]", with: nil
            click_button "更新"
            expect(current_path).to eq users_path
            expect(page).to have_content "現在のパスワードを入力してください"
          end
        end
      end

      describe "ユーザー削除", js: true do
        it "ユーザーの削除が成功" do
          click_link "アカウント削除"
          expect do
            expect(page.accept_confirm).to eq "本当によろしいですか？"
            expect(current_path).to eq root_path
            expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
          end.to change(User, :count).by(-1)
        end
      end
    end
  end

  describe "#self.guest" do
    let!(:guest) { create(:user, :guest) }

    it "ゲストユーザーとしてログインできること" do
      visit root_path
      find(".navbar-toggler-icon").click
      click_link "ゲストログイン"
      expect(current_path).to eq root_path
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
    end

    it "ゲストユーザーとしてログインした際はヘッダーにアカウント編集が表示されていないこと" do
      login_as(guest)
      find(".navbar-toggler-icon").click
      expect(page).to have_no_content "アカウント編集"
    end
  end

  describe "スキー場一覧" do
    context "管理者ユーザーがログインした場合" do
      before do
        login_as(admin_user)
      end

      it "ヘッダーメニューにスキー場一覧が表示されていること" do
        find(".navbar-toggler-icon").click
        expect(page).to have_content "スキー場一覧"
      end

      it "クリックしたらスキー場一覧に遷移すること" do
        find(".navbar-toggler-icon").click
        click_link "スキー場一覧"
        expect(current_path).to eq ski_resorts_path        
      end
    end

    context "一般ユーザーがログインした場合" do
      it "ヘッダーメニューにスキー場一覧が表示されていないこと" do
        login_as(user)
        find(".navbar-toggler-icon").click
        expect(page).to have_no_content "スキー場一覧"
      end
    end
  end
  
  describe "ログアウト" do
    it "ヘッダーメニューのログアウトをクリックしたらログアウトできること" do
      login_as(user)
      find(".navbar-toggler-icon").click
      click_link "ログアウト"
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました。"
    end
  end
end