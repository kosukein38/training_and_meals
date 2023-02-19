class WorkoutLike < ApplicationRecord
  belongs_to :workout
  belongs_to :like
  self.implicit_order_column = 'created_at'
  validates :like_id, uniqueness: { scope: :workout_id }
end
