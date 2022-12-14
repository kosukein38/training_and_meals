require 'rails_helper'

RSpec.describe 'Profiles' do
  let(:user) { create(:user) }

  it 'プロフィール登録すると、メンテナンスカロリーと目標カロリーが登録され、表示されること' do
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
  
  it 'プロフィール登録すると、プロフィール表示画面に遷移し、情報が表示されること' do
    login_as(user)
    visit edit_profile_path
    visit edit_profile_path
    fill_in '身長', with: user.height
    fill_in '体重', with: user.body_weight
    fill_in '年齢', with: user.age
    select '男性', from: '生まれた時の性別'
    select 'レベル1', from: '活動量'
    click_button '更新する'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(page).to have_current_path profile_path(user), ignore_query: true
  end
end
