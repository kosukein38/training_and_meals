require 'rails_helper'

RSpec.describe 'Profiles', js: true do
  let!(:user) { create(:user) }

  it 'プロフィール登録すると、プロフィール表示画面に遷移し、情報が表示されること' do
    login_as(user)
    visit edit_profile_path
    fill_in '身長', with: user.height
    fill_in '体重', with: user.body_weight
    fill_in '年齢', with: user.age
    select '男性', from: '生まれた時の性別'
    select 'レベル1', from: '活動量'
    click_button '更新する'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(page).to have_current_path profile_path, ignore_query: true
  end

  it 'プロフィールの退会するボタンをクリックすると確認メッセージが表示されてからユーザーが削除されること' do
    login_as(user)
    visit profile_path
    page.accept_confirm do
      click_on '退会する'
    end
    expect(page).to have_content '退会しました'
    expect(page).to have_content 'ログイン'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  it 'プロフィールにアバター画像を設定できること' do
    login_as(user)
    visit edit_profile_path
    fill_in '身長', with: user.height
    fill_in '体重', with: user.body_weight
    fill_in '年齢', with: user.age
    select '男性', from: '生まれた時の性別'
    select 'レベル1', from: '活動量'
    attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/images/sample_man.png"
    click_button '更新する'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(page).to have_selector("img[src$='sample_man.png']")
    expect(page).to have_current_path profile_path, ignore_query: true
  end

  it '未ログインではプロフィールの編集ができないこと' do
    visit edit_profile_path
    expect(page).to have_content 'ログインしてください'
    expect(page).to have_current_path login_path, ignore_query: true
  end
end
