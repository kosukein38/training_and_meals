class WorkoutLike < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  self.implicit_order_column = 'created_at'
  validates :user_id, uniqueness: { scope: :workout_id }
end
