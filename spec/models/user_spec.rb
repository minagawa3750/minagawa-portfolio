require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アカウント登録' do
    let(:new_user) { build(:user) }

    it 'ユーザー名、メールアドレス、パスワード、パスワード(確認用)が存在すれば登録できること' do
      expect(new_user).to be_valid
    end
  end

  describe 'ユーザー名' do
    it 'ユーザー名がなければ無効な状態であること' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end
  end

  describe 'メールアドレス' do
    let!(:user) { create(:user, email: 'test@example.com') }

    it 'メールアドレスがなければ無効な状態であること' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスの値が不正な場合は登録できないこと' do
      user = User.new(email: 'test@example')
      user.valid?
      expect(user.errors[:email]).to include('は不正な値です')
    end

    it 'メールアドレスがすでに登録されている場合は登録できないこと' do
      user_2 = User.new(email: 'test@example.com')
      user_2.valid?
      expect(user_2.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'パスワード' do
    it 'パスワードがなければ無効な状態であること' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'パスワード(確認用)がなければ無効な状態であること' do
      user = User.new(password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include('を入力してください')
    end

    it 'パスワードが5文字以下であれば登録できないこと' do
      user = User.new(password: 'test1')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'パスワードとパスワード(確認用)が一致していなければ登録できないこと' do
      user = User.new(password: 'test11', password_confirmation: 'test21')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
  end
end
