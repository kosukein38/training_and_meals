FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    height { 163.5 }
    body_weight { 85 }
    age { 32 }
    sex { 'male' }
    active_level { 'level1' }
  end
end
