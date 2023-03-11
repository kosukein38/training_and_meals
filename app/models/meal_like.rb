class MealLike < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  self.implicit_order_column = 'created_at'
  validates :user_id, uniqueness: { scope: :meal_id }
end
