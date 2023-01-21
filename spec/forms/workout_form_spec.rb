require 'rails_helper'

RSpec.describe WorkoutForm, type: :model do
  let(:user) { create(:user) }
  let(:workout_form) do
    described_class.new(
      workout_date: '2022-12-18 14:33:52',
      workout_title: 'ベンチプレス',
      body_part_ids: [1, 2],
      workout_time: 30,
      workout_weight: 60,
      repetition_count: 10,
      set_count: 3,
      user_id: user.id
    )
  end

  describe 'validation' do
    xit '筋トレ日、種目名、筋トレ部位、トレーニング時間（分）、重量、回数、セット数、が入力されていれば有効な状態であること' do
      workout_form.valid?
      expect(workout_form).to be_valid
    end

    xit '筋トレ日が入力されていいなければ無効な状態であること' do
      workout_form.workout_date = ''
      workout_form.valid?
      expect(workout_form.errors[:workout_date]).to include('を入力してください')
    end

    xit '種目名が入力されていいなければ無効な状態であること' do
      workout_form.workout_title = ''
      workout_form.valid?
      expect(workout_form.errors[:workout_title]).to include('を入力してください')
    end

    xit '筋トレ部位が入力されていいなければ無効な状態であること' do
      workout_form.body_part_ids = []
      workout_form.valid?
      expect(workout_form.errors[:body_part_ids]).to include('を入力してください')
    end

    xit 'トレーニング時間（分）が入力されていいなければ無効な状態であること' do
      workout_form.workout_time = ''
      workout_form.valid?
      expect(workout_form.errors[:workout_time]).to include('を入力してください')
    end

    xit '重量が入力されていいなければ無効な状態であること' do
      workout_form.workout_weight = ''
      workout_form.valid?
      expect(workout_form.errors[:workout_weight]).to include('を入力してください')
    end

    xit '回数が入力されていいなければ無効な状態であること' do
      workout_form.repetition_count = ''
      workout_form.valid?
      expect(workout_form.errors[:repetition_count]).to include('を入力してください')
    end

    xit 'セット数が入力されていいなければ無効な状態であること' do
      workout_form.set_count = ''
      workout_form.valid?
      expect(workout_form.errors[:set_count]).to include('を入力してください')
    end
  end
end
