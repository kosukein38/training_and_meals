require 'rails_helper'

RSpec.describe 'MealLikes', js: true do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe '食事投稿へのいいね機能' do
    before do
      user.relationships.create!(followed_id: other_user.id)
      user.reverse_of_relationships.create!(follower_id: other_user.id)

      meal = MealForm.new
      meal.assign_attributes(
        meal_date: Time.current,
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
      )
      meal.save
      @my_meal = Meal.find_by!(user_id: user.id)

      meal = MealForm.new
      meal.assign_attributes(
        meal_date: 3.days.ago,
        meal_period: 1,
        meal_type: 1,
        meal_title_first: 'カレーライス',
        meal_weight_first: 200,
        meal_calorie_first: 500,
        meal_title_second: 'サラダ',
        meal_weight_second: 100,
        meal_calorie_second: 50,
        meal_title_third: '味噌汁',
        meal_weight_third: 100,
        meal_calorie_third: 100,
        user_id: other_user.id
      )
      meal.save
      @other_meal = Meal.find_by!(user_id: other_user.id)
    end

    context 'ログインユーザー' do
      it '自分の投稿にいいね、いいね解除できること（マイページ）' do
        login_as(user)
        visit user_path(user)
        sleep 1.5
        expect do
          find("#meal-like-button-#{@my_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#meal-like-button-#{@my_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（全ユーザー投稿一覧）' do
        login_as(user)
        visit meals_path
        sleep 1.5
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（フォロー中ユーザー投稿一覧）' do
        login_as(user)
        visit meals_feed_path
        sleep 1.5
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（投稿詳細）' do
        login_as(user)
        visit meal_path(@other_meal)
        sleep 1.5
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.to change(MealLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end
    end

    context '未ログインユーザー' do
      it '他人の投稿にいいねできないこと（投稿一覧）' do
        visit meals_path
        sleep 1.5
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.not_to change(MealLike, :count)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいねできないこと（投稿詳細）' do
        visit meal_path(@other_meal)
        sleep 1.5
        expect do
          find("#meal-like-button-#{@other_meal.id}").click
          visit current_path
        end.not_to change(MealLike, :count)
        expect(page).to have_css '.text-primary'
      end

      it 'いいねした人一覧を見れないこと' do
        visit meal_path(@other_meal)
        click_link 'いいね'
        expect(page).to have_content 'ログインしてください'
      end
    end

    describe '食事投稿のいいね一覧' do
      context 'いいねがある場合' do
        it 'ログインユーザーがいいねした人の一覧が見れること' do
          login_as(user)
          visit meals_path
          sleep 1.5
          expect do
            find("#meal-like-button-#{@other_meal.id}").click
            visit current_path
          end.to change(MealLike, :count).by(1)
          click_on @other_meal.meal_date.strftime('%Y年%m月%d日')
          click_link 'いいね'
          expect(page).to have_content 'いいねしたユーザー'
          expect(page).to have_content user.name
        end
      end

      context 'いいねがない場合' do
        it 'ログインユーザーに「いいねはありません」と表示されること' do
          login_as(user)
          visit meals_path
          click_on @other_meal.meal_date.strftime('%Y年%m月%d日')
          click_link 'いいね'
          expect(page).to have_content 'いいねしたユーザー'
          expect(page).to have_content 'いいねはありません'
        end
      end
    end
  end
end
