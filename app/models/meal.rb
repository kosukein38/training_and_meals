class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_details, dependent: :destroy

  enum meal_period: { breakfast: 0, lunch: 1, dinner: 2, nosh: 3 }
  enum meal_type: { self_catering: 0, eating_out: 1, to_go: 2, convenience_store: 3 }
end
