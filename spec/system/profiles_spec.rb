require 'rails_helper'

RSpec.describe 'Profiles' do
  let(:user) { create(:user) }

  it 'プロフィール登録するすると、メンテナンスカロリーと目標カロリーが登録され、表示されること' do
    login_as(user)
    visit edit_profile_path
    fill_in '身長', with: user.height
    fill_in '体重', with: user.body_weight
    fill_in '年齢', with: user.age
    select '男性', from: '生まれた時の性別'
    select 'レベル1', from: '活動量'
    click_button '計算する'
    expect(page).to have_content 'あなたの目標摂取カロリーは１日あたり'
    expect(page).to have_current_path edit_profile_path, ignore_query: true
  end

  it 'サイドバーの投稿一覧をクリックすると投稿一覧画面に遷移すること' do
    login_as(user)
    visit profile_path
    click_link '投稿一覧'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end

  it 'サイドバーのタイムラインをクリックするとタイムライン一覧画面に遷移すること' do
    login_as(user)
    visit profile_path
    click_link 'タイムライン'
    expect(page).to have_current_path posts_path, ignore_query: true
  end

  it 'サイドバーの下書きをクリックすると下書き一覧画面に遷移すること' do
    login_as(user)
    visit profile_path
    click_link '下書き'
    expect(page).to have_current_path drafts_path, ignore_query: true
  end

  it 'サイドバーのフォロー/フォロワーをクリックするとフォロー一覧画面に遷移すること' do
    login_as(user)
    visit profile_path
    click_link 'フォロー/フォロワー'
    expect(page).to have_current_path following_user_path(user), ignore_query: true
  end

  it 'サイドバーのお気に入りをクリックするとブックマークに遷移すること' do
    login_as(user)
    visit profile_path
    click_link 'お気に入り'
    expect(page).to have_current_path bookmarks_posts_path, ignore_query: true
  end
end
