class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_body_parts, dependent: :destroy
  has_many :body_parts, through: :workout_body_parts
  has_many :workout_likes, dependent: :destroy
  has_many :workout_like_users, through: :workout_likes, source: :user

  has_many_attached :workout_images do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :workout_images, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg|jpg)\Z}, maximum: 5_242_880 }
  self.implicit_order_column = 'created_at'

  def self.workouts_today
    input_date = Time.zone.today
    where(workout_date: input_date.beginning_of_day...input_date.end_of_day).order(created_at: :desc)
  end

  def start_time
    workout_date
  end
end
