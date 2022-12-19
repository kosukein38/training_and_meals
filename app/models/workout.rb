class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_body_parts, dependent: :destroy
  has_many :body_parts, through: :workout_body_parts
end
