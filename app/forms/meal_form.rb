class MealForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :meal_period, :integer
  attribute :meal_type, :integer
  attribute :meal_memo, :string
  attribute :user_id, :big_integer

  attribute :meal_title_first, :string
  attribute :meal_weight_first, :integer
  attribute :meal_calorie_first, :integer
  attribute :meal_title_second, :string
  attribute :meal_weight_second, :integer
  attribute :meal_calorie_second, :integer
  attribute :meal_title_third, :string
  attribute :meal_weight_third, :integer
  attribute :meal_calorie_third, :integer

  attribute :meal_id, :big_integer

  validates :meal_title_first, presence: true
  validates :meal_weight_first, presence: true
  validates :meal_calorie_first, presence: true

  def save
    return false if invalid?

    meal = Meal.create(meal_period:, meal_type:, meal_memo:, user_id:)
    meal.meal_details.build(meal_title: meal_title_first, meal_weight: meal_weight_first, meal_calorie: meal_calorie_first).save
    if meal_title_second.present?
      meal.meal_details.build(meal_title: meal_title_second, meal_weight: meal_weight_second,
                              meal_calorie: meal_calorie_second).save
    end
    if meal_title_third.present?
      meal.meal_details.build(meal_title: meal_title_third, meal_weight: meal_weight_third,
                              meal_calorie: meal_calorie_third).save
    end
    meal
  end

  def update
    return false if invalid?

    meal = Meal.find(meal_id)
    meal.update!(meal_period:, meal_type:, meal_memo:, user_id:)
    MealDetail.where(meal_id: meal.id).delete_all
    meal.meal_details.build(meal_title: meal_title_first, meal_weight: meal_weight_first, meal_calorie: meal_calorie_first).save
    if meal_title_second.present?
      meal.meal_details.build(meal_title: meal_title_second, meal_weight: meal_weight_second,
                              meal_calorie: meal_calorie_second).save
    end
    if meal_title_third.present?
      meal.meal_details.build(meal_title: meal_title_third, meal_weight: meal_weight_third,
                              meal_calorie: meal_calorie_third).save
    end
    meal
  end
end
