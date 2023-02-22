require 'rails_helper'

RSpec.describe MealForm do
  let(:user) { create(:user) }
  let(:params) do
    {
      meal_date: Time.current,
      meal_period: 1,
      meal_type: 1,
      meal_title_first: '唐揚げ',
      meal_weight_first: 200,
      meal_calorie_first: 500,
      user_id: user.id
    }
  end

  before do
    @meal = described_class.new
    @meal.assign_attributes(**params)
    @meal.save
  end

  describe 'validation' do
    it '日付、食事タイミング、食事種別、食事メニュー名、カロリー、グラム数が入力されていれば有効であること' do
      @meal.valid?
      expect(@meal).to be_valid
    end

    it '日付が入力されていいなければ無効な状態であること' do
      @meal.meal_date = ''
      @meal.valid?
      expect(@meal.errors[:meal_date]).to include('を入力してください')
    end

    it '食事タイミングが入力されていいなければ無効な状態であること' do
      @meal.meal_period = ''
      @meal.valid?
      expect(@meal.errors[:meal_period]).to include('を入力してください')
    end

    it '食事タイプが入力されていいなければ無効な状態であること' do
      @meal.meal_type = ''
      @meal.valid?
      expect(@meal.errors[:meal_type]).to include('を入力してください')
    end

    it 'メニュー名が入力されていいなければ無効な状態であること' do
      @meal.meal_title_first = ''
      @meal.valid?
      expect(@meal.errors[:meal_title_first]).to include('を入力してください')
    end

    it 'メニュー名が21文字以上では無効な状態であること' do
      @meal.meal_title_first = ('a' * 21).to_s
      @meal.valid?
      expect(@meal.errors[:meal_title_first]).to include('は20文字以内で入力してください')
    end

    it 'グラム数がないと無効な状態であること' do
      @meal.meal_weight_first = ''
      @meal.valid?
      expect(@meal.errors[:meal_weight_first]).to include('を入力してください')
    end

    it 'カロリーがないと無効な状態であること' do
      @meal.meal_calorie_first = ''
      @meal.valid?
      expect(@meal.errors[:meal_calorie_first]).to include('を入力してください')
    end

    it '食事メモが101文字以上では無効な状態であること' do
      @meal.meal_memo = ('a' * 101).to_s
      @meal.valid?
      expect(@meal.errors[:meal_memo]).to include('は100文字以内で入力してください')
    end
  end
end
