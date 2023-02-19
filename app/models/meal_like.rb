class MealLike < ApplicationRecord
  belongs_to :meal
  belongs_to :like
  self.implicit_order_column = 'created_at'
  validates :like_id, uniqueness: { scope: :meal_id }
end
