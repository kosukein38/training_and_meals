require 'rails_helper'

RSpec.describe 'Workouts' do
  let(:user) { create(:user) }
  let!(:workout) do
    WorkoutForm.new(
      workout_date: Time.current,
      workout_title: 'ベンチプレス',
      body_part_ids: [1, 2],
      workout_time: 30,
      workout_weight: 60,
      repetition_count: 10,
      set_count: 3,
      user_id: user.id
    ).save
  end

  it '新規筋トレ投稿画面から筋トレの記録（種目名、トレーニング時間、重量、回数、セット数）を登録できること' do
    login_as(user)
    visit new_workout_path
    fill_in '筋トレ日', with: Time.current
    fill_in '種目名', with: 'ベンチプレス'
    check '胸'
    fill_in 'トレーニーング時間(分)', with: 30
    fill_in '重量', with: 80.5
    fill_in '回数', with: 10
    fill_in 'セット数', with: 3
    click_button '投稿する'
    expect(page).to have_content '筋トレ投稿を作成しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end

  it 'マイページの筋トレ投稿をクリックすると筋トレ詳細画面が表示されること' do
    login_as(user)
    visit user_path(user)
    click_on 'ベンチプレス'
    expect(page).to have_content '筋トレ詳細'
    # current_pathのチェック追加
  end

  it '筋トレ詳細画面の編集ボタンをクリックすると編集画面に遷移すること' do
    login_as(user)
    visit user_path(user)
    click_on 'ベンチプレス'
    click_button '編集'
    expect(page).to have_content '筋トレ編集'
    # current_pathのチェック追加
  end

  it '筋トレ編集から項目を入力して更新をクリックすると更新できること' do
    login_as(user)
    visit user_path(user)
    click_on 'ベンチプレス'
    click_button '編集'
    fill_in '筋トレ日', with: Time.current
    fill_in '種目名', with: 'ベンチプレス'
    check '胸'
    check '肩'
    fill_in 'トレーニーング時間(分)', with: 40
    fill_in '重量', with: 90.4
    fill_in '回数', with: 10
    fill_in 'セット数', with: 3
    click_button '更新する'
    expect(page).to have_content '筋トレ投稿を更新しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end

  it '筋トレ編集画面で削除をクリックすると削除できること' do
    login_as(user)
    visit user_path(user)
    click_on 'ベンチプレス'
    click_button '編集'
    page.accept_confirm do
      click_on '削除する'
    end
    expect(page).to have_content '筋トレ投稿を削除しました'
    expect(page).not_to have_content '筋トレ投稿を削除しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end
end
