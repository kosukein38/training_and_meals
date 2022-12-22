require 'rails_helper'

RSpec.describe 'WorkoutForms' do
  let(:user) { create(:user) }

  it '新規筋トレ投稿画面から筋トレの記録（種目名、トレーニング時間、重量、回数、セット数）を登録できること' do
    login_as(user)
    visit new_workout_path
    fill_in '筋トレ日', with: '2022-12-18 14:33:52'
    fill_in '種目名', with: 'ベンチプレス'
    check '胸'
    fill_in 'トレーニーング時間(分)', with: '30'
    fill_in '重量', with: '80.5'
    fill_in '回数', with: '10'
    fill_in 'セット数', with: '3'
    click_button '投稿する'
    expect(page).to have_content '筋トレ投稿を作成しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end
end
