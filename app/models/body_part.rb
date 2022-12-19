class BodyPart < ApplicationRecord
  has_many :workout_body_parts, dependent: :destroy
end
