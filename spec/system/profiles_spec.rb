require 'rails_helper'

RSpec.describe 'Profiles' do
  let(:user) { create(:user) }

  it 'プロフィール登録するすると、メンテナンスカロリーと目標カロリーが登録され、表示されること' do
    login_as(user)
    visit edit_profile_path
    fill_in 'Height', with: user.height
    fill_in 'Body weight', with: user.body_weight
    fill_in 'Age', with: user.age
    select 'male', from: 'Sex'
    select 'level1', from: 'Active level'
    click_button '計算する'
    expect(page).to have_content 'あなたの目標摂取カロリーは１日あたり'
    expect(page).to have_current_path edit_profile_path, ignore_query: true
  end
end
