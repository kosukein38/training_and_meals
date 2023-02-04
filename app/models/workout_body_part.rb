class WorkoutBodyPart < ApplicationRecord
  belongs_to :workout
  belongs_to :body_part
  self.implicit_order_column = "created_at"
end
