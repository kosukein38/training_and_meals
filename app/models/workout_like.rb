class WorkoutLike < ApplicationRecord
  belongs_to :workout
  belongs_to :like
end
