class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_details, dependent: :destroy
end
