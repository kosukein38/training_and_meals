require 'rails_helper'

RSpec.describe WorkoutForm, type: :model do
  let(:user) { create(:user) }
  let(:params) do
    {
      workout_date: Time.current,
      workout_title: 'ベンチプレス',
      body_part_ids: [BodyPart.find_by(body_part_name: '胸').id, BodyPart.find_by(body_part_name: '肩').id],
      workout_time: 30,
      workout_weight: 60,
      repetition_count: 10,
      set_count: 3,
      user_id: user.id
    }
  end
  let!(:workout) do
    workout = described_class.new
    workout.assign_attributes(**params)
    workout.save
    # ここでのworkoutはWorkoutForm Class
  end

  describe 'validation' do
    it '筋トレ日、種目名、筋トレ部位、トレーニング時間（分）、重量、回数、セット数、が入力されていれば有効な状態であること' do
      # ここでのworkoutはWorkout Class
      workout.valid?
      expect(workout).to be_valid
    end

    it '筋トレ日が入力されていいなければ無効な状態であること' do
      workout.workout_date = ''
      workout.valid?
      expect(workout.errors[:workout_date]).to include('を入力してください')
    end

    it '種目名が入力されていいなければ無効な状態であること' do
      workout.workout_title = ''
      workout.valid?
      expect(workout.errors[:workout_title]).to include('を入力してください')
    end

    xit '筋トレ部位が入力されていいなければ無効な状態であること' do
      workout.body_part_ids = []
      workout.valid?
      expect(workout.errors[:body_part_ids]).to include('を入力してください')
    end

    it 'トレーニング時間（分）が入力されていいなければ無効な状態であること' do
      workout.workout_time = ''
      workout.valid?
      expect(workout.errors[:workout_time]).to include('を入力してください')
    end

    it '重量が入力されていいなければ無効な状態であること' do
      workout.workout_weight = ''
      workout.valid?
      expect(workout.errors[:workout_weight]).to include('を入力してください')
    end

    it '回数が入力されていいなければ無効な状態であること' do
      workout.repetition_count = ''
      workout.valid?
      expect(workout.errors[:repetition_count]).to include('を入力してください')
    end

    it 'セット数が入力されていいなければ無効な状態であること' do
      workout.set_count = ''
      workout.valid?
      expect(workout.errors[:set_count]).to include('を入力してください')
    end
  end
end
