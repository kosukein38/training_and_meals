require 'rails_helper'

RSpec.describe 'Profiles', js: true do
  let!(:user) { create(:user) }

  it 'プロフィール登録すると、プロフィール表示画面に遷移し、情報が表示されること' do
    login_as(user)
    visit edit_profile_path
    fill_in '名前(必須)', with: user.name
    fill_in 'メールアドレス(必須)', with: user.email
    fill_in '身長(必須)', with: user.height
    fill_in '体重(必須)', with: user.body_weight
    fill_in '年齢(必須)', with: user.age
    select '男性', from: '生まれた時の性別(必須)'
    select 'レベル1', from: '活動量(必須)'
    click_button '更新する'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(page).to have_current_path profile_path, ignore_query: true
  end

  it 'プロフィールの退会するボタンをクリックすると確認メッセージが表示されてからユーザーが削除されること' do
    login_as(user)
    visit profile_path
    page.accept_confirm do
      click_button '退会する'
    end
    expect(page).to have_content '退会しました'
    expect(page).to have_content 'ログイン'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  it 'プロフィールにアバター画像(.png)を設定できること' do
    login_as(user)
    visit edit_profile_path
    attach_file 'user[avatar]', Rails.root.join('spec/fixtures/images/sample_man.png')
    click_button '更新する'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(page).to have_selector("img[src$='sample_man.png']")
    expect(page).to have_current_path profile_path, ignore_query: true
  end

  it 'アバター画像にpng,jpeg,jpg以外の拡張子ファイルを設定できないこと' do
    login_as(user)
    visit edit_profile_path
    attach_file 'user[avatar]', Rails.root.join('spec/fixtures/error.txt')
    click_button '更新する'
    expect(page).to have_content '更新できませんでした'
    expect(page).to have_content 'は対応できないファイル形式です'
    expect(page).to have_current_path edit_profile_path, ignore_query: true
  end

  it 'アバター画像に5MB以上のファイルを設定できないこと' do
    login_as(user)
    visit edit_profile_path
    attach_file 'user[avatar]', Rails.root.join('spec/fixtures/images/large_image.png')
    click_button '更新する'
    expect(page).to have_content '更新できませんでした'
    expect(page).to have_content '5MB以下にしてください'
    expect(page).to have_current_path edit_profile_path, ignore_query: true
  end

  it '未ログインではプロフィールの編集ができないこと' do
    visit edit_profile_path
    expect(page).to have_content 'ログインしてください'
    expect(page).to have_current_path login_path, ignore_query: true
  end
end
