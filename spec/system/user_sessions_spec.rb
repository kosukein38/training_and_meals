require 'rails_helper'

RSpec.describe 'UserSessions' do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス(必須)', with: user.email
        fill_in 'パスワード(必須)', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_current_path user_path(user), ignore_query: true
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス(必須)', with: ''
        fill_in 'パスワード(必須)', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました（メールアドレスかパスワードが間違っています）'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        find_by_id('header-avatar').click
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end

    context 'サイドバーが表示される' do
      it 'ログイン後サイドバーが表示され、マイページへのリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_content 'マイページ'
      end

      it 'ログイン後サイドバーが表示され、新規筋トレ投稿のリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_content '新規筋トレ投稿'
      end

      it 'ログイン後サイドバーが表示され、新規食事投稿のリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_content '新規食事投稿'
      end
    end
  end
end
