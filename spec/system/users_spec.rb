require "rails_helper"

RSpec.describe User, type: :system do
  let(:user) { create(:user) }

  describe "User CRUD" do
    describe "ログイン前" do
      describe "ユーザー新規登録" do
        context "フォームの入力値が正常" do
          it "ユーザーの新規作成が成功" do
            visit new_user_registration_path
            attach_file "user[image]", File.join(Rails.root, "spec/fixtures/user_test.jpeg")
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
            attach_file "user[image]", File.join(Rails.root, "spec/fixtures/user_test.jpeg")
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: nil
            fill_in "user[password]", with: "password"
            fill_in "user[password_confirmation]", with: "password"
            click_button "アカウント登録"
            expect(current_path).to eq users_path
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
            attach_file "user[image]", File.join(Rails.root, "spec/fixtures/user_test.jpeg")
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
            attach_file "user[image]", File.join(Rails.root, "spec/fixtures/user_test.jpeg")
            fill_in "user[name]", with: "user"
            fill_in "user[email]", with: "test@example.com"
            fill_in "user[password]", with: "aaabbbcccc"
            fill_in "user[password_confirmation]", with: "aaabbbcccc"
            fill_in "user[current_password]", with: nil
            click_button "更新"
            expect(current_path).to eq users_path
          end
        end
      end
      
      describe "ユーザー削除", js: true do
        it "ユーザーの削除が成功" do
          click_link "アカウント削除"
          expect(page.accept_confirm).to eq "本当によろしいですか？"
          expect(current_path).to eq root_path
          expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
        end
      end
    end
  end

  describe "#self.guest" do
    it "ゲストユーザーとしてログインできること" do
      visit root_path
      find(".navbar-toggler-icon").click
      click_link "ゲストログイン"
      expect(current_path).to eq root_path
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
    end
  end
end