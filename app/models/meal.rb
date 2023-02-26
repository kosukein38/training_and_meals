class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_details, dependent: :destroy
  has_many :meal_likes, dependent: :destroy
  has_many :likes, through: :meal_likes

  has_many_attached :meal_images do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :meal_images, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg|jpg)\Z}, maximum: 5_242_880 }

  enum meal_period: { breakfast: 0, lunch: 1, dinner: 2, nosh: 3 }
  enum meal_type: { self_catering: 0, eating_out: 1, to_go: 2, convenience_store: 3 }

  self.implicit_order_column = 'created_at'

  def self.meals_today
    input_date = Time.zone.today
    where(meal_date: input_date.beginning_of_day...input_date.end_of_day).order(created_at: :desc)
  end

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end
end
