require 'rails_helper'

RSpec.describe 'WorkoutLikes', js: true do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe '筋トレ投稿へのいいね機能' do
    before do
      user.relationships.create!(followed_id: other_user.id)
      user.reverse_of_relationships.create!(follower_id: other_user.id)

      body_part_id_mune = BodyPart.find_by(body_part_name: '胸').id
      body_part_id_kata = BodyPart.find_by(body_part_name: '肩').id
      workout = WorkoutForm.new
      workout.assign_attributes(
        workout_date: Time.current,
        workout_title: 'ベンチプレス1',
        body_part_ids: [body_part_id_mune, body_part_id_kata],
        workout_time: 30,
        workout_weight: 60,
        repetition_count: 10,
        set_count: 3,
        user_id: user.id
      )
      workout.save
      @my_workout = Workout.find_by!(user_id: user.id)

      body_part_id_mune = BodyPart.find_by(body_part_name: '胸').id
      body_part_id_kata = BodyPart.find_by(body_part_name: '肩').id
      workout = WorkoutForm.new
      workout.assign_attributes(
        workout_date: Time.current,
        workout_title: 'ベンチプレス2',
        body_part_ids: [body_part_id_mune, body_part_id_kata],
        workout_time: 30,
        workout_weight: 60,
        repetition_count: 10,
        set_count: 3,
        user_id: other_user.id
      )
      workout.save
      @other_workout = Workout.find_by!(user_id: other_user.id)
    end

    context 'ログインユーザー' do
      it '自分の投稿にいいね、いいね解除できること（マイページ）' do
        login_as(user)
        visit user_path(user)
        sleep 1.5
        expect do
          find("#workout-like-button-#{@my_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#workout-like-button-#{@my_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（全ユーザー投稿一覧）' do
        login_as(user)
        visit workouts_path
        sleep 1.5
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（フォロー中ユーザー投稿一覧）' do
        login_as(user)
        visit workouts_feed_path
        sleep 1.5
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいね、いいね解除できること（投稿詳細）' do
        login_as(user)
        visit workout_path(@other_workout)
        sleep 1.5
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(1)
        expect(page).to have_css '.fill-rose-500'
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.to change(WorkoutLike, :count).by(-1)
        expect(page).to have_css '.text-primary'
      end
    end

    context '未ログインユーザー' do
      it '他人の投稿にいいねできないこと（投稿一覧）' do
        visit workouts_path
        sleep 1.5
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.not_to change(WorkoutLike, :count)
        expect(page).to have_css '.text-primary'
      end

      it '他人の投稿にいいねできないこと（投稿詳細）' do
        visit workout_path(@other_workout)
        sleep 1.5
        expect do
          find("#workout-like-button-#{@other_workout.id}").click
          visit current_path
        end.not_to change(WorkoutLike, :count)
        expect(page).to have_css '.text-primary'
      end

      it 'いいねした人一覧を見れないこと' do
        visit workout_path(@other_workout)
        click_link 'いいね'
        expect(page).to have_content 'ログインしてください'
      end
    end

    describe '筋トレ投稿のいいね一覧' do
      context 'いいねがある場合' do
        it 'ログインユーザーがいいねした人の一覧が見れること' do
          login_as(user)
          visit workouts_path
          sleep 1.5
          expect do
            find("#workout-like-button-#{@other_workout.id}").click
            visit current_path
          end.to change(WorkoutLike, :count).by(1)
          click_on @other_workout.workout_title
          click_link 'いいね'
          expect(page).to have_content 'いいねしたユーザー'
          expect(page).to have_content user.name
        end
      end

      context 'いいねがない場合' do
        it 'ログインユーザーに「いいねはありません」と表示されること' do
          login_as(user)
          visit workouts_path
          click_on @other_workout.workout_title
          click_link 'いいね'
          expect(page).to have_content 'いいねしたユーザー'
          expect(page).to have_content 'いいねはありません'
        end
      end
    end
  end
end
