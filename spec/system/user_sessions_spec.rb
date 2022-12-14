require 'rails_helper'

RSpec.describe 'UserSessions' do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_current_path profile_path, ignore_query: true
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
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
        find('.dropdown').click
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end

    context 'サイドバーが表示される' do
      it 'ログイン後サイドバーが表示され、マイページへのリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_link 'マイページ'
      end

      it 'ログイン後サイドバーが表示され、タイムラインのリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_link 'タイムライン'
      end

      it 'ログイン後サイドバーが表示され、お気に入りのリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_link 'お気に入り'
      end

      it 'ログイン後サイドバーが表示され、下書き一覧のリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_link '下書き一覧'
      end

      it 'ログイン後サイドバーが表示され、フォロー/フォロワーのリンクがあること' do
        login_as(user)
        visit profile_path
        expect(page).to have_link 'フォロー/フォロワー'
      end
    end
  end
end
