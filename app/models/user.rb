class User < ApplicationRecord
  before_update :set_active_level_coefficient
  before_update :set_default_adjustment_calorie
  before_update :set_self_calories

  authenticates_with_sorcery!

  has_many :workouts, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :meal_details, through: :meals
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 30 }, presence: true
  validates :avatar, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg|jpg)\Z}, maximum: 5_242_880 }
  self.implicit_order_column = 'created_at'

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :height, presence: true, on: :update
  validates :body_weight, presence: true, on: :update
  validates :age, presence: true, on: :update
  validates :sex, presence: true, on: :update
  validates :active_level, presence: true, on: :update

  enum sex: { male: 0, female: 1 }
  enum active_level: { level1: 1, level2: 2, level3: 3, level4: 4, level5: 5 }
  enum role: { general: 0, admin: 1 }

  self.implicit_order_column = 'created_at'

  def own?(object)
    object.user_id == id
  end

  def follow(other_user)
    followings << other_user unless self == other_user
  end

  def unfollow(other_user)
    followings.delete(other_user)
  end

  def following?(other_user)
    followings.include?(other_user)
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

  def set_self_calories
    self.maintenance_calorie =
      if sex == 'male'
        ((13.397 * body_weight) + (4.799 * height) - (5.677 * age) + 88.362) * @active_level_coefficient
      else
        ((9.247 * body_weight) + (3.098 * height) - (4.33 * age) + 447.593) * @active_level_coefficient
      end
    self.target_calorie = maintenance_calorie + adjustment_calorie + 300
  end

  def set_default_adjustment_calorie
    self.adjustment_calorie ||= 0
  end
end
