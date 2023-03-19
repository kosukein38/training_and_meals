require 'rails_helper'

RSpec.describe 'Meals', js: true do
  let(:user) { create(:user) }

  describe '食事投稿のCRUD' do
    before do
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
    end

    describe '食事投稿の作成' do
      it '新規食事投稿画面から食事の記録を登録できること' do
        login_as(user)
        visit new_meal_path
        2.times { find('.add').click }
        fill_in '日付', with: Time.current
        select '昼食', from: '食事タイミング(任意)'
        select '外食', from: '食事タイプ(任意)'
        fill_in 'メニュー1(必須)', with: '唐揚げ'
        fill_in 'meal_meal_weight_first', with: 200
        fill_in 'meal_meal_calorie_first', with: 500
        fill_in 'メニュー2(任意)', with: '唐揚げ'
        fill_in 'meal_meal_weight_second', with: 200
        fill_in 'meal_meal_calorie_second', with: 500
        fill_in 'メニュー3(任意)', with: '唐揚げ'
        fill_in 'meal_meal_weight_third', with: 200
        fill_in 'meal_meal_calorie_third', with: 500
        fill_in 'メモ', with: '唐揚げおいしい'
        attach_file 'meal[meal_images][]', Rails.root.join('spec/fixtures/images/sample_man.png')
        click_button '投稿する'
        expect(page).to have_content '食事投稿を作成しました'
        expect(page).to have_selector("img[src$='sample_man.png']")
        expect(page).to have_current_path user_path(user), ignore_query: true
      end

      describe '筋トレ投稿の一覧表示' do
        context 'ログインユーザー' do
          it 'マイページからフォロー中ユーザーの食事投稿一覧を表示できること' do
            login_as(user)
            visit user_path(user)
            find('.to-meals-index').click
            click_on 'フォロー中'
            expect(page).to have_content 'フォローユーザーの食事投稿'
          end

          it 'マイページから全ユーザーの食事投稿一覧を表示できること' do
            login_as(user)
            visit user_path(user)
            find('.to-meals-index').click
            click_on '全ユーザー'
            expect(page).to have_content '全ユーザーの食事投稿'
          end
        end

        context '未ログインユーザー' do
          it 'トップページから全ユーザーの食事投稿一覧を表示できること' do
            visit root_path
            find('.to-index').click
            click_on '食事投稿一覧'
            expect(page).to have_content '全ユーザーの食事投稿'
          end
        end
      end

      describe '筋トレ投稿の表示' do
        context 'ログインユーザー' do
          it 'マイページの食事投稿をクリックすると食事詳細画面が表示されること' do
            login_as(user)
            visit user_path(user)
            click_on '唐揚げ'
            expect(page).to have_content '食事詳細'
          end
        end

        context '未ログインユーザー' do
          it '一覧画面の食事投稿をクリックすると食事詳細画面が表示されること' do
            visit meals_path
            click_on '唐揚げ'
            expect(page).to have_content '食事詳細'
          end
        end
      end

      describe '食事投稿の編集' do
        it '食事詳細画面の編集ボタンをクリックすると編集画面に遷移すること' do
          login_as(user)
          visit user_path(user)
          click_on '唐揚げ'
          click_button '編集'
          expect(page).to have_content '食事編集'
        end
      end

      describe '食事投稿の更新' do
        context '自分の投稿の場合' do
          it '食事編集から項目を入力して更新をクリックすると更新できること' do
            login_as(user)
            visit user_path(user)
            click_on '唐揚げ'
            click_button '編集'
            fill_in '日付', with: Time.current
            select '昼食', from: '食事タイミング(任意)'
            select '自炊', from: '食事タイプ(任意)'
            fill_in 'メニュー1(必須)', with: 'お弁当'
            fill_in 'meal_meal_weight_first', with: 200
            fill_in 'meal_meal_calorie_first', with: 500
            fill_in 'メニュー2(任意)', with: '味噌汁'
            fill_in 'meal_meal_weight_second', with: 120
            fill_in 'meal_meal_calorie_second', with: 100
            fill_in 'メニュー3(任意)', with: 'ジュース'
            fill_in 'meal_meal_weight_third', with: 100
            fill_in 'meal_meal_calorie_third', with: 80
            fill_in 'メモ', with: 'お弁当おいしい'
            click_button '更新する'
            expect(page).to have_content '食事投稿を更新しました'
            expect(page).to have_current_path user_path(user), ignore_query: true
          end

          it '食事投稿編集から画像を変更できること' do
            login_as(user)
            visit user_path(user)
            click_on '唐揚げ'
            click_button '編集'
            attach_file 'meal[meal_images][]', Rails.root.join('spec/fixtures/images/sample.png')
            click_button '更新する'
            expect(page).to have_content '食事投稿を更新しました'
            expect(page).to have_selector("img[src$='sample.png']")
            expect(page).to have_current_path user_path(user), ignore_query: true
          end

          it 'png,jpeg,jpg以外の拡張子以外のファイルをアップロードできないこと' do
            login_as(user)
            visit user_path(user)
            click_on '唐揚げ'
            click_button '編集'
            attach_file 'meal[meal_images][]', Rails.root.join('spec/fixtures/error.txt')
            click_button '更新する'
            expect(page).to have_content '食事投稿を更新できませんでした'
            expect(page).to have_content '対応できないファイル形式です'
          end

          it '5MBを超える画像をアップロードできないこと' do
            login_as(user)
            visit user_path(user)
            click_on '唐揚げ'
            click_button '編集'
            attach_file 'meal[meal_images][]', Rails.root.join('spec/fixtures/images/large_image.png')
            click_button '更新する'
            expect(page).to have_content '食事投稿を更新できませんでした'
            expect(page).to have_content '5MB以下にしてください'
          end
        end

        context '他人の投稿の場合' do
          it '他人の投稿を編集できないこと' do
            another_user = create(:user)
            login_as(another_user)
            visit meals_path
            click_on '唐揚げ'
            expect(page).not_to have_content '編集'
          end
        end
      end

      describe '食事投稿の削除' do
        it '食事編集画面で削除をクリックすると削除できること' do
          login_as(user)
          visit user_path(user)
          click_on '唐揚げ'
          click_button '編集'
          page.accept_confirm do
            page.first('.meal-delete').click
          end
          expect(page).to have_content '食事投稿を削除しました'
          expect(page).to have_current_path user_path(user), ignore_query: true
        end
      end
    end
  end
end
