class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_body_parts, dependent: :destroy
  has_many :body_parts, through: :workout_body_parts

  has_many_attached :workout_images do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :workout_date, presence: true
  validates :workout_title, presence: true
  validates :workout_time, presence: true
  validates :workout_weight, presence: true
  validates :repetition_count, presence: true
  validates :set_count, presence: true
  validates :workout_images, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg|jpg)\Z}, maximum: 5_242_880 }
  self.implicit_order_column = 'created_at'
end
