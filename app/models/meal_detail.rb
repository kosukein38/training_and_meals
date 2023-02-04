class MealDetail < ApplicationRecord
  belongs_to :meal
  validates :meal_title, presence: true
  validates :meal_weight, presence: true
  validates :meal_calorie, presence: true
  self.implicit_order_column = 'created_at'
end
