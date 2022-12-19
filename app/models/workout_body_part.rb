class WorkoutBodyPart < ApplicationRecord
  belongs_to :workout
  belongs_to :body_part
end
