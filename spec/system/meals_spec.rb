require 'rails_helper'

RSpec.describe 'Meals' do
  let(:user) { create(:user) }

  before do
    MealForm.new(
      meal_period: 'breakfast',
      meal_type: 'self_catering',
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
    click_button '投稿する'
    expect(page).to have_content '食事投稿を作成しました'
    expect(page).to have_current_path user_path(user), ignore_query: true
  end
end
