require 'rails_helper'

RSpec.describe 'Users' do
  let(:user) { create(:user) }

  describe 'ユーザー新規登録' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit new_user_path
        fill_in '名前(必須)', with: 'Example'
        fill_in 'メールアドレス(必須)', with: 'email@example.com'
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録が完了しました'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context '名前が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in '名前(必須)', with: ''
        fill_in 'メールアドレス(必須)', with: 'example@example.com'
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content '名前(必須)を入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in '名前', with: 'Example'
        fill_in 'メールアドレス(必須)', with: ''
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレス(必須)を入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context 'パスワードが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in '名前(必須)', with: 'Example'
        fill_in 'メールアドレス(必須)', with: 'example@example.com'
        fill_in 'パスワード(必須)', with: ''
        fill_in '確認用パスワード(必須)', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'パスワード(必須)は3文字以上で入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context 'パスワード（確認用）が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in '名前(必須)', with: 'Example'
        fill_in 'メールアドレス(必須)', with: 'example@example.com'
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: ''
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content '確認用パスワード(必須)を入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        existed_user = create(:user)
        visit new_user_path
        fill_in '名前(必須)', with: 'Example'
        fill_in 'メールアドレス(必須)', with: existed_user.email
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレス(必須)はすでに存在します'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context 'パスワードが不一致' do
      it 'ユーザーの新規作成が失敗する' do
        existed_user = create(:user)
        visit new_user_path
        fill_in '名前(必須)', with: 'Example'
        fill_in 'メールアドレス(必須)', with: existed_user.email
        fill_in 'パスワード(必須)', with: 'password'
        fill_in '確認用パスワード(必須)', with: 'foobar'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content '確認用パスワード(必須)とパスワード(必須)の入力が一致しません'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end
  end
end
