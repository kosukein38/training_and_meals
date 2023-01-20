class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_body_parts, dependent: :destroy
  has_many :body_parts, through: :workout_body_parts

  has_many_attached :workout_images do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end
end
