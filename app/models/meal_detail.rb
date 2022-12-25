class MealDetail < ApplicationRecord
  belongs_to :meal
  validates :meal_title, presence: true
  validates :meal_weight, presence: true
  validates :meal_calorie, presence: true
end
