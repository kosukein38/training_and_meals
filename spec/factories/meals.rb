FactoryBot.define do
  factory :meal do
    meal_period { 1 }
    meal_type { 1 }
    meal_memo { 'MyText' }
    association :user
  end
end
