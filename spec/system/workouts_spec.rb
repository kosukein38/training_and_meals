require 'rails_helper'

RSpec.describe 'Workouts', js: true do
  let(:user) { create(:user) }

  describe '筋トレ投稿のCRUD' do
    before do
      body_part_id_mune = BodyPart.find_by(body_part_name: '胸').id
      body_part_id_kata = BodyPart.find_by(body_part_name: '肩').id
      workout = WorkoutForm.new
      workout.assign_attributes(
        workout_date: Time.current,
        workout_title: 'ベンチプレス',
        body_part_ids: [body_part_id_mune, body_part_id_kata],
        workout_time: 30,
        workout_weight: 60,
        repetition_count: 10,
        set_count: 3,
        user_id: user.id
      )
      workout.save
    end

    describe '筋トレ投稿の作成' do
      it '新規筋トレ投稿画面から筋トレの記録（種目名、トレーニング時間、重量、回数、セット数）を登録できること' do
        login_as(user)
        visit new_workout_path
        fill_in '筋トレ日(必須)', with: Time.current
        fill_in '種目名(必須)', with: 'ベンチプレス'
        check '胸'
        fill_in 'トレーニーング時間(分)(必須)', with: 30
        fill_in '重量(必須)', with: 80.5
        fill_in '回数(必須)', with: 10
        fill_in 'セット数(必須)', with: 3
        attach_file 'workout[workout_images][]', Rails.root.join('spec/fixtures/images/sample_man.png')
        click_button '投稿する'
        expect(page).to have_content '筋トレ投稿を作成しました'
        expect(page).to have_selector("img[src$='sample_man.png']")
        expect(page).to have_current_path user_path(user), ignore_query: true
      end
    end

    describe '筋トレ投稿の一覧表示' do
      context 'ログインユーザー' do
        it 'マイページからフォロー中ユーザーの筋トレ投稿一覧を表示できること' do
          login_as(user)
          visit user_path(user)
          find('.to-workouts-index').click
          click_on 'フォロー中'
          expect(page).to have_content 'フォローユーザーの筋トレ投稿'
        end

        it 'マイページから全ユーザーの筋トレ投稿一覧を表示できること' do
          login_as(user)
          visit user_path(user)
          find('.to-workouts-index').click
          click_on '全ユーザー'
          expect(page).to have_content '全ユーザーの筋トレ投稿'
        end
      end

      context '未ログインユーザー' do
        it 'トップページから全ユーザーの筋トレ投稿一覧を表示できること' do
          visit root_path
          find('.to-index').click
          click_on '筋トレ投稿一覧'
          expect(page).to have_content '全ユーザーの筋トレ投稿'
        end
      end
    end

    describe '筋トレ投稿の表示' do
      context 'ログインユーザー' do
        it 'マイページの筋トレ投稿をクリックすると筋トレ詳細画面が表示されること' do
          login_as(user)
          visit user_path(user)
          click_on 'ベンチプレス'
          expect(page).to have_content '筋トレ詳細'
        end
      end

      context '未ログインユーザー' do
        it '一覧画面の筋トレ投稿をクリックすると筋トレ詳細画面が表示されること' do
          visit workouts_path
          click_on 'ベンチプレス'
          expect(page).to have_content '筋トレ詳細'
        end
      end
    end

    describe '筋トレ投稿の編集' do
      it '筋トレ詳細画面の編集ボタンをクリックすると編集画面に遷移すること' do
        login_as(user)
        visit user_path(user)
        click_on 'ベンチプレス'
        click_button '編集'
        expect(page).to have_content '筋トレ編集'
      end
    end

    describe '筋トレ投稿の更新' do
      context '自分の投稿の場合' do
        it '筋トレ編集から項目を入力して更新をクリックすると更新できること' do
          login_as(user)
          visit user_path(user)
          click_on 'ベンチプレス'
          click_button '編集'
          fill_in '筋トレ日(必須)', with: Time.current
          fill_in '種目名(必須)', with: 'ベンチプレス'
          check '胸'
          check '肩'
          fill_in 'トレーニーング時間(分)(必須)', with: 40
          fill_in '重量(必須)', with: 90.4
          fill_in '回数(必須)', with: 10
          fill_in 'セット数(必須)', with: 3
          click_button '更新する'
          expect(page).to have_content '筋トレ投稿を更新しました'
          expect(page).to have_current_path user_path(user), ignore_query: true
        end

        it '筋トレ投稿編集から画像を変更できること' do
          login_as(user)
          visit user_path(user)
          click_on 'ベンチプレス'
          click_button '編集'
          attach_file 'workout[workout_images][]', Rails.root.join('spec/fixtures/images/sample.png')
          click_button '更新する'
          expect(page).to have_content '筋トレ投稿を更新しました'
          expect(page).to have_selector("img[src$='sample.png']")
          expect(page).to have_current_path user_path(user), ignore_query: true
        end

        it 'png,jpeg,jpg以外の拡張子以外のファイルをアップロードできないこと' do
          login_as(user)
          visit user_path(user)
          click_on 'ベンチプレス'
          click_button '編集'
          attach_file 'workout[workout_images][]', Rails.root.join('spec/fixtures/error.txt')
          click_button '更新する'
          expect(page).to have_content '筋トレ投稿を更新できませんでした'
          expect(page).to have_content '対応できないファイル形式です'
        end

        it '5MBを超える画像をアップロードできないこと' do
          login_as(user)
          visit user_path(user)
          click_on 'ベンチプレス'
          click_button '編集'
          attach_file 'workout[workout_images][]', Rails.root.join('spec/fixtures/images/large_image.png')
          click_button '更新する'
          expect(page).to have_content '筋トレ投稿を更新できませんでした'
          expect(page).to have_content '5MB以下にしてください'
        end
      end

      context '他人の投稿の場合' do
        it '他人の投稿を編集できないこと' do
          another_user = create(:user)
          login_as(another_user)
          visit workouts_path
          click_on 'ベンチプレス'
          expect(page).not_to have_content '編集'
        end
      end
    end

    describe '筋トレ投稿の削除' do
      it '筋トレ編集画面で削除をクリックすると削除できること' do
        login_as(user)
        visit user_path(user)
        click_on 'ベンチプレス'
        click_button '編集'
        page.accept_confirm do
          page.first('.workout-delete').click
        end
        expect(page).to have_content '筋トレ投稿を削除しました'
        expect(page).to have_current_path user_path(user), ignore_query: true
      end
    end
  end
end
