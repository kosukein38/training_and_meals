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
      expect(user.errors[:name]).to include('を入力してください')
    end

    it '名前が31字以上では無効であること' do
      user = build(:user, name: ('a' * 31).to_s)
      user.valid?
      expect(user.errors[:name]).to include('は30文字以内で入力してください')
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'パスワードが2文字では無効な状態であること' do
      user = build(:user, password: 'fo')
      user.valid?
      expect(user.errors[:password]).to include('は3文字以上で入力してください')
    end

    it 'パスワードが3文字あれば有効な状態であること' do
      user = build(:user, password: 'foo')
      user.valid?
      expect(user.errors[:password]).not_to include('iは3文字以上で入力してください')
    end

    it '重複するメールアドレスは無効であること' do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include('はすでに存在します')
    end

    it '身長が未入力では更新できないこと' do
      user = create(:user)
      user.height = ''
      user.valid?
      expect(user.errors[:height]).to include('を入力してください')
    end

    it '体重が未入力では更新できないこと' do
      user = create(:user)
      user.body_weight = ''
      user.valid?
      expect(user.errors[:body_weight]).to include('を入力してください')
    end

    it '年齢が未入力では更新できないこと' do
      user = create(:user)
      user.age = ''
      user.valid?
      expect(user.errors[:age]).to include('を入力してください')
    end

    it '性別が未入力では更新できないこと' do
      user = create(:user)
      user.sex = ''
      user.valid?
      expect(user.errors[:sex]).to include('を入力してください')
    end

    it '活動レベルが未入力では更新できないこと' do
      user = create(:user)
      user.active_level = ''
      user.valid?
      expect(user.errors[:active_level]).to include('を入力してください')
    end
  end
end
