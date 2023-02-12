class MealLike < ApplicationRecord
  belongs_to :meal
  belongs_to :like
end
