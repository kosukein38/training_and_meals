require 'rails_helper'

RSpec.describe 'Profiles' do
  let(:user) { create(:user) }

  it 'プロフィール登録するすると、メンテナンスカロリーと目標カロリーが登録され、表示されること' do
    login_as(user)
    visit edit_profile_path
    fill_in '身長', with: user.height
    fill_in '体重', with: user.body_weight
    fill_in '年齢', with: user.age
    select '男', from: 'Sex'
    select 'レベル1', from: 'Active level'
    click_button '計算する'
    expect(page).to have_content 'あなたの目標摂取カロリーは１日あたり'
    expect(page).to have_current_path edit_profile_path, ignore_query: true
  end
end
