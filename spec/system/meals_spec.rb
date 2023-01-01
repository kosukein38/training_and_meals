require 'rails_helper'

RSpec.describe 'Meals', js: true do
  let(:user) { create(:user) }

  before do
    MealForm.new(
      meal_period: 1,
      meal_type: 1,
      meal_title_first: '唐揚げ',
      meal_weight_first: 200,
      meal_calorie_first: 500,
      meal_title_second: 'サラダ',
      meal_weight_second: 100,
      meal_calorie_second: 50,
      meal_title_third: '味噌汁',
      meal_weight_third: 100,
      meal_calorie_third: 100,
      user_id: user.id
    ).save
  end

  it '新規食事投稿画面から食事の記録を登録できること' do
    login_as(user)
    visit new_meal_path
    select '昼食', from: '食事タイミング'
    select '外食', from: '食事タイプ'
    fill_in 'メニューその1', with: '唐揚げ'
    fill_in 'meal_form_meal_weight_first', with: 200
    fill_in 'meal_form_meal_calorie_first', with: 500
    fill_in 'メニューその2', with: '唐揚げ'
    fill_in 'meal_form_meal_weight_second', with: 200
    fill_in 'meal_form_meal_calorie_second', with: 500
    fill_in 'メニューその3', with: '唐揚げ'
    fill_in 'meal_form_meal_weight_third', with: 200
    fill_in 'meal_form_meal_calorie_third', with: 500
    fill_in 'メモ', with: '唐揚げおいしい'
    attach_file 'meal_form[meal_images][]', "#{Rails.root}/spec/fixtures/images/sample_man.png"
    click_button '投稿する'
    expect(page).to have_content '食事投稿を作成しました'
    expect(page).to have_selector("img[src$='sample_man.png']")
    expect(page).to have_current_path user_path(user), ignore_query: true
  end

  it 'マイページの食事投稿をクリックすると食事詳細画面が表示されること' do
    login_as(user)
    visit user_path(user)
    click_on '昼食'
    expect(page).to have_content '食事詳細'
    # current_pathのチェック追加
  end

  it '食事詳細画面の編集ボタンをクリックすると編集画面に遷移すること' do
    login_as(user)
    visit user_path(user)
    click_on '昼食'
    click_button '編集'
    expect(page).to have_content '食事編集'
    # current_pathのチェック追加
  end

  it '食事編集から項目を入力して更新をクリックすると更新できること' do
    login_as(user)
    visit user_path(user)
    click_on '昼食'
    click_button '編集'
    select '昼食', from: '食事タイミング'
    select '自炊', from: '食事タイプ'
    fill_in 'メニューその1', with: 'お弁当'
    fill_in 'meal_meal_weight_first', with: 200
    fill_in 'meal_meal_calorie_first', with: 500
    fill_in 'メニューその2', with: '味噌汁'
    fill_in 'meal_meal_weight_second', with: 120
    fill_in 'meal_meal_calorie_second', with: 100
    fill_in 'メニューその3', with: 'ジュース'
    fill_in 'meal_meal_weight_third', with: 100
    fill_in 'meal_meal_calorie_third', with: 80
    fill_in 'メモ', with: 'お弁当おいしい'
    attach_file 'meal[meal_images][]', "#{Rails.root}/spec/fixtures/images/sample.png"
    click_button '更新する'
    expect(page).to have_content '食事投稿を更新しました'
    expect(page).to have_selector("img[src$='sample.png']")
    expect(page).to have_current_path user_path(user), ignore_query: true
  end

  it '食事編集画面で削除をクリックすると削除できること' do
    login_as(user)
    visit user_path(user)
    click_on '昼食'
    click_button '編集'
    page.accept_confirm do
      click_on '削除する'
    end
    expect(page).to have_content '食事投稿を削除しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end
end
