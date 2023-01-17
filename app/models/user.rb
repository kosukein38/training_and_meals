class User < ApplicationRecord
  before_update :set_active_level_coefficient
  before_update :set_default_adjustment_calorie

  authenticates_with_sorcery!

  has_many :workouts, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :meal_details, through: :meals

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 30 }, presence: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :height, presence: true, on: :update
  validates :body_weight, presence: true, on: :update
  validates :age, presence: true, on: :update
  validates :sex, presence: true, on: :update
  validates :active_level, presence: true, on: :update

  enum sex: { male: 0, female: 1 }
  enum active_level: { level1: 1, level2: 2, level3: 3, level4: 4, level5: 5 }

  def own?(object)
    object.user_id == id
  end

  def save_self_calories
    self.maintenance_calorie = 
                                if self.sex == 'male'
                                    ((13.397 * body_weight) + (4.799 * height) - (5.677 * age) + 88.362) * @active_level_coefficient
                                else
                                    ((9.247 * body_weight) + (3.098 * height) - (4.33 * age) + 447.593) * @active_level_coefficient
                                end
    self.target_calorie = maintenance_calorie + adjustment_calorie
    save
  end

  private

  def set_active_level_coefficient
    @active_level_coefficient =
                                  case active_level
                                  when 'level1'
                                    1.2
                                  when 'level2'
                                    1.375
                                  when 'level3'
                                    1.55
                                  when 'level4'
                                    1.725
                                  when 'level5'
                                    1.9
                                  else
                                    1
                                  end
  end

  def set_default_adjustment_calorie
    self.adjustment_calorie = 0 if adjustment_calorie.blank?
  end
end
