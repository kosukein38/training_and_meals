class Like < ApplicationRecord
  belongs_to :user
  has_many :workout_likes, dependent: :destroy
  has_many :meal_likes, dependent: :destroy
  self.implicit_order_column = 'created_at'
end
