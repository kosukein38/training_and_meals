class BodyPart < ApplicationRecord
  has_many :workout_body_parts, dependent: :destroy
  self.implicit_order_column = "created_at"
end
