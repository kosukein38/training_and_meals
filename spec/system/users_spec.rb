require 'rails_helper'

RSpec.describe 'Users' do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  describe 'ユーザー新規登録' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit new_user_path
        fill_in 'Name', with: 'Example'
        fill_in 'Email', with: 'email@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button '登録する'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'Name', with: 'Example'
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button '登録する'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        existed_user = create(:user)
        visit new_user_path
        fill_in 'Name', with: 'Example'
        fill_in 'Email', with: existed_user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button '登録する'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end
  end
end
