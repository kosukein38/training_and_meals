require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    it '名前、メール、パスワードがあれば有効な状態であること' do
      user = create(:user)
      expect(user).to be_valid
    end

    it '名前がなければ無効な状態であること' do
      user = build(:user, name: '')
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'パスワードが2文字では無効な状態であること' do
      user = build(:user, password: 'fo')
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 3 characters)')
    end

    it 'パスワードが3文字あれば有効な状態であること' do
      user = build(:user, password: 'foo')
      user.valid?
      expect(user.errors[:password]).not_to include('is too short (minimum is 3 characters)')
    end

    it '重複するメールアドレスは無効であること' do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include('has already been taken')
    end
  end
end
