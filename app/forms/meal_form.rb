class MealForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :meal_period, :integer
  attribute :meal_type, :integer
  attribute :meal_memo, :string
  attribute :user_id, :big_integer
  attribute :meal_title, :string
  attribute :meal_weight, :integer
  attribute :meal_calorie, :integer
  attribute :meal_id, :big_integer
  
  validates :meal_title, presence: true
  validates :meal_weight, presence: true
  validates :meal_calorie, presence: true

  def save
    return false if invalid?
    meal = Meal.create(meal_period:, meal_type:, meal_memo:, user_id:)
    MealDetail.create(meal_title:, meal_weight:, meal_calorie:, meal_id: meal.id)
  end
end
