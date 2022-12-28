require 'rails_helper'

RSpec.describe "Home", js: true do
  let(:user) { create(:user) }

  it 'サイドバーのタイムラインをクリックすると筋トレのタイムラインが表示されること' do
    login_as(user)
    click_on 'タイムライン'
    expect(page).to have_content 'タイムライン -筋トレ-'
    expect(page).to have_current_path home_workouts_path, ignore_query: true
  end
  it '食事タイムラインへボタンをクリックすると食事タイムラインが表示されること' do
    login_as(user)
    click_on 'タイムライン'
    click_button '食事のタイムラインへ'
    expect(page).to have_content 'タイムライン -食事-'
    expect(page).to have_current_path home_meals_path, ignore_query: true
  end
end
