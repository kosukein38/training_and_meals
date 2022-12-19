require 'rails_helper'

RSpec.describe "Workouts", type: :system do
  let(:user) { create(:user) }

  it '新規筋トレ投稿画面から筋トレの記録（種目名、トレーニング時間、重量、回数、セット数）を登録できること' do
    login_as(user)
    visit new_workout_path
    select '胸', from: '筋トレ部位'
    fill_in '種目名', with: 'ベンチプレス'
    fill_in 'トレーニーング時間(分)', with: '30'
    fill_in '重量', with: '80.5'
    fill_in '回数', with: '10'
    fill_in 'セット数', with: '3'
    fill_in 'メモ', with: '10'
    click_button '投稿する'
    expect(page).to have_content '筋トレ投稿を作成しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end
end
